Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272643AbTG1Dx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 23:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272644AbTG1Dx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 23:53:29 -0400
Received: from yzma.clarkk.net ([65.161.115.64]:22454 "EHLO yzma.clarkk.net")
	by vger.kernel.org with ESMTP id S272643AbTG1Dx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 23:53:27 -0400
Date: Sun, 27 Jul 2003 23:08:39 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix attempts to use 16-bit PCMCIA w/o CONFIG_IDE
Message-ID: <20030728040839.GA15294@taral.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Using 16-bit PCMCIA drivers on a kernel compiled without CONFIG_IDE
results in very weird errors. This patch makes the errors a little less
strange. I suspect the correct solution may involve having 16-bit
drivers depend on CONFIG_IDE...

--- 1.29/drivers/pcmcia/cs.c	Fri May 30 00:42:33 2003
+++ edited/drivers/pcmcia/cs.c	Mon Jun  2 00:32:07 2003
@@ -1980,6 +1980,9 @@
 	    irq =3D req->IRQInfo1 & IRQ_MASK;
 	    ret =3D try_irq(req->Attributes, irq, 1);
 	}
+#else
+    } else {
+	ret =3D CS_UNSUPPORTED_MODE;
 #endif
     }
     if (ret !=3D 0) return ret;

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Most parents have better things to do with their time than take care of
their children." -- Me

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JKHHoQQF8xCPwJQRAjXhAJwOzYdjrgVDoKt7J5fsqfxsUINkQQCfYCMm
UXJ8tCB0lzexSR9ow8LiTz4=
=BlOF
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
