Return-Path: <linux-kernel-owner+w=401wt.eu-S1762274AbWLJRMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762274AbWLJRMr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 12:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762275AbWLJRMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 12:12:47 -0500
Received: from il.qumranet.com ([62.219.232.206]:33999 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762274AbWLJRMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 12:12:45 -0500
Subject: [PATCH 4/4] KVM: Replace __x86_64__ with CONFIG_X86_64
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 10 Dec 2006 17:12:42 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457C3F26.2090100@qumranet.com>
In-Reply-To: <457C3F26.2090100@qumranet.com>
Message-Id: <20061210171242.820E22500CF@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per akpm's request.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -140,7 +140,7 @@ enum {
 	VCPU_REGS_RBP = 5,
 	VCPU_REGS_RSI = 6,
 	VCPU_REGS_RDI = 7,
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	VCPU_REGS_R8 = 8,
 	VCPU_REGS_R9 = 9,
 	VCPU_REGS_R10 = 10,
@@ -375,7 +375,7 @@ void set_cr4(struct kvm_vcpu *vcpu, unsi
 void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr0);
 void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 void set_efer(struct kvm_vcpu *vcpu, u64 efer);
 #endif
 
@@ -485,7 +485,7 @@ static inline unsigned long read_tr_base
 	return segment_base(tr);
 }
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 static inline unsigned long read_msr(unsigned long msr)
 {
 	u64 value;
@@ -533,7 +533,7 @@ static inline u32 get_rdx_init_val(void)
 #define TSS_REDIRECTION_SIZE (256 / 8)
 #define RMODE_TSS_SIZE (TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 
 /*
  * When emulating 32-bit mode, cr3 is only 32 bits even on x86_64.  Therefore
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -72,7 +72,7 @@ static struct dentry *debugfs_dir;
 #define CR8_RESEVED_BITS (~0x0fULL)
 #define EFER_RESERVED_BITS 0xfffffffffffff2fe
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 // LDT or TSS descriptor in the GDT. 16 bytes.
 struct segment_descriptor_64 {
 	struct segment_descriptor s;
@@ -104,7 +104,7 @@ unsigned long segment_base(u16 selector)
 	}
 	d = (struct segment_descriptor *)(table_base + (selector & ~7));
 	v = d->base_low | ((ul)d->base_mid << 16) | ((ul)d->base_high << 24);
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	if (d->system == 0
 	    && (d->type == 2 || d->type == 9 || d->type == 11))
 		v |= ((ul)((struct segment_descriptor_64 *)d)->base_higher) << 32;
@@ -340,7 +340,7 @@ void set_cr0(struct kvm_vcpu *vcpu, unsi
 	}
 
 	if (!is_paging(vcpu) && (cr0 & CR0_PG_MASK)) {
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		if ((vcpu->shadow_efer & EFER_LME)) {
 			int cs_db, cs_l;
 
@@ -1109,7 +1109,7 @@ static int get_msr(struct kvm_vcpu *vcpu
 	return kvm_arch_ops->get_msr(vcpu, msr_index, pdata);
 }
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 
 void set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
@@ -1226,7 +1226,7 @@ static int kvm_dev_ioctl_get_regs(struct
 	regs->rdi = vcpu->regs[VCPU_REGS_RDI];
 	regs->rsp = vcpu->regs[VCPU_REGS_RSP];
 	regs->rbp = vcpu->regs[VCPU_REGS_RBP];
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	regs->r8 = vcpu->regs[VCPU_REGS_R8];
 	regs->r9 = vcpu->regs[VCPU_REGS_R9];
 	regs->r10 = vcpu->regs[VCPU_REGS_R10];
@@ -1270,7 +1270,7 @@ static int kvm_dev_ioctl_set_regs(struct
 	vcpu->regs[VCPU_REGS_RDI] = regs->rdi;
 	vcpu->regs[VCPU_REGS_RSP] = regs->rsp;
 	vcpu->regs[VCPU_REGS_RBP] = regs->rbp;
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	vcpu->regs[VCPU_REGS_R8] = regs->r8;
 	vcpu->regs[VCPU_REGS_R9] = regs->r9;
 	vcpu->regs[VCPU_REGS_R10] = regs->r10;
@@ -1384,7 +1384,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 	vcpu->cr8 = sregs->cr8;
 
 	mmu_reset_needed |= vcpu->shadow_efer != sregs->efer;
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	kvm_arch_ops->set_efer(vcpu, sregs->efer);
 #endif
 	vcpu->apic_base = sregs->apic_base;
@@ -1417,7 +1417,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 static u32 msrs_to_save[] = {
 	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
 	MSR_K6_STAR,
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
 #endif
 	MSR_IA32_TIME_STAMP_COUNTER,
Index: linux-2.6/drivers/kvm/kvm_svm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_svm.h
+++ linux-2.6/drivers/kvm/kvm_svm.h
@@ -9,7 +9,7 @@
 #include "kvm.h"
 
 static const u32 host_save_msrs[] = {
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	MSR_STAR, MSR_LSTAR, MSR_CSTAR, MSR_SYSCALL_MASK, MSR_KERNEL_GS_BASE,
 	MSR_FS_BASE, MSR_GS_BASE,
 #endif
Index: linux-2.6/drivers/kvm/kvm_vmx.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_vmx.h
+++ linux-2.6/drivers/kvm/kvm_vmx.h
@@ -1,7 +1,7 @@
 #ifndef __KVM_VMX_H
 #define __KVM_VMX_H
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 /*
  * avoid save/load MSR_SYSCALL_MASK and MSR_LSTAR by std vt
  * mechanism (cpu bug AA24)
Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -287,7 +287,7 @@ static void svm_hardware_enable(void *ga
 
 	struct svm_cpu_data *svm_data;
 	uint64_t efer;
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	struct desc_ptr gdt_descr;
 #else
 	struct Xgt_desc_struct gdt_descr;
@@ -397,7 +397,7 @@ static __init int svm_hardware_setup(voi
 	memset(msrpm_va, 0xff, PAGE_SIZE * (1 << MSRPM_ALLOC_ORDER));
 	msrpm_base = page_to_pfn(msrpm_pages) << PAGE_SHIFT;
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	set_msr_interception(msrpm_va, MSR_GS_BASE, 1, 1);
 	set_msr_interception(msrpm_va, MSR_FS_BASE, 1, 1);
 	set_msr_interception(msrpm_va, MSR_KERNEL_GS_BASE, 1, 1);
@@ -704,7 +704,7 @@ static void svm_set_gdt(struct kvm_vcpu 
 
 static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	if (vcpu->shadow_efer & KVM_EFER_LME) {
 		if (!is_paging(vcpu) && (cr0 & CR0_PG_MASK)) {
 			vcpu->shadow_efer |= KVM_EFER_LMA;
@@ -1097,7 +1097,7 @@ static int svm_get_msr(struct kvm_vcpu *
 	case MSR_IA32_APICBASE:
 		*data = vcpu->apic_base;
 		break;
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	case MSR_STAR:
 		*data = vcpu->svm->vmcb->save.star;
 		break;
@@ -1149,7 +1149,7 @@ static int rdmsr_interception(struct kvm
 static int svm_set_msr(struct kvm_vcpu *vcpu, unsigned ecx, u64 data)
 {
 	switch (ecx) {
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	case MSR_EFER:
 		set_efer(vcpu, data);
 		break;
@@ -1172,7 +1172,7 @@ static int svm_set_msr(struct kvm_vcpu *
 	case MSR_IA32_APICBASE:
 		vcpu->apic_base = data;
 		break;
-#ifdef __x86_64___
+#ifdef CONFIG_X86_64_
 	case MSR_STAR:
 		vcpu->svm->vmcb->save.star = data;
 		break;
@@ -1387,7 +1387,7 @@ again:
 		load_db_regs(vcpu->svm->db_regs);
 	}
 	asm volatile (
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		"push %%rbx; push %%rcx; push %%rdx;"
 		"push %%rsi; push %%rdi; push %%rbp;"
 		"push %%r8;  push %%r9;  push %%r10; push %%r11;"
@@ -1397,7 +1397,7 @@ again:
 		"push %%esi; push %%edi; push %%ebp;"
 #endif
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		"mov %c[rbx](%[vcpu]), %%rbx \n\t"
 		"mov %c[rcx](%[vcpu]), %%rcx \n\t"
 		"mov %c[rdx](%[vcpu]), %%rdx \n\t"
@@ -1421,7 +1421,7 @@ again:
 		"mov %c[rbp](%[vcpu]), %%ebp \n\t"
 #endif
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		/* Enter guest mode */
 		"push %%rax \n\t"
 		"mov %c[svm](%[vcpu]), %%rax \n\t"
@@ -1442,7 +1442,7 @@ again:
 #endif
 
 		/* Save guest registers, load host registers */
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		"mov %%rbx, %c[rbx](%[vcpu]) \n\t"
 		"mov %%rcx, %c[rcx](%[vcpu]) \n\t"
 		"mov %%rdx, %c[rdx](%[vcpu]) \n\t"
@@ -1483,7 +1483,7 @@ again:
 		  [rsi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RSI])),
 		  [rdi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RDI])),
 		  [rbp]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RBP]))
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		  ,[r8 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R8 ])),
 		  [r9 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R9 ])),
 		  [r10]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R10])),
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -34,7 +34,7 @@ MODULE_LICENSE("GPL");
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 #define HOST_IS_64 1
 #else
 #define HOST_IS_64 0
@@ -71,7 +71,7 @@ static struct kvm_vmx_segment_field {
 };
 
 static const u32 vmx_msr_index[] = {
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	MSR_SYSCALL_MASK, MSR_LSTAR, MSR_CSTAR, MSR_KERNEL_GS_BASE,
 #endif
 	MSR_EFER, MSR_K6_STAR,
@@ -146,7 +146,7 @@ static u32 vmcs_read32(unsigned long fie
 
 static u64 vmcs_read64(unsigned long field)
 {
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	return vmcs_readl(field);
 #else
 	return vmcs_readl(field) | ((u64)vmcs_readl(field+1) << 32);
@@ -176,7 +176,7 @@ static void vmcs_write32(unsigned long f
 
 static void vmcs_write64(unsigned long field, u64 value)
 {
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	vmcs_writel(field, value);
 #else
 	vmcs_writel(field, value);
@@ -305,7 +305,7 @@ static void guest_write_tsc(u64 guest_ts
 
 static void reload_tss(void)
 {
-#ifndef __x86_64__
+#ifndef CONFIG_X86_64
 
 	/*
 	 * VT restores TR but not its size.  Useless.
@@ -336,7 +336,7 @@ static int vmx_get_msr(struct kvm_vcpu *
 	}
 
 	switch (msr_index) {
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	case MSR_FS_BASE:
 		data = vmcs_readl(GUEST_FS_BASE);
 		break;
@@ -399,7 +399,7 @@ static int vmx_set_msr(struct kvm_vcpu *
 {
 	struct vmx_msr_entry *msr;
 	switch (msr_index) {
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	case MSR_FS_BASE:
 		vmcs_writel(GUEST_FS_BASE, data);
 		break;
@@ -734,7 +734,7 @@ static void enter_rmode(struct kvm_vcpu 
 	fix_rmode_seg(VCPU_SREG_FS, &vcpu->rmode.fs);
 }
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 
 static void enter_lmode(struct kvm_vcpu *vcpu)
 {
@@ -776,7 +776,7 @@ static void vmx_set_cr0(struct kvm_vcpu 
 	if (!vcpu->rmode.active && !(cr0 & CR0_PE_MASK))
 		enter_rmode(vcpu);
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	if (vcpu->shadow_efer & EFER_LME) {
 		if (!is_paging(vcpu) && (cr0 & CR0_PG_MASK))
 			enter_lmode(vcpu);
@@ -817,7 +817,7 @@ static void vmx_set_cr4(struct kvm_vcpu 
 	vcpu->cr4 = cr4;
 }
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 
 static void vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
@@ -1106,7 +1106,7 @@ static int vmx_vcpu_setup(struct kvm_vcp
 	vmcs_write16(HOST_FS_SELECTOR, read_fs());    /* 22.2.4 */
 	vmcs_write16(HOST_GS_SELECTOR, read_gs());    /* 22.2.4 */
 	vmcs_write16(HOST_SS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	rdmsrl(MSR_FS_BASE, a);
 	vmcs_writel(HOST_FS_BASE, a); /* 22.2.4 */
 	rdmsrl(MSR_GS_BASE, a);
@@ -1184,7 +1184,7 @@ static int vmx_vcpu_setup(struct kvm_vcp
 	vcpu->cr0 = 0x60000010;
 	vmx_set_cr0(vcpu, vcpu->cr0); // enter rmode
 	vmx_set_cr4(vcpu, 0);
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	vmx_set_efer(vcpu, 0);
 #endif
 
@@ -1700,7 +1700,7 @@ again:
 		vmcs_write16(HOST_GS_SELECTOR, 0);
 	}
 
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	vmcs_writel(HOST_FS_BASE, read_msr(MSR_FS_BASE));
 	vmcs_writel(HOST_GS_BASE, read_msr(MSR_GS_BASE));
 #else
@@ -1724,7 +1724,7 @@ again:
 	asm (
 		/* Store host registers */
 		"pushf \n\t"
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		"push %%rax; push %%rbx; push %%rdx;"
 		"push %%rsi; push %%rdi; push %%rbp;"
 		"push %%r8;  push %%r9;  push %%r10; push %%r11;"
@@ -1738,7 +1738,7 @@ again:
 		/* Check if vmlaunch of vmresume is needed */
 		"cmp $0, %1 \n\t"
 		/* Load guest registers.  Don't clobber flags. */
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		"mov %c[cr2](%3), %%rax \n\t"
 		"mov %%rax, %%cr2 \n\t"
 		"mov %c[rax](%3), %%rax \n\t"
@@ -1775,7 +1775,7 @@ again:
 		".globl kvm_vmx_return \n\t"
 		"kvm_vmx_return: "
 		/* Save guest registers, load host registers, keep flags */
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		"xchg %3,     0(%%rsp) \n\t"
 		"mov %%rax, %c[rax](%3) \n\t"
 		"mov %%rbx, %c[rbx](%3) \n\t"
@@ -1827,7 +1827,7 @@ again:
 		[rsi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RSI])),
 		[rdi]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RDI])),
 		[rbp]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RBP])),
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 		[r8 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R8 ])),
 		[r9 ]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R9 ])),
 		[r10]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_R10])),
@@ -1848,7 +1848,7 @@ again:
 	fx_save(vcpu->guest_fx_image);
 	fx_restore(vcpu->host_fx_image);
 
-#ifndef __x86_64__
+#ifndef CONFIG_X86_64
 	asm ("mov %0, %%ds; mov %0, %%es" : : "r"(__USER_DS));
 #endif
 
@@ -1866,7 +1866,7 @@ again:
 			 */
 			local_irq_disable();
 			load_gs(gs_sel);
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 			wrmsrl(MSR_GS_BASE, vmcs_readl(HOST_GS_BASE));
 #endif
 			local_irq_enable();
@@ -1976,7 +1976,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.set_cr0_no_modeswitch = vmx_set_cr0_no_modeswitch,
 	.set_cr3 = vmx_set_cr3,
 	.set_cr4 = vmx_set_cr4,
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	.set_efer = vmx_set_efer,
 #endif
 	.get_idt = vmx_get_idt,
Index: linux-2.6/drivers/kvm/x86_emulate.c
===================================================================
--- linux-2.6.orig/drivers/kvm/x86_emulate.c
+++ linux-2.6/drivers/kvm/x86_emulate.c
@@ -238,7 +238,7 @@ struct operand {
  * any modified flags.
  */
 
-#if defined(__x86_64__)
+#if defined(CONFIG_X86_64)
 #define _LO32 "k"		/* force 32-bit operand */
 #define _STK  "%%rsp"		/* stack pointer */
 #elif defined(__i386__)
@@ -385,7 +385,7 @@ struct operand {
 	} while (0)
 
 /* Emulate an instruction with quadword operands (x86/64 only). */
-#if defined(__x86_64__)
+#if defined(CONFIG_X86_64)
 #define __emulate_2op_8byte(_op, _src, _dst, _eflags, _qx, _qy)           \
 	do {								  \
 		__asm__ __volatile__ (					  \
@@ -495,7 +495,7 @@ x86_emulate_memop(struct x86_emulate_ctx
 	case X86EMUL_MODE_PROT32:
 		op_bytes = ad_bytes = 4;
 		break;
-#ifdef __x86_64__
+#ifdef CONFIG_X86_64
 	case X86EMUL_MODE_PROT64:
 		op_bytes = 4;
 		ad_bytes = 8;
@@ -1341,7 +1341,7 @@ twobyte_special_insn:
 			}
 			break;
 		}
-#elif defined(__x86_64__)
+#elif defined(CONFIG_X86_64)
 		{
 			unsigned long old, new;
 			if ((rc = ops->read_emulated(cr2, &old, 8, ctxt)) != 0)
Index: linux-2.6/drivers/kvm/x86_emulate.h
===================================================================
--- linux-2.6.orig/drivers/kvm/x86_emulate.h
+++ linux-2.6/drivers/kvm/x86_emulate.h
@@ -162,7 +162,7 @@ struct x86_emulate_ctxt {
 /* Host execution mode. */
 #if defined(__i386__)
 #define X86EMUL_MODE_HOST X86EMUL_MODE_PROT32
-#elif defined(__x86_64__)
+#elif defined(CONFIG_X86_64)
 #define X86EMUL_MODE_HOST X86EMUL_MODE_PROT64
 #endif
 
