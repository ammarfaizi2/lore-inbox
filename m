Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTBSSTr>; Wed, 19 Feb 2003 13:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTBSSTr>; Wed, 19 Feb 2003 13:19:47 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:23271 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263333AbTBSSTq>;
	Wed, 19 Feb 2003 13:19:46 -0500
Message-ID: <3E53CCDA.6080501@us.ibm.com>
Date: Wed, 19 Feb 2003 10:28:42 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: gone@us.ibm.com
CC: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/2) x440 discontig support on 2.5.62: early, early
 ioremap
References: <200302190307.h1J37T225487@w-gaughen.beaverton.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040406000705000109030201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040406000705000109030201
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patricia Gaughen wrote:
> This patch was written by Dave Hansen, I just brought it forward to
> 2.5.62 :-)
>
> This patch is used by the x440 discontigmem to map the srat tables
> into low memory so that the memory can be setup.  This remap function
> is used very early in the boot process... at the start of
> setup_arch().
>
> Dave posted this previously to linux-kernel.  Here's a pointer to his
> email:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104515534619345&w=2

Here's a patch that makes the early ioremap conditional on Summit, and
NUMA.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------040406000705000109030201
Content-Type: text/plain;
 name="linux-2.5.62-config_early_ioremap_A0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.5.62-config_early_ioremap_A0.patch"

diff -ur linux-2.5.62-disco/arch/i386/Kconfig linux-2.5.62-disco.new/arch/i386/Kconfig
--- linux-2.5.62-disco/arch/i386/Kconfig	Wed Feb 19 10:14:34 2003
+++ linux-2.5.62-disco.new/arch/i386/Kconfig	Wed Feb 19 10:24:43 2003
@@ -754,6 +754,13 @@
 	depends on (SMP || PREEMPT) && X86_CMPXCHG
 	default y
 
+# turning this on wastes a bunch of space.
+# Summit needs it only when NUMA is on
+config BOOT_IOREMAP
+	bool
+	depends on (X86_SUMMIT && NUMA)
+	default y
+
 endmenu
 
 
Only in linux-2.5.62-disco.new/arch/i386: Kconfig~
diff -ur linux-2.5.62-disco/arch/i386/mm/Makefile linux-2.5.62-disco.new/arch/i386/mm/Makefile
--- linux-2.5.62-disco/arch/i386/mm/Makefile	Wed Feb 19 10:14:30 2003
+++ linux-2.5.62-disco.new/arch/i386/mm/Makefile	Wed Feb 19 10:15:42 2003
@@ -2,8 +2,9 @@
 # Makefile for the linux i386-specific parts of the memory manager.
 #
 
-obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o boot_ioremap.o
+obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o 
 
 obj-$(CONFIG_DISCONTIGMEM)	+= discontig.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_HIGHMEM) += highmem.o
+obj-$(CONFIG_BOOT_IOREMAP) += boot_ioremap.o
Only in linux-2.5.62-disco.new/scripts: elfconfig.h

--------------040406000705000109030201--

