Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265663AbSKAIWm>; Fri, 1 Nov 2002 03:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265665AbSKAIWm>; Fri, 1 Nov 2002 03:22:42 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:60126 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265663AbSKAIWT>; Fri, 1 Nov 2002 03:22:19 -0500
Date: Fri, 1 Nov 2002 09:28:19 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [2.5. PATCH] cpufreq: correct initialization on PIII Coppermines
Message-ID: <20021101092819.C1268@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The detection process for speedstep-enabled Pentium IIIs mixed up the
lower and upper 32 bits of a MSR. Additionally, the second check
turned out to be wrong. (Bruno Ducrot, "Nash")

       Dominik


--- linux-2545original/arch/i386/kernel/cpu/cpufreq/speedstep.c	Thu Oct 31 =
12:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	Thu Oct 31 20:30:00 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: speedstep.c,v 1.53 2002/09/29 23:43:11 db Exp $
+ *  $Id: speedstep.c,v 1.54 2002/10/10 15:52:55 db Exp $
  *
  * (C) 2001  Dave Jones, Arjan van de ven.
  * (C) 2002  Dominik Brodowski <linux@brodo.de>
@@ -72,7 +72,7 @@
 #ifdef SPEEDSTEP_DEBUG
 #define dprintk(msg...) printk(msg)
 #else
-#define dprintk(msg...) do { } while(0);
+#define dprintk(msg...) do { } while(0)
 #endif
=20
=20
@@ -490,16 +490,10 @@
 			/* platform ID seems to be 0x00140000 */
 			rdmsr(MSR_IA32_PLATFORM_ID, msr_lo, msr_hi);
 			dprintk(KERN_DEBUG "cpufreq: Coppermine: MSR_IA32_PLATFORM ID is 0x%x, =
0x%x\n", msr_lo, msr_hi);
-			msr_hi =3D msr_lo & 0x001c0000;
+			msr_hi &=3D 0x001c0000;
 			if (msr_hi !=3D 0x00140000)
 				return 0;
=20
-			/* and these bits seem to be either 00_b, 01_b or
-			 * 10_b but never 11_b */
-			msr_lo &=3D 0x00030000;
-			if (msr_lo =3D=3D 0x0030000)
-				return 0;
-
 			/* let's hope this is correct... */
 			return SPEEDSTEP_PROCESSOR_PIII_C;
 		}
@@ -644,11 +638,11 @@
 		speedstep_processor =3D speedstep_detect_processor();
=20
 	if ((!speedstep_chipset) || (!speedstep_processor)) {
-		dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet)=
 available.\n", speedstep_processor ? "chipset" : "processor");
+		printk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet) =
available.\n", speedstep_processor ? "chipset" : "processor");
 		return -ENODEV;
 	}
=20
-	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.5=
3 $\n");
+	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.5=
4 $\n");
 	dprintk(KERN_DEBUG "cpufreq: chipset 0x%x - processor 0x%x\n",=20
 	       speedstep_chipset, speedstep_processor);
=20

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9wjrQZ8MDCHJbN8YRApMiAJ0aM3m9yfQHLji9c9g9RBSnGgHPcACgqDRX
leAjtSKAUUvpgTEh59BHr0o=
=G4Yu
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
