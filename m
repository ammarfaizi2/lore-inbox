Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWGHSG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWGHSG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWGHSG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:06:29 -0400
Received: from verein.lst.de ([213.95.11.210]:4840 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964935AbWGHSGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:06:21 -0400
Date: Sat, 8 Jul 2006 20:05:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, davem@davemloft.net, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] disallow modular binfmt_elf32
Message-ID: <20060708180554.GB7034@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently most architectures either always build binfmt_elf32 in the
kernel image or make it a boolean option.  Only sparc64 and s390 allow
to build it modularly.  This patch turns the option into a boolean
aswell because elf requires various symbols that shouldn't be available
to modules.  The most urgent one is tasklist_lock whos export this patch
series kills, but there are others like force_sgi aswell.

Note that sparc doesn't allow a modular 32bit a.out handler either, and
that would be the more useful case as only few people want 32bit sunos
compatibility and 99.9% of all sparc64 users need 32bit linux native elf
support.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/s390/Kconfig
===================================================================
--- linux-2.6.orig/arch/s390/Kconfig	2006-07-06 14:21:17.000000000 +0200
+++ linux-2.6/arch/s390/Kconfig	2006-07-08 19:08:46.000000000 +0200
@@ -119,7 +119,7 @@
 	default y
 
 config BINFMT_ELF32
-	tristate "Kernel support for 31 bit ELF binaries"
+	bool "Kernel support for 31 bit ELF binaries"
 	depends on COMPAT
 	help
 	  This allows you to run 32-bit Linux/ELF binaries on your zSeries
Index: linux-2.6/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.orig/arch/sparc64/Kconfig	2006-07-01 12:49:02.000000000 +0200
+++ linux-2.6/arch/sparc64/Kconfig	2006-07-08 19:08:32.000000000 +0200
@@ -334,7 +334,7 @@
 	default y
 
 config BINFMT_ELF32
-	tristate "Kernel support for 32-bit ELF binaries"
+	bool "Kernel support for 32-bit ELF binaries"
 	depends on SPARC32_COMPAT
 	help
 	  This allows you to run 32-bit Linux/ELF binaries on your Ultra.
