Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319003AbSHSUqU>; Mon, 19 Aug 2002 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319015AbSHSUqU>; Mon, 19 Aug 2002 16:46:20 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:29122 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319003AbSHSUqS>;
	Mon, 19 Aug 2002 16:46:18 -0400
Subject: [PATCH] 686-notsc_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, andrea <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 13:34:37 -0700
Message-Id: <1029789277.948.190.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	In the spirit of "if it doesn't get in, make it smaller and change its
name", here is my 686-notsc patch. It basically just the config option
changes made by my tsc-disable patch, which allow you to build a kernel
for CPUs that have a TSC, but disables the CONFIG_X86_TSC optimization.


thanks
-john

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Mon Aug 19 13:23:29 2002
+++ b/Documentation/Configure.help	Mon Aug 19 13:23:29 2002
@@ -230,6 +230,20 @@
   network and embedded applications.  For more information see the
   Axis Communication site, <http://developer.axis.com/>.
 
+Unsynced TSC support
+CONFIG_X86_TSC_DISABLE
+  This option is used for getting Linux to run on a NUMA multi-node 
+  boxes, laptops and other systems suffering from unsynced TSCs or 
+  TSC drift, which can cause gettimeofday to return non-monotonic values. 
+  Choosing this option will disable the CONFIG_X86_TSC optimization,
+  and allows you to then specify "notsc" as a boot option regardless of 
+  which processor you have compiled for. 
+  
+  NOTE: If your system hangs when init should run, you are probably
+  using a i686 compiled glibc which reads the TSC wihout checking for 
+  avaliability. Boot without "notsc" and install a i386 compiled glibc 
+  to solve the problem.
+ 
 Multiquad support for NUMA systems
 CONFIG_MULTIQUAD
   This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Mon Aug 19 13:23:29 2002
+++ b/arch/i386/config.in	Mon Aug 19 13:23:29 2002
@@ -82,7 +82,7 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
@@ -90,14 +90,14 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M686" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -106,7 +106,7 @@
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -114,7 +114,7 @@
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -123,12 +123,12 @@
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MK7" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
@@ -143,14 +143,14 @@
 fi
 if [ "$CONFIG_MCYRIXIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MCRUSOE" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
@@ -163,7 +163,7 @@
 if [ "$CONFIG_MWINCHIP2" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
    define_bool CONFIG_X86_F00F_WORKS_OK y
@@ -171,7 +171,7 @@
 if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
    define_bool CONFIG_X86_F00F_WORKS_OK y
@@ -217,6 +217,11 @@
    fi
 else
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+fi
+
+bool 'Unsynced TSC support' CONFIG_X86_TSC_DISABLE
+if [ "$CONFIG_X86_TSC_DISABLE" != "y" -a "$CONFIG_X86_HAS_TSC" = "y" ]; then
+   define_bool CONFIG_X86_TSC y
 fi
 
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then

