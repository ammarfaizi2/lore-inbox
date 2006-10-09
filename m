Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWJILqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWJILqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWJILqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:46:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:19342 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932586AbWJILqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:46:53 -0400
Date: Mon, 9 Oct 2006 12:46:52 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fallout from alpha pt_regs patches
Message-ID: <20061009114652.GM29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

missed irq handler in sys_titan and forgotten prototype update.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/proto.h     |    2 +-
 arch/alpha/kernel/sys_titan.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index daccd4b..95912ec 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -36,7 +36,7 @@ extern void cia_pci_tbi(struct pci_contr
 extern struct pci_ops irongate_pci_ops;
 extern int irongate_pci_clr_err(void);
 extern void irongate_init_arch(void);
-extern void irongate_machine_check(u64, u64, struct pt_regs *);
+extern void irongate_machine_check(u64, u64);
 #define irongate_pci_tbi ((void *)0)
 
 /* core_lca.c */
diff --git a/arch/alpha/kernel/sys_titan.c b/arch/alpha/kernel/sys_titan.c
index 161d691..29ab7db 100644
--- a/arch/alpha/kernel/sys_titan.c
+++ b/arch/alpha/kernel/sys_titan.c
@@ -204,7 +204,7 @@ static struct hw_interrupt_type titan_ir
 };
 
 static irqreturn_t
-titan_intr_nop(int irq, void *dev_id, struct pt_regs *regs)                    
+titan_intr_nop(int irq, void *dev_id)
 {
       /*
        * This is a NOP interrupt handler for the purposes of
-- 
1.4.2.GIT

