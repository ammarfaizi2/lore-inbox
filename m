Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269222AbUH0IuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269222AbUH0IuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269174AbUH0IuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:50:25 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:48550 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269222AbUH0Itf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:49:35 -0400
Date: Fri, 27 Aug 2004 01:49:32 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] disambiguate esp.c clones
Message-ID: <20040827084932.GA3289@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040818i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: multipart/mixed; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Debian's initial ramdisk creation scripts rely on the content of
/proc/scsi to determine which module is needed for the ramdisk.
Unfortunately, bad things happen when a bazillion different drivers
use the _exact same name_ for /proc, namely the esp family.

Is it wrong to give them all unique names? Here's a patch against
2.6.8.1 which does so. Of course, there may be *some* crackheaded
reason that they should all contain the same name...

Thanks

--=20
Joshua Kwan

--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-disambiguate-proc_name.diff"
Content-Transfer-Encoding: quoted-printable

--- kernel-source-2.6.8/drivers/scsi/mca_53c9x.c~	2004-08-27 01:40:00.00000=
0000 -0700
+++ kernel-source-2.6.8/drivers/scsi/mca_53c9x.c	2004-08-27 01:40:02.000000=
000 -0700
@@ -445,7 +445,7 @@
 }
=20
 static Scsi_Host_Template driver_template =3D {
-	.proc_name		=3D "esp",
+	.proc_name		=3D "mca_53c9x",
 	.name			=3D "NCR 53c9x SCSI",
 	.detect			=3D mca_esp_detect,
 	.slave_alloc		=3D esp_slave_alloc,
--- kernel-source-2.6.8/drivers/scsi/jazz_esp.c~	2004-08-27 01:40:35.000000=
000 -0700
+++ kernel-source-2.6.8/drivers/scsi/jazz_esp.c	2004-08-27 01:41:06.0000000=
00 -0700
@@ -286,7 +286,7 @@
 }
=20
 static Scsi_Host_Template driver_template =3D {
-	.proc_name		=3D "esp",
+	.proc_name		=3D "jazz_esp",
 	.proc_info		=3D &esp_proc_info,
 	.name			=3D "ESP 100/100a/200",
 	.detect			=3D jazz_esp_detect,
--- kernel-source-2.6.8/drivers/scsi/mac_esp.c~	2004-08-27 01:41:22.0000000=
00 -0700
+++ kernel-source-2.6.8/drivers/scsi/mac_esp.c	2004-08-27 01:41:27.00000000=
0 -0700
@@ -731,7 +731,7 @@
 }
=20
 static Scsi_Host_Template driver_template =3D {
-	.proc_name		=3D "esp",
+	.proc_name		=3D "mac_esp",
 	.name			=3D "Mac 53C9x SCSI",
 	.detect			=3D mac_esp_detect,
 	.slave_alloc		=3D esp_slave_alloc,
--- kernel-source-2.6.8/drivers/scsi/dec_esp.c~	2004-08-27 01:42:06.0000000=
00 -0700
+++ kernel-source-2.6.8/drivers/scsi/dec_esp.c	2004-08-27 01:42:08.00000000=
0 -0700
@@ -120,7 +120,7 @@
 }
=20
 static Scsi_Host_Template driver_template =3D {
-	.proc_name		=3D "esp",
+	.proc_name		=3D "dec_esp",
 	.proc_info		=3D &esp_proc_info,
 	.name			=3D "NCR53C94",
 	.detect			=3D dec_esp_detect,
--- kernel-source-2.6.8/drivers/scsi/sun3x_esp.c~	2004-08-27 01:46:32.00000=
0000 -0700
+++ kernel-source-2.6.8/drivers/scsi/sun3x_esp.c	2004-08-27 01:46:36.000000=
000 -0700
@@ -370,7 +370,7 @@
 }
=20
 static Scsi_Host_Template driver_template =3D {
-	.proc_name		=3D "esp",
+	.proc_name		=3D "sun3x_esp",
 	.proc_info		=3D &esp_proc_info,
 	.name			=3D "Sun ESP 100/100a/200",
 	.detect			=3D sun3x_esp_detect,

--eAbsdosE1cNLO4uF--

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQS71nKOILr94RG8mAQKkuRAAhsXQGxsbEZlP4MtZOgOY+PU207OThy12
AgpoOLOQAMx+V9ej9/qHVJODs3DAHEOdbrCwbMtkaGx8GhJzvdnUC51gKYoNHW5y
jxanNaMKJ9mS/IplY0Hm5vbLOClEaVQO18xgCWa+GbXLPBKecFM0+QmI+PSelR5A
dcWYkAx3lkmjuYcX44xxav2jPtMLhp25/l/jeKE1XmYR+a47XYz+O1qoGuXB6/DO
hEtjcGXtSTvnw5cRz3ZXy2fdOFyovK1h2/sINzPcaOJ6DHkieSdyyenRVM0Nqxx6
WU4rqPq/q9bTV0FrBQpNPAnn4i8vZR3jXmrWREq1V36sW/J4QiG/f/vErJRPR+/6
0A1AiW6ZiSOYhLfTOqmrqf2WZO/tWsvey5PaXu1JLcWqbMvomQKQIH/0Rrj6WGCP
1Gi+drqDWLrS72Ku8WaK2Kupq06RcKMJWOsiJHaXkE5qgT32Z4X49Z9OYGylN2VF
AGCbPNvvqn5i5yGMWDjPH6ZIdcvQYbZknTMwHK1d+R6SdItWhTxwXEhYZYgcQZZS
CEAthIbs5nUJ6gZE9vYfS08JhmUNQhlFqt9u759jNbN+bisq0FFksuYXFiMPnJtY
ankYlHlK07x6mOQaUhVHihnObWd8tdYNFI2VEyUht1IK/JnA1phg5o8GHF5FP/iF
lU+xoz8+Ke0=
=quBF
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
