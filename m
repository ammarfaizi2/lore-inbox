Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271738AbTGRNvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271753AbTGRNvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:51:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10117
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271738AbTGRNtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:49:43 -0400
Date: Fri, 18 Jul 2003 15:04:04 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181404.h6IE446Y017652@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: another batch of "invalid" not "illegal" fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/ia64/kernel/module.c linux-2.6.0-test1-ac2/arch/ia64/kernel/module.c
--- linux-2.6.0-test1/arch/ia64/kernel/module.c	2003-07-10 21:08:26.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/ia64/kernel/module.c	2003-07-15 18:01:27.000000000 +0100
@@ -164,7 +164,7 @@
 apply_imm64 (struct module *mod, struct insn *insn, uint64_t val)
 {
 	if (slot(insn) != 2) {
-		printk(KERN_ERR "%s: illegal slot number %d for IMM64\n",
+		printk(KERN_ERR "%s: invalid slot number %d for IMM64\n",
 		       mod->name, slot(insn));
 		return 0;
 	}
@@ -176,7 +176,7 @@
 apply_imm60 (struct module *mod, struct insn *insn, uint64_t val)
 {
 	if (slot(insn) != 2) {
-		printk(KERN_ERR "%s: illegal slot number %d for IMM60\n",
+		printk(KERN_ERR "%s: invalid slot number %d for IMM60\n",
 		       mod->name, slot(insn));
 		return 0;
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/m68k/apollo/dn_ints.c linux-2.6.0-test1-ac2/arch/m68k/apollo/dn_ints.c
--- linux-2.6.0-test1/arch/m68k/apollo/dn_ints.c	2003-07-10 21:12:11.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/m68k/apollo/dn_ints.c	2003-07-15 18:01:27.000000000 +0100
@@ -46,7 +46,7 @@
 int dn_request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id) {
 
   if((irq<0) || (irq>15)) {
-    printk("Trying to request illegal IRQ\n");
+    printk("Trying to request invalid IRQ\n");
     return -ENXIO;
   }
 
@@ -72,7 +72,7 @@
 void dn_free_irq(unsigned int irq, void *dev_id) {
 
   if((irq<0) || (irq>15)) {
-    printk("Trying to free illegal IRQ\n");
+    printk("Trying to free invalid IRQ\n");
     return ;
   }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/m68k/q40/q40ints.c linux-2.6.0-test1-ac2/arch/m68k/q40/q40ints.c
--- linux-2.6.0-test1/arch/m68k/q40/q40ints.c	2003-07-10 21:14:10.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/m68k/q40/q40ints.c	2003-07-15 18:01:27.000000000 +0100
@@ -171,7 +171,7 @@
 	  {
 	  case 1: case 2: case 8: case 9:
 	  case 12: case 13:
-	    printk("%s: ISA IRQ %d from %x illegal\n", __FUNCTION__, irq, (unsigned)dev_id);
+	    printk("%s: ISA IRQ %d from %x invalid\n", __FUNCTION__, irq, (unsigned)dev_id);
 	    return;
 	  case 11: irq=10;
 	  default:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/mips/mm/fault.c linux-2.6.0-test1-ac2/arch/mips/mm/fault.c
--- linux-2.6.0-test1/arch/mips/mm/fault.c	2003-07-10 21:06:49.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/mips/mm/fault.c	2003-07-15 18:01:27.000000000 +0100
@@ -162,7 +162,7 @@
 		tsk->thread.cp0_badvaddr = address;
 		tsk->thread.error_code = write;
 #if 0
-		printk("do_page_fault() #2: sending SIGSEGV to %s for illegal %s\n"
+		printk("do_page_fault() #2: sending SIGSEGV to %s for invalid %s\n"
 		       "%08lx (epc == %08lx, ra == %08lx)\n",
 		       tsk->comm,
 		       write ? "write access to" : "read access from",
