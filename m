Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317842AbSHDOmB>; Sun, 4 Aug 2002 10:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSHDOmB>; Sun, 4 Aug 2002 10:42:01 -0400
Received: from ppp-217-133-220-178.dialup.tiscali.it ([217.133.220.178]:17044
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317842AbSHDOmA>; Sun, 4 Aug 2002 10:42:00 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028476259.14196.31.camel@irongate.swansea.linux.org.uk>
References: <1028471237.1294.515.camel@ldb> 
	<1028476259.14196.31.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-yQASFkuizCIeH/WJ+ywF"
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Aug 2002 16:44:41 +0200
Message-Id: <1028472281.1294.519.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yQASFkuizCIeH/WJ+ywF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> PPro fence is required for uniprocessor pentium pro.

This should fix this and the CONFIG_MK6(II) issue.


diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/Config.help b/arch/i386/Config.help
--- a/arch/i386/Config.help	2002-08-04 16:39:50.000000000 +0200
+++ b/arch/i386/Config.help	2002-08-04 16:38:53.000000000 +0200
@@ -490,7 +490,7 @@
   Select this for an AMD K6 processor.  Enables use of some extended
   instructions, and passes appropriate optimization flags to GCC.
 
-CONFIG_MK6
+CONFIG_MK6II
   Select this for an AMD K6-2/K6-3D or K6-3.  Enables use of some
   extended instructions, passes appropriate optimization flags to GCC
   and enables 3DNow!
@@ -528,7 +528,7 @@
   can increase performance of some operations.
 
 CONFIG_X86_PPRO_FENCE
-  Allows the kernel to run on Pentium Pro SMP systems by supporting a
+  Allows the kernel to run on Pentium Pro systems by supporting a
   workaround for the store ordering bug present on them.
   This slows down all processors except WinChips since they already do
   out-of-order stores.
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	2002-08-04 16:39:50.000000000 +0200
+++ b/arch/i386/config.in	2002-08-04 16:35:24.000000000 +0200
@@ -214,7 +214,7 @@
    define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_X86_USE_SSE_PREFETCH" != "y" -a "$CONFIG_X86_USE_3DNOW" != "y" -a "$CONFIG_X86_OOSTORE" != "y" ]; then
-   dep_bool 'Support Pentium Pro SMP and slow down all processors' CONFIG_X86_PPRO_FENCE $CONFIG_SMP
+   dep_bool 'Support Pentium Pro and slow down all processors' CONFIG_X86_PPRO_FENCE
 fi
 
 bool 'Symmetric multi-processing support' CONFIG_SMP
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/include/asm-i386/bugs.h b/include/asm-i386/bugs.h
--- a/include/asm-i386/bugs.h	2002-08-04 16:39:51.000000000 +0200
+++ b/include/asm-i386/bugs.h	2002-08-04 16:40:12.000000000 +0200
@@ -199,12 +199,12 @@
 		panic("Kernel compiled for PMMX+, assumes a local APIC without the read-before-write bug!");
 #endif
 
-#if !defined(CONFIG_X86_PPRO_FENCE) && defined(CONFIG_SMP)
+#if !defined(CONFIG_X86_PPRO_FENCE)
 	if(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL
 	   && boot_cpu_data.x86 == 6
 	   && boot_cpu_data.x86_model <= 1
 		)
-		panic("Kernel compiled without Pentium Pro SMP support!");
+		panic("Kernel compiled without Pentium Pro support!");
 #endif
 
 #if defined(CONFIG_X86_USE_3DNOW)

--=-yQASFkuizCIeH/WJ+ywF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9TT3Ydjkty3ft5+cRAkYEAJ9Vcel0XDI47n0bL098XBIzaxfxbgCgsP2V
brkWqR4Vp3IeI+bW0m08skI=
=zv+Z
-----END PGP SIGNATURE-----

--=-yQASFkuizCIeH/WJ+ywF--
