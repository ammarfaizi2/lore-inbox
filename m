Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317013AbSFANJp>; Sat, 1 Jun 2002 09:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317014AbSFANJo>; Sat, 1 Jun 2002 09:09:44 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:48522 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317013AbSFANJn>; Sat, 1 Jun 2002 09:09:43 -0400
Date: Sat, 1 Jun 2002 15:06:16 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Gerald Britton <gbritton@alum.mit.edu>
Cc: davej@suse.de, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [PATCH] Re: Linux 2.4.19pre9-ac3
Message-ID: <20020601150616.A1908@brodo.de>
In-Reply-To: <20020531215144.A4358@light-brigade.mit.edu> <20020531014935.D9282@suse.de> <10830.1022935054@www2.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the bug report, appended patch should correct it - a PIII
Coppermine workaround was also called on PIII-M Tulatins.

Dominik

On Sat, Jun 01, 2002 at 02:37:34PM +0200, Gerald Britton wrote:
> cpufreq: currently at high speed setting - 598 MHz
> CPU clock: 598.500 MHz (731.500-598.500 MHz)
>=20
> cpu family	: 6
> model		: 11
> model name	: Intel(R) Pentium(R) III Mobile CPU      1133MHz
> stepping	: 1

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="correct_multiplier_detection.speedstep.diff"
Content-Transfer-Encoding: quoted-printable

--- /usr/src/linux-24-ac/arch/i386/kernel/speedstep.c	Sat Jun  1 14:58:09 2=
002
+++ cpufreq/CVS-24/cpufreq/linux/arch/i386/kernel/speedstep.c	Sat Jun  1 14=
:56:25 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: speedstep.c,v 1.7.2.2 2002/05/28 18:33:13 db Exp $
+ *  $Id: speedstep.c,v 1.7.2.3 2002/06/01 12:56:25 db Exp $
  *
  *	(C) 2001  Dave Jones, Arjan van de ven.
  *	(C) 2002  Dominik Brodowski <devel@brodo.de>
@@ -14,7 +14,7 @@
  *
  *  BIG FAT DISCLAIMER: Work in progress code. Possibly *dangerous*
  *
- *	Version $Id: speedstep.c,v 1.7.2.2 2002/05/28 18:33:13 db Exp $
+ *	Version $Id: speedstep.c,v 1.7.2.3 2002/06/01 12:56:25 db Exp $
  */
=20
=20
@@ -353,10 +353,12 @@
 	rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_hi);
=20
 	/* decode value */
-	if (c->x86_mask !=3D 0x01) /* different on early PIII */
-		msr_lo &=3D 0x0bc00000;
-	else
+	if ((c->x86_model =3D=3D 0x08) && (c->x86_mask =3D=3D 0x01))=20
+                /* different on early Coppermine PIII */
 		msr_lo &=3D 0x03c00000;
+	else
+		msr_lo &=3D 0x0bc00000;
+
 	msr_lo >>=3D 22;
 	while (msr_lo !=3D msr_decode_mult[i].bitmap) {
 		if (msr_decode_mult[i].bitmap =3D=3D 0xff)
@@ -500,7 +502,7 @@
 	int             result;
 	unsigned int    speed;
=20
-	printk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.7.=
2.2 $\n");
+	printk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.7.=
2.3 $\n");
=20
 	/* detect processor */
 	speedstep_processor =3D speedstep_detect_processor();

--ew6BAiZeqk4r7MaW--

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE8+MbCZ8MDCHJbN8YRAoZEAKCLKk+GY6Bd3acw3WM4+2QQOFMohQCfea7Y
ZkcDXH9WYhUkw89f5PC029k=
=noXA
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
