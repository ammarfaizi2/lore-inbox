Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262710AbSJCAh4>; Wed, 2 Oct 2002 20:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJCAhz>; Wed, 2 Oct 2002 20:37:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35748 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262710AbSJCAhx>;
	Wed, 2 Oct 2002 20:37:53 -0400
Date: Wed, 02 Oct 2002 17:39:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NUMA-Q fixes 1/2
Message-ID: <411470000.1033605556@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This simple patch just enables us to disable the TSC on the NUMA-Qs,
as they can't keep TSCs in sync across nodes.

Changes the proc-specific "CONFIG_X86_TSC" to "CONFIG_X86_HAS_TSC"
and then switches off that and CONFIG_X86_NUMAQ" later to recreate the
original "CONFIG_X86_TSC" option.

Only changes the config.in file, no effect on any machine except NUMA-Q.

Patch was written by someone who wants to remain anonymous ;-)

Please apply,
Thanks,

Martin.

diff -purN -X /home/mbligh/.diff.exclude virgin/arch/i386/config.in tsc_disable/arch/i386/config.in
--- virgin/arch/i386/config.in	Tue Oct  1 00:06:28 2002
+++ tsc_disable/arch/i386/config.in	Wed Oct  2 16:52:27 2002
@@ -72,7 +72,7 @@ if [ "$CONFIG_M586TSC" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_BUG y
 fi
@@ -80,39 +80,39 @@ if [ "$CONFIG_M586MMX" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_M686" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_PPRO_FENCE y
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
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
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
@@ -124,14 +124,14 @@ if [ "$CONFIG_MELAN" = "y" ]; then
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
 fi
 if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -142,14 +142,14 @@ fi
 if [ "$CONFIG_MWINCHIP2" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
 fi
 if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
 fi
@@ -222,6 +222,14 @@ choice 'High Memory Support' \
 
 if [ "$CONFIG_HIGHMEM4G" = "y" ]; then
    define_bool CONFIG_HIGHMEM y
+fi
+
+if [ "$CONFIG_X86_HAS_TSC" = "y" ]; then
+	if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
+		define_bool CONFIG_X86_TSC n
+	else
+		define_bool CONFIG_X86_TSC y
+	fi
 fi
 
 if [ "$CONFIG_HIGHMEM64G" = "y" ]; then

