Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271913AbTGRVQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271856AbTGRVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:13:21 -0400
Received: from bab72-140.optonline.net ([167.206.72.140]:61510 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S271939AbTGRVNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:13:07 -0400
Date: Fri, 18 Jul 2003 17:27:50 -0400
From: Mathieu Chouquet-Stringer <mchouque@online.fr>
To: davem@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: Fix floppy on sparc64 to new irq code
Message-ID: <20030718212750.GA19649@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@online.fr>,
	davem@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20030717161530.GA15057@shookay.newview.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717161530.GA15057@shookay.newview.com>
User-Agent: Mutt/1.4.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't heard anything so here's the patch again (and the other one had a
superfluous ampersand anyway). Without it you can't compile
drivers/block/floppy.c on sparc64. It applies cleanly on top of 2.6.0-test1
or the current bk.

--- linux-2.6.0-test1/include/asm-sparc64/floppy.h	2003-07-13 23:39:23.000000000 -0400
+++ linux-2.6.0-test1-mathieu/include/asm/floppy.h	2003-07-18 17:18:43.000000000 -0400
@@ -214,7 +214,7 @@
 }
 
 /* Our low-level entry point in arch/sparc/kernel/entry.S */
-extern void floppy_hardint(int irq, void *unused, struct pt_regs *regs);
+extern irqreturn_t floppy_hardint(int irq, void *unused, struct pt_regs *regs);
 
 static int sun_fd_request_irq(void)
 {
@@ -277,7 +277,7 @@
 static struct sun_pci_dma_op sun_pci_dma_current = { -1U, 0, 0, NULL};
 static struct sun_pci_dma_op sun_pci_dma_pending = { -1U, 0, 0, NULL};
 
-extern void floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern irqreturn_t floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 static unsigned char sun_pci_fd_inb(unsigned long port)
 {

-- 
Mathieu Chouquet-Stringer              E-Mail : mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
