Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVBCFOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVBCFOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVBCFOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:14:03 -0500
Received: from nccn1.nccn.net ([209.79.220.11]:48330 "EHLO nccn1.nccn.net")
	by vger.kernel.org with ESMTP id S262850AbVBCFNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:13:45 -0500
Subject: PCMCIA bug in 2.6.11rc2
From: Josh Green <jgreen@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a+2bsV0yk/3eOFRogKjg"
Date: Wed, 02 Feb 2005 21:14:28 -0800
Message-Id: <1107407668.14009.5.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a+2bsV0yk/3eOFRogKjg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I found a bug in drivers/pcmcia/ds.c for version 2.6.11rc2 (from
linux-mips CVS) that was causing initialization problems with the second
card when I had two PCMCIA wireless cards in my AMD Alchemy DB1100
board.  Here is the patch:

--- ds.c.orig   2005-01-13 06:06:18.000000000 -0800
+++ ds.c        2005-02-02 11:58:29.000000000 -0800
@@ -660,7 +660,7 @@
                        p_dev =3D pcmcia_get_dev(p_dev);
                        if (!p_dev)
                                continue;
-                       if ((!p_dev->client.state & CLIENT_UNBOUND) ||
+                       if (!(p_dev->client.state & CLIENT_UNBOUND) ||
                            (!p_dev->dev.driver)) {
                                pcmcia_put_dev(p_dev);
                                continue;


Here is a link to the bitkeeper change that caused this:

http://linux.bkbits.net:8080/linux-2.6/diffs/drivers/pcmcia/ds.c@1.99?nav=
=3Dindex.html|src/|src/drivers|src/drivers/pcmcia|hist/drivers/pcmcia/ds.c

Please CC any responses to me, as I am not on the list.
	Best regards,
	Josh Green


--=-a+2bsV0yk/3eOFRogKjg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAbMzRoMuWKCcbgQRAm+YAKC6STuk4n3PRlVkk12WtUtVhLIoowCfWzdz
OeqKs0cMtRcm5zG8npcGI8g=
=9RIL
-----END PGP SIGNATURE-----

--=-a+2bsV0yk/3eOFRogKjg--

