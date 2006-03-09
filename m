Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWCIXHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWCIXHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWCIXHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:07:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15370 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751139AbWCIXHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:07:00 -0500
Date: Fri, 10 Mar 2006 00:06:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>
Subject: [2.6 patch] some fixups for the X86_NUMAQ dependencies
Message-ID: <20060309230659.GM21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You must always ensure to fulfill the dependencies of what you are 
select'ing.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Feb 2006

 arch/i386/Kconfig |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc3-mm1-full/arch/i386/Kconfig.old	2006-02-20 00:12:50.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/arch/i386/Kconfig	2006-02-20 00:17:57.000000000 +0100
@@ -84,6 +84,7 @@
 
 config X86_NUMAQ
 	bool "NUMAQ (IBM/Sequent)"
+	select SMP
 	select NUMA
 	help
 	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA
@@ -419,6 +420,7 @@
 
 config NOHIGHMEM
 	bool "off"
+	depends on !X86_NUMAQ
 	---help---
 	  Linux can use up to 64 Gigabytes of physical memory on x86 systems.
 	  However, the address space of 32-bit x86 processors is only 4
@@ -455,6 +457,7 @@
 
 config HIGHMEM4G
 	bool "4GB"
+	depends on !X86_NUMAQ
 	help
 	  Select this if you have a 32-bit processor and between 1 and 4
 	  gigabytes of physical RAM.
@@ -522,10 +525,6 @@
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
 
-# Need comments to help the hapless user trying to turn on NUMA support
-comment "NUMA (NUMA-Q) requires SMP, 64GB highmem support"
-	depends on X86_NUMAQ && (!HIGHMEM64G || !SMP)
-
 comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
 

