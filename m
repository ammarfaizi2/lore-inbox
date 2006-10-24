Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWJXIPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWJXIPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJXINx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:53 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:2034 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932435AbWJXINY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:24 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 2/8] AVR32: Silence some compile warnings
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 24 Oct 2006 10:12:40 +0200
Message-Id: <11616775662194-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11616775663220-git-send-email-hskinnemoen@atmel.com>
References: <1161677566706-git-send-email-hskinnemoen@atmel.com> <11616775663220-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silence a few compile warnings which are basically harmless, but
easy to fix.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/kernel/kprobes.c |    2 +-
 arch/avr32/kernel/module.c  |    4 ++--
 arch/avr32/kernel/ptrace.c  |    2 +-
 arch/avr32/mm/init.c        |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/avr32/kernel/kprobes.c b/arch/avr32/kernel/kprobes.c
index 6caf9e8..ca41fc1 100644
--- a/arch/avr32/kernel/kprobes.c
+++ b/arch/avr32/kernel/kprobes.c
@@ -109,7 +109,7 @@ static int __kprobes kprobe_handler(stru
 	void *addr = (void *)regs->pc;
 	int ret = 0;
 
-	pr_debug("kprobe_handler: kprobe_running=%d\n",
+	pr_debug("kprobe_handler: kprobe_running=%p\n",
 		 kprobe_running());
 
 	/*
diff --git a/arch/avr32/kernel/module.c b/arch/avr32/kernel/module.c
index dfc32f2..b599eae 100644
--- a/arch/avr32/kernel/module.c
+++ b/arch/avr32/kernel/module.c
@@ -263,7 +263,7 @@ int apply_relocate_add(Elf32_Shdr *sechd
 			 * value of PC.  Just subtract the value of
 			 * GOT, and we're done.
 			 */
-			pr_debug("GOTPC: PC=0x%lx, got_offset=0x%lx, core=0x%p\n",
+			pr_debug("GOTPC: PC=0x%x, got_offset=0x%lx, core=0x%p\n",
 				 relocation, module->arch.got_offset,
 				 module->module_core);
 			relocation -= ((unsigned long)module->module_core
@@ -282,7 +282,7 @@ int apply_relocate_add(Elf32_Shdr *sechd
 			    && (relocation & 0xffff0000) != 0xffff0000)
 				return reloc_overflow(module, "R_AVR32_GOT16S",
 						      relocation);
-			pr_debug("GOT reloc @ 0x%lx -> %lu\n",
+			pr_debug("GOT reloc @ 0x%x -> %u\n",
 				 rel->r_offset, relocation);
 			value = *location;
 			value = ((value & 0xffff0000)
diff --git a/arch/avr32/kernel/ptrace.c b/arch/avr32/kernel/ptrace.c
index 3c89e59..f2e81cd 100644
--- a/arch/avr32/kernel/ptrace.c
+++ b/arch/avr32/kernel/ptrace.c
@@ -157,7 +157,7 @@ long arch_ptrace(struct task_struct *chi
 	unsigned long tmp;
 	int ret;
 
-	pr_debug("arch_ptrace(%ld, %ld, %#lx, %#lx)\n",
+	pr_debug("arch_ptrace(%ld, %d, %#lx, %#lx)\n",
 		 request, child->pid, addr, data);
 
 	pr_debug("ptrace: Enabling monitor mode...\n");
diff --git a/arch/avr32/mm/init.c b/arch/avr32/mm/init.c
index 3e6c410..70da689 100644
--- a/arch/avr32/mm/init.c
+++ b/arch/avr32/mm/init.c
@@ -206,7 +206,7 @@ void __init setup_bootmem(void)
 
 	if (mem_ramdisk) {
 #ifdef CONFIG_BLK_DEV_INITRD
-		initrd_start = __va(mem_ramdisk->addr);
+		initrd_start = (unsigned long)__va(mem_ramdisk->addr);
 		initrd_end = initrd_start + mem_ramdisk->size;
 
 		print_memory_map("RAMDISK images", mem_ramdisk);
-- 
1.4.1.1

