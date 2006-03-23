Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWCWFW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWCWFW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWCWFW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:22:26 -0500
Received: from fmr19.intel.com ([134.134.136.18]:10713 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932125AbWCWFWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:22:25 -0500
Subject: [trival patch]disable warning in cpu_init for cpu hotplug
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 13:21:08 +0800
Message-Id: <1143091268.11430.49.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch seems missed.
GFP_KERNEL isn't ok for runtime (cpu hotplug).

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.15-root/arch/i386/kernel/cpu/common.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/cpu/common.c~cpuhp arch/i386/kernel/cpu/common.c
--- linux-2.6.15/arch/i386/kernel/cpu/common.c~cpuhp	2006-03-14 12:13:43.000000000 +0800
+++ linux-2.6.15-root/arch/i386/kernel/cpu/common.c	2006-03-14 12:14:12.000000000 +0800
@@ -605,7 +605,7 @@ void __devinit cpu_init(void)
 		/* alloc_bootmem_pages panics on failure, so no check */
 		memset(gdt, 0, PAGE_SIZE);
 	} else {
-		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
+		gdt = (struct desc_struct *)get_zeroed_page(GFP_ATOMIC);
 		if (unlikely(!gdt)) {
 			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
 			for (;;)
_


