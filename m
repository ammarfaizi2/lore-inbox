Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTIGT4L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbTIGT4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:56:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1266 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261358AbTIGT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:56:05 -0400
Date: Sun, 7 Sep 2003 21:55:57 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org, Peter Daum <gator@cs.tu-berlin.de>
Subject: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
Message-ID: <20030907195557.GK14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Peter Daum reported in the "2.4.22 with CONFIG_M686: networking broken" 
thread some problems when using a kernel with CONFIG_M686 on a
Pentium 4.

With CONFIG_M686 CONFIG_X86_L1_CACHE_SHIFT was set to 5, but a Pentium 4 
requires 7.

The problem comes from the fact that in 2.4 selecting a processor means 
"this processor and all better processors are supported". Without 
breaking this semantics in a kernel series the only solution is to make 
CONFIG_X86_L1_CACHE_SHIFT for older processors higher.

The patch below does:
- set CONFIG_X86_L1_CACHE_SHIFT 7 for all Intel processors (needed for 
  the Pentium 4)
- set CONFIG_X86_L1_CACHE_SHIFT 6 for the K6 (needed for the Athlon)

This issue was already resolved in 2.6.

Please apply
Adrian

--- linux-2.4.23-pre3-full/arch/i386/config.in.old	2003-09-07 17:10:31.000000000 +0200
+++ linux-2.4.23-pre3-full/arch/i386/config.in	2003-09-07 17:11:47.000000000 +0200
@@ -51,7 +51,7 @@
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
    define_bool CONFIG_X86_XADD n
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
    define_bool CONFIG_X86_PPRO_FENCE y
@@ -67,21 +67,21 @@
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 fi
 if [ "$CONFIG_M486" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M586" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M586TSC" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_HAS_TSC y
@@ -89,7 +89,7 @@
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M586MMX" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_HAS_TSC y
@@ -98,7 +98,7 @@
    define_bool CONFIG_X86_F00F_WORKS_OK n
 fi
 if [ "$CONFIG_M686" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    bool 'PGE extensions (not for Cyrix/Transmeta)' CONFIG_X86_PGE
@@ -107,7 +107,7 @@
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
@@ -123,7 +123,7 @@
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
