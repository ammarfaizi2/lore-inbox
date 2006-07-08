Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWGHAFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWGHAFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWGHAFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:05:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10434 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932424AbWGHAFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:05:18 -0400
Date: Fri, 7 Jul 2006 17:05:06 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Bligh <mbligh@google.com>, Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060708000506.3829.34340.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 1/8] Add CONFIG_ZONE_DMA to all archesM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce CONFIG_ZONE_DMA

CONFIG_ZONE_DMA can be defined in two ways depending on how
an architecture handles ISA DMA.

First when CONFIG_GENERIC_ISA_DMA is set by the arch then we know that
the arch needs ZONE_DMA because ISA DMA devices are supported. The arch
would need to be modified in order to allow switching ZONE_DMA off.

Second, arches may use ZONE_DMA in an unknown way. We set CONFIG_ZONE_DMA
for all arches that do not set CONFIG_GENERIC_ISA_DMA in order to insure
backwards compatibility. The arches may later undefine ZONE_DMA
if their arch code has been modified to not depend on ZONE_DMA.

As a result of this patch CONFIG_ZONE_DMA should be defined for every
arch.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/mm/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/mm/Kconfig	2006-07-03 13:47:22.616084772 -0700
+++ linux-2.6.17-mm6/mm/Kconfig	2006-07-03 21:26:49.956038556 -0700
@@ -134,6 +134,10 @@ config SPLIT_PTLOCK_CPUS
 	default "4096" if PARISC && !PA20
 	default "4"
 
+config ZONE_DMA
+	def_bool y
+	depends on GENERIC_ISA_DMA
+
 #
 # support for page migration
 #
Index: linux-2.6.17-mm6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/ia64/Kconfig	2006-07-03 21:26:38.944998185 -0700
+++ linux-2.6.17-mm6/arch/ia64/Kconfig	2006-07-03 21:35:54.270151176 -0700
@@ -22,6 +22,10 @@ config 64BIT
 	bool
 	default y
 
+config ZONE_DMA
+	bool
+	default y
+
 config MMU
 	bool
 	default y
Index: linux-2.6.17-mm6/arch/cris/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/cris/Kconfig	2006-07-03 13:47:12.502452440 -0700
+++ linux-2.6.17-mm6/arch/cris/Kconfig	2006-07-03 21:34:53.678182903 -0700
@@ -9,6 +9,10 @@ config MMU
 	bool
 	default y
 
+config ZONE_DMA
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: linux-2.6.17-mm6/arch/s390/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/s390/Kconfig	2006-07-03 13:47:13.887132430 -0700
+++ linux-2.6.17-mm6/arch/s390/Kconfig	2006-07-03 21:34:30.527266107 -0700
@@ -7,6 +7,10 @@ config MMU
 	bool
 	default y
 
+config ZONE_DMA
+	bool
+	default y
+
 config LOCKDEP_SUPPORT
 	bool
 	default y
Index: linux-2.6.17-mm6/arch/xtensa/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/xtensa/Kconfig	2006-07-03 13:47:14.333393893 -0700
+++ linux-2.6.17-mm6/arch/xtensa/Kconfig	2006-07-03 21:37:26.980256509 -0700
@@ -7,6 +7,10 @@ config FRAME_POINTER
 	bool
 	default n
 
+config ZONE_DMA
+	bool
+	default y
+
 config XTENSA
 	bool
 	default y
Index: linux-2.6.17-mm6/arch/h8300/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/h8300/Kconfig	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-mm6/arch/h8300/Kconfig	2006-07-03 21:35:38.346328043 -0700
@@ -17,6 +17,10 @@ config SWAP
 	bool
 	default n
 
+config ZONE_DMA
+	bool
+	default y
+
 config FPU
 	bool
 	default n
Index: linux-2.6.17-mm6/arch/v850/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/v850/Kconfig	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-mm6/arch/v850/Kconfig	2006-07-03 21:37:04.602729732 -0700
@@ -10,6 +10,9 @@ mainmenu "uClinux/v850 (w/o MMU) Kernel 
 config MMU
        	bool
 	default n
+config ZONE_DMA
+	bool
+	default y
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: linux-2.6.17-mm6/arch/sh/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/sh/Kconfig	2006-07-03 13:47:13.975017619 -0700
+++ linux-2.6.17-mm6/arch/sh/Kconfig	2006-07-03 21:36:39.118949095 -0700
@@ -14,6 +14,10 @@ config SUPERH
 	  gaming console.  The SuperH port has a home page at
 	  <http://www.linux-sh.org/>.
 
+config ZONE_DMA
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: linux-2.6.17-mm6/arch/frv/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/frv/Kconfig	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-mm6/arch/frv/Kconfig	2006-07-03 21:35:16.328153984 -0700
@@ -6,6 +6,10 @@ config FRV
 	bool
 	default y
 
+config ZONE_DMA
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: linux-2.6.17-mm6/arch/m68knommu/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/m68knommu/Kconfig	2006-07-03 13:47:12.932113368 -0700
+++ linux-2.6.17-mm6/arch/m68knommu/Kconfig	2006-07-03 21:36:19.860370626 -0700
@@ -17,6 +17,10 @@ config FPU
 	bool
 	default n
 
+config ZONE_DMA
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
