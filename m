Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270752AbTHAMw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 08:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270753AbTHAMw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 08:52:58 -0400
Received: from mta04.btfusion.com ([62.172.195.246]:53215 "EHLO
	mta04.btfusion.com") by vger.kernel.org with ESMTP id S270752AbTHAMw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 08:52:56 -0400
Date: Fri, 01 Aug 2003 13:52:50 +0100
To: marcelo@conectiva.com.br
Cc: calum.mackay@sun.com, mitch.dsouza@sun.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH]  2.4: export the symbol "mmu_cr4_features" for XFree86 
 DRM kernel drivers
Message-ID: <3F2A62A2.mailx3G211O2B4@cdmnet.org>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Calum Mackay <calum.mackay@cdmnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to request comments on the appended; proposed patch for 2.4 to
export the symbol "mmu_cr4_features".

This is needed by the XFree86 DRM kernel drivers, since Christoph's
backport of vmap() in 2.4.22-pre7. [some] DRM kernel drivers (e.g. radeon]
refuse to load without this fix, from 2.4.22-pre7 onwards.

cheers,
Calum.


[diffs -u against 2.4.22-pre9]

--- arch/i386/kernel/setup.c.20030731   2003-07-31 11:28:52.000000000 +0100
+++ arch/i386/kernel/setup.c    2003-08-01 12:42:21.000000000 +0100
@@ -128,6 +128,7 @@
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 
 unsigned long mmu_cr4_features;
+EXPORT_SYMBOL(mmu_cr4_features);
 
 /*
  * Bus types ..



--- arch/x86_64/kernel/setup.c.20030731 2003-07-31 11:28:53.000000000 +0100
+++ arch/x86_64/kernel/setup.c  2003-08-01 12:43:27.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/blk.h>
 #include <linux/highmem.h>
 #include <linux/bootmem.h>
+#include <linux/module.h>
 #include <asm/processor.h>
 #include <linux/console.h>
 #include <linux/seq_file.h>
@@ -58,6 +59,7 @@
 };
 
 unsigned long mmu_cr4_features;
+EXPORT_SYMBOL(mmu_cr4_features);
 
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0x10000000;
