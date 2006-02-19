Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWBSX0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWBSX0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWBSX0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:26:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30224 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932296AbWBSX0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:26:23 -0500
Date: Mon, 20 Feb 2006 00:26:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] some fixups for the X86_NUMAQ dependencies
Message-ID: <20060219232621.GC4971@stusta.de>
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
 

