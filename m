Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSE2UoZ>; Wed, 29 May 2002 16:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSE2UoY>; Wed, 29 May 2002 16:44:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10974 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315483AbSE2UoI>;
	Wed, 29 May 2002 16:44:08 -0400
Subject: [RFC] [PATCH] Disable TSCs on CONFIG_MULTIQUAD
From: john stultz <johnstul@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-cvoYp3GirnBZawxWY2OG"
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 May 2002 13:40:50 -0700
Message-Id: <1022704850.1963.18.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cvoYp3GirnBZawxWY2OG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,
	Just wanted to submit this for comments. As we've been having trouble
keeping the TSCs on NUMA hardware synced (resulting in gettimeofday
occasionally going backward), this patch (against 2.4.18) disables TSCs
if CONFIG_MULTIQUAD is enabled. Any suggestions for simplifying the
changes to config.in would be appreciated. 

Flames/etc also welcome. 
-john

--=-cvoYp3GirnBZawxWY2OG
Content-Disposition: attachment; filename=tsc-disable_A2.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tsc-disable_A2.patch; charset=ISO-8859-1

Index: linux24/arch/i386/config.in
diff -u linux24/arch/i386/config.in:1.1.1.3 linux24/arch/i386/config.in:1.1=
.1.3.14.2
--- linux24/arch/i386/config.in:1.1.1.3	Wed Feb 13 14:53:47 2002
+++ linux24/arch/i386/config.in	Wed May 29 10:59:43 2002
@@ -80,20 +80,20 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_PPRO_FENCE y
 fi
 if [ "$CONFIG_M586MMX" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
 fi
 if [ "$CONFIG_M686" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -101,14 +101,14 @@
 fi
 if [ "$CONFIG_MPENTIUMIII" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MPENTIUM4" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -116,12 +116,12 @@
 if [ "$CONFIG_MK6" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MK7" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
@@ -134,14 +134,14 @@
 fi
 if [ "$CONFIG_MCYRIXIII" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MCRUSOE" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
 fi
 if [ "$CONFIG_MWINCHIPC6" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -152,14 +152,14 @@
 if [ "$CONFIG_MWINCHIP2" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
 fi
 if [ "$CONFIG_MWINCHIP3D" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
 fi
@@ -196,6 +196,16 @@
    fi
 else
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+fi
+
+if [ "$CONFIG_X86_HAS_TSC" =3D "y" ]; then
+	if [ "$CONFIG_MULTIQUAD" =3D "y" ]; then
+		define_bool CONFIG_X86_TSC n
+	else
+		define_bool CONFIG_X86_TSC y
+	fi
+else
+	define_bool CONFIG_X86_TSC n
 fi
=20
 if [ "$CONFIG_SMP" =3D "y" -a "$CONFIG_X86_CMPXCHG" =3D "y" ]; then
Index: linux24/arch/i386/kernel/setup.c
diff -u linux24/arch/i386/kernel/setup.c:1.1.1.3.14.1 linux24/arch/i386/ker=
nel/setup.c:1.1.1.3.14.3
--- linux24/arch/i386/kernel/setup.c:1.1.1.3.14.1	Tue May 28 17:30:29 2002
+++ linux24/arch/i386/kernel/setup.c	Wed May 29 10:59:43 2002
@@ -1054,7 +1054,11 @@
=20
=20
 #ifndef CONFIG_X86_TSC
+#ifdef CONFIG_MULTIQUAD /*MULTIQUAD & TSCs don't play well*/
+static int tsc_disable __initdata =3D 1;=09
+#else /*CONFIG_MULTIQUAD*/
 static int tsc_disable __initdata =3D 0;
+#endif /*CONFIG_MULTIQUAD*/
=20
 static int __init tsc_setup(char *str)
 {

--=-cvoYp3GirnBZawxWY2OG--

