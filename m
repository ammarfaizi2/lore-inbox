Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271107AbTHGXJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271108AbTHGXJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:09:30 -0400
Received: from imap.gmx.net ([213.165.64.20]:52180 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271107AbTHGXJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:09:19 -0400
From: Nicolai Haehnle <prefect_@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] AGPv3 command parsing
Date: Fri, 8 Aug 2003 03:21:04 +0200
User-Agent: KMail/1.5.2
Cc: davej@codemonkey.org.uk
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AsvM/77bmQTGt88"
Message-Id: <200308080321.10691.prefect_@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_AsvM/77bmQTGt88
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

there's a trivial but fatal typo in agp/generic.c:agp_v3_parse_one() that=20
completely messes up the command generation.

I'll let the attached patch against 2.6.0 explain the rest...

cu,
Nicolai
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/MvsBsxPozBga0lwRAgsQAJ9AHqqG0uBXDKzE9pHxe1m67aZV2wCggBFH
p+BUB22EdrDIgvNs+kZHyVY=3D
=3D8khY
=2D----END PGP SIGNATURE-----

--Boundary-00=_AsvM/77bmQTGt88
Content-Type: text/x-diff;
  charset="us-ascii";
  name="agp3collect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="agp3collect.patch"

--- drivers/char/agp/generic.c~	2003-08-08 03:05:06.000000000 +0200
+++ drivers/char/agp/generic.c	2003-08-08 03:05:06.000000000 +0200
@@ -453,9 +453,9 @@
 
 	/* Clear out unwanted bits. */
 	if (*cmd & AGPSTAT3_8X)
-		*cmd = ~(AGPSTAT3_4X | AGPSTAT3_RSVD);
+		*cmd &= ~(AGPSTAT3_4X | AGPSTAT3_RSVD);
 	if (*cmd & AGPSTAT3_4X)
-		*cmd = ~(AGPSTAT3_8X | AGPSTAT3_RSVD);
+		*cmd &= ~(AGPSTAT3_8X | AGPSTAT3_RSVD);
 }
 
 //FIXME: This doesn't smell right.

--Boundary-00=_AsvM/77bmQTGt88--

