Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTDHHHM (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 03:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTDHHHM (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 03:07:12 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:14795 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263532AbTDHHHK (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 03:07:10 -0400
Date: Tue, 8 Apr 2003 09:18:46 +0200
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] aic7* claims all checked EISA io ranges (was: [MAILER-DAEMON@rumms.uni-mannheim.de: Returned mail: see transcript for details])
Message-ID: <20030408071845.GA10002@schiele.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Robert Schiele <rschiele@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hmm, vger does not like the driver name of the Adaptec driver. ;-)

Robert

----- Forwarded message from Mail Delivery Subsystem <MAILER-DAEMON@rumms.u=
ni-mannheim.de> -----

[...]
Final-Recipient: RFC822; linux-kernel@vger.kernel.org
Action: failed
Status: 5.7.1
Remote-MTA: DNS; vger.kernel.org
Diagnostic-Code: SMTP; 550 5.7.1 The Triple-X in subject is way too often a=
ssociated with junk email, please rephrase. ; S263532AbTDHGof
Last-Attempt-Date: Tue, 8 Apr 2003 08:56:12 +0200 (MEST)

Date: Tue, 8 Apr 2003 08:55:41 +0200
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
   Marcelo Tosatti <marcelo@conectiva.com.br>,
   Linus Torvalds <torvalds@transmeta.com>,
   Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Kurt Garloff <garloff@suse.de>,
   Hubert Mantel <mantel@suse.de>, linux-kernel <linux-kernel@vger.kernel.o=
rg>
Subject: [PATCH] aic7xxx claims all checked EISA io ranges
User-Agent: Mutt/1.4i
From: Robert Schiele <rschiele@uni-mannheim.de>

Hello.

Some days ago a bug was introduced in aic7xxx by applying the aic7xxx driver
upgrade to both the 2.4 and the 2.5 tree.  This bug makes aic7xxx to claim =
all
the ioport ranges that he checks while scanning for EISA cards.  Takashi Iw=
ai
and me iterated over the sources to finally find that the result value check
of the request_region() is negated.

Because of that the following patch goes to Justin to fix it in driver
development tree, to the official tree maintainers to fix it there, and to
Alan, because you sent this driver update to Marcelo, so I assume the same
problem is in your tree.

The patch applies to both, the 2.4 and the 2.5 tree.

And now for the trivial but obvious patch:

--- linux/drivers/scsi/aic7xxx/aic7770_osm.c	1 Apr 2003 19:57:24 -0000	1.4
+++ linux/drivers/scsi/aic7xxx/aic7770_osm.c	8 Apr 2003 05:37:38 -0000
@@ -66,7 +66,7 @@
 			continue;
 		request_region(eisaBase, AHC_EISA_IOSIZE, "aic7xxx");
 #else
-		if (request_region(eisaBase, AHC_EISA_IOSIZE, "aic7xxx") !=3D 0)
+		if (request_region(eisaBase, AHC_EISA_IOSIZE, "aic7xxx") =3D=3D 0)
 			continue;
 #endif
=20

Robert

--=20
Robert Schiele			Tel.: +49-621-181-2517
Dipl.-Wirtsch.informatiker	mailto:rschiele@uni-mannheim.de




----- End forwarded message -----

--=20
Robert Schiele			Tel.: +49-621-181-2517
Dipl.-Wirtsch.informatiker	mailto:rschiele@uni-mannheim.de

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQE+knfVxcDFxyGNGNcRAti3AKCFgYYNUeBtR0b8SCdXlGHPkTwxhwCfRghn
tzezHmt6fgfpKQ2wbWd/ZEQ=
=wyCb
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

