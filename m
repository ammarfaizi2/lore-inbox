Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271120AbTGQQAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271124AbTGQQAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:00:43 -0400
Received: from bab72-140.optonline.net ([167.206.72.140]:55750 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S271120AbTGQQAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:00:42 -0400
Date: Thu, 17 Jul 2003 12:15:30 -0400
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Floppy fix for sparc64
Message-ID: <20030717161530.GA15057@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	davem@redhat.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I add to fix the declarations of 2 fonctions in asm-sparc64/floppy.h  to
get drivers/block/floppy.c to compile. I haven't seen this patch on lkml so
here it is:

--- include/asm/floppy.h.orig	2003-07-17 11:36:09.000000000 -0400
+++ include/asm/floppy.h	2003-07-17 12:10:17.000000000 -0400
@@ -214,7 +214,7 @@
 }
 
 /* Our low-level entry point in arch/sparc/kernel/entry.S */
-extern void floppy_hardint(int irq, void *unused, struct pt_regs *regs);
+extern irqreturn_t floppy_hardint(int irq, void *unused, struct pt_regs *regs);
 
 static int sun_fd_request_irq(void)
 {
@@ -224,7 +224,7 @@
 	if(!once) {
 		once = 1;
 
-		error = request_fast_irq(FLOPPY_IRQ, floppy_hardint, 
+		error = request_fast_irq(FLOPPY_IRQ, &floppy_hardint, 
 					 SA_INTERRUPT, "floppy", NULL);
 
 		return ((error == 0) ? 0 : -1);
@@ -277,7 +277,7 @@
 static struct sun_pci_dma_op sun_pci_dma_current = { -1U, 0, 0, NULL};
 static struct sun_pci_dma_op sun_pci_dma_pending = { -1U, 0, 0, NULL};
 
-extern void floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern irqreturn_t floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 static unsigned char sun_pci_fd_inb(unsigned long port)
 {

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
