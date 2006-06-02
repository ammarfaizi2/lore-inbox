Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWFBNCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWFBNCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWFBNCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:02:31 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:64309
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751251AbWFBNCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:02:30 -0400
Message-Id: <4480532F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 02 Jun 2006 15:03:11 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andreas Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fall back to old-style call trace if no
	unwinding is possible
References: <448042C1.76E4.0078.0@novell.com> <20060602115709.GA29066@elte.hu> <44804D2B.76E4.0078.0@novell.com> <20060602124236.GA2732@elte.hu>
In-Reply-To: <20060602124236.GA2732@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It might well be that it applies cleanly to -mm2, but that's not what I applied it against (and in that case there must
be other cleanup/beautification patches already in -mm2). If I'm expected to do this then this won't be today, and in no
case will I have time to pull down any git trees in case merging against stuff newer than -mm2 is requested. Jan

>>> Ingo Molnar <mingo@elte.hu> 02.06.06 14:42 >>>

* Jan Beulich <jbeulich@novell.com> wrote:

> >hm, could you please merge this ontop of the stacktrace-output 
> >beautification patch below that Andrew already has in his post-mm2 tree? 
> >(or the other way around - whichever you prefer)
> 
> Here we go - but I'm afraid the patch you sent wasn't complete - even 
> after resolving its rejects, [...]

hm, it shouldnt have had rejects - it applies to -mm2 cleanly. I've 
attached the patch below that Andrew ended up appying.

	Ingo

--------------
The patch titled

     beautify x86_64 backtraces

has been added to the -mm tree.  Its filename is

     lock-validator-beautify-x86_64-stacktraces-fix-2.patch

See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
out what to do about this

------------------------------------------------------
Subject: beautify x86_64 backtraces
From: Ingo Molnar <mingo@elte.hu>


make x86_64 stack backtraces human-readable.

Before:

sshd          S ffff810033d05bf8     0  3119   2816  3121               (NOTLB)
ffff810033d05bf8 00000000000614d7 ffff810034b230b8 ffff810034b22ee0
       ffffffff8062c900 0000003835024076 0000000034b23680 ffff810034b22ee0
       0000000000000000 ffffffff80502099
Call Trace:
  [<ffffffff804ffc51>] schedule_timeout+0x22/0xb3
        [<ffffffff804e98a3>] unix_stream_recvmsg+0x274/0x561
        [<ffffffff80497124>] do_sock_read+0x9b/0x9f
        [<ffffffff80497271>] sock_aio_read+0x57/0x67
        [<ffffffff8027976e>] do_sync_read+0xf0/0x12e
        [<ffffffff80279a10>] vfs_read+0xe5/0x17e  [<ffffffff8027a505>] sys_read+0x45/0x6e
        [<ffffffff8020946a>] system_call+0x7e/0x83

After:

sshd          S ffff81003981dbf8     0  2875   2805  2878               (NOTLB)
 ffff81003981dbf8 0000000000001592 ffff81003f5ce3e8 ffff81003f5ce210
 ffff81003ffaa0d0 00000009afd9e025 000000013f5ce9b0 ffff81003f5ce210
 0000000000000000 ffffffff80502049
Call Trace:
 [<ffffffff804ffc01>] schedule_timeout+0x22/0xb3
 [<ffffffff804e9853>] unix_stream_recvmsg+0x274/0x561
 [<ffffffff804970d4>] do_sock_read+0x9b/0x9f
 [<ffffffff80497221>] sock_aio_read+0x57/0x67
 [<ffffffff8027971e>] do_sync_read+0xf0/0x12e
 [<ffffffff802799c0>] vfs_read+0xe5/0x17e
 [<ffffffff8027a4b5>] sys_read+0x45/0x6e
 [<ffffffff8020946a>] system_call+0x7e/0x83

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/kernel/process.c |    2 +-
 arch/x86_64/kernel/traps.c   |   27 +++++++++++----------------
 arch/x86_64/mm/fault.c       |    1 -
 include/asm-x86_64/kdebug.h  |    2 +-
 4 files changed, 13 insertions(+), 19 deletions(-)

diff -puN arch/x86_64/kernel/process.c~lock-validator-beautify-x86_64-stacktraces-fix-2 arch/x86_64/kernel/process.c
--- 25/arch/x86_64/kernel/process.c~lock-validator-beautify-x86_64-stacktraces-fix-2	Thu Jun  1 13:02:38 2006
+++ 25-akpm/arch/x86_64/kernel/process.c	Thu Jun  1 13:02:38 2006
@@ -296,7 +296,7 @@ void __show_regs(struct pt_regs * regs)
 		init_utsname()->version);
 	printk("RIP: %04lx:[<%016lx>] ", regs->cs & 0xffff, regs->rip);
 	printk_address(regs->rip); 
-	printk("\nRSP: %04lx:%016lx  EFLAGS: %08lx\n", regs->ss, regs->rsp,
+	printk("RSP: %04lx:%016lx  EFLAGS: %08lx\n", regs->ss, regs->rsp,
 		regs->eflags);
 	printk("RAX: %016lx RBX: %016lx RCX: %016lx\n",
 	       regs->rax, regs->rbx, regs->rcx);
diff -puN arch/x86_64/kernel/traps.c~lock-validator-beautify-x86_64-stacktraces-fix-2 arch/x86_64/kernel/traps.c
--- 25/arch/x86_64/kernel/traps.c~lock-validator-beautify-x86_64-stacktraces-fix-2	Thu Jun  1 13:02:38 2006
+++ 25-akpm/arch/x86_64/kernel/traps.c	Thu Jun  1 13:02:38 2006
@@ -110,7 +110,7 @@ static int kstack_depth_to_print = 10;
 
 #ifdef CONFIG_KALLSYMS
 # include <linux/kallsyms.h>
-int printk_address(unsigned long address)
+void printk_address(unsigned long address)
 {
 	unsigned long offset = 0, symsize;
 	const char *symname;
@@ -120,17 +120,19 @@ int printk_address(unsigned long address
 
 	symname = kallsyms_lookup(address, &symsize, &offset,
 					&modname, namebuf);
-	if (!symname)
-		return printk(" [<%016lx>]", address);
+	if (!symname) {
+		printk(" [<%016lx>]\n", address);
+		return;
+	}
 	if (!modname)
 		modname = delim = ""; 		
-	return printk(" [<%016lx>] %s%s%s%s+0x%lx/0x%lx",
+	printk(" [<%016lx>] %s%s%s%s+0x%lx/0x%lx\n",
 		address, delim, modname, delim, symname, offset, symsize);
 }
 #else
-int printk_address(unsigned long address)
+void printk_address(unsigned long address)
 {
-	return printk(" [<%016lx>]", address);
+	printk(" [<%016lx>]\n", address);
 }
 #endif
 
@@ -193,15 +195,8 @@ static unsigned long *in_exception_stack
 
 static void show_trace_unwind(struct unwind_frame_info *info, void *context)
 {
-	int i = 11;
-
 	while (unwind(info) == 0 && UNW_PC(info)) {
-		if (i > 50) {
-			printk("\n       ");
-			i = 7;
-		} else
-			i += printk(" ");
-		i += printk_address(UNW_PC(info));
+		printk_address(UNW_PC(info));
 		if (arch_unw_user_mode(info))
 			break;
 	}
@@ -325,8 +320,8 @@ static void _show_stack(struct task_stru
 			break;
 		}
 		if (i && ((i % 4) == 0))
-			printk("\n       ");
-		printk("%016lx ", *stack++);
+			printk("\n");
+		printk(" %016lx", *stack++);
 		touch_nmi_watchdog();
 	}
 	show_trace(tsk, regs, rsp);
diff -puN arch/x86_64/mm/fault.c~lock-validator-beautify-x86_64-stacktraces-fix-2 arch/x86_64/mm/fault.c
--- 25/arch/x86_64/mm/fault.c~lock-validator-beautify-x86_64-stacktraces-fix-2	Thu Jun  1 13:02:38 2006
+++ 25-akpm/arch/x86_64/mm/fault.c	Thu Jun  1 13:02:38 2006
@@ -569,7 +569,6 @@ no_context:
 		printk(KERN_ALERT "Unable to handle kernel paging request");
 	printk(" at %016lx RIP: \n" KERN_ALERT,address);
 	printk_address(regs->rip);
-	printk("\n");
 	dump_pagetable(address);
 	tsk->thread.cr2 = address;
 	tsk->thread.trap_no = 14;
diff -puN include/asm-x86_64/kdebug.h~lock-validator-beautify-x86_64-stacktraces-fix-2 include/asm-x86_64/kdebug.h
--- 25/include/asm-x86_64/kdebug.h~lock-validator-beautify-x86_64-stacktraces-fix-2	Thu Jun  1 13:02:38 2006
+++ 25-akpm/include/asm-x86_64/kdebug.h	Thu Jun  1 13:02:38 2006
@@ -49,7 +49,7 @@ static inline int notify_die(enum die_va
 	return atomic_notifier_call_chain(&die_chain, val, &args);
 } 
 
-extern int printk_address(unsigned long address);
+extern void printk_address(unsigned long address);
 extern void die(const char *,struct pt_regs *,long);
 extern void __die(const char *,struct pt_regs *,long);
 extern void show_registers(struct pt_regs *regs);
_

Patches currently in -mm which might be from mingo@elte.hu are

origin.patch
git-acpi.patch
fix-drivers-mfd-ucb1x00-corec-irq-probing-bug.patch
git-infiniband.patch
git-netdev-all.patch
fix-for-serial-uart-lockup.patch
lock-validator-lockdep-small-xfs-init_rwsem-cleanup.patch
swapless-pm-add-r-w-migration-entries.patch
i386-break-out-of-recursion-in-stackframe-walk.patch
x86-re-enable-generic-numa.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-tidy.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-arch_vma_name-fix.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386-2.patch
work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
kernel-kernel-cpuc-to-mutexes.patch
cond-resched-might-sleep-fix.patch
define-__raw_get_cpu_var-and-use-it.patch
ide-cd-end-of-media-error-fix.patch
spin-rwlock-init-cleanups.patch
lock-validator-introduce-warn_on_oncecond.patch
emu10k1-mark-midi_spinlock-as-used.patch
time-clocksource-infrastructure.patch
sched-comment-bitmap-size-accounting.patch
sched-fix-interactive-ceiling-code.patch
sched-implement-smpnice.patch
sched-protect-calculation-of-max_pull-from-integer-wrap.patch
sched-store-weighted-load-on-up.patch
sched-add-discrete-weighted-cpu-load-function.patch
sched-prevent-high-load-weight-tasks-suppressing-balancing.patch
sched-improve-stability-of-smpnice-load-balancing.patch
sched-improve-smpnice-load-balancing-when-load-per-task.patch
smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing.patch
smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing-fix.patch
sched-modify-move_tasks-to-improve-load-balancing-outcomes.patch
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks-fix-2.patch
sched_domain-handle-kmalloc-failure.patch
sched_domain-handle-kmalloc-failure-fix.patch
sched_domain-dont-use-gfp_atomic.patch
sched_domain-use-kmalloc_node.patch
sched_domain-allocate-sched_group-structures-dynamically.patch
sched-add-above-background-load-function.patch
mm-implement-swap-prefetching-fix.patch
pi-futex-futex-code-cleanups.patch
pi-futex-robust-futex-docs-fix.patch
pi-futex-introduce-debug_check_no_locks_freed.patch
pi-futex-introduce-warn_on_smp.patch
pi-futex-add-plist-implementation.patch
pi-futex-scheduler-support-for-pi.patch
pi-futex-rt-mutex-core.patch
pi-futex-rt-mutex-docs.patch
pi-futex-rt-mutex-docs-update.patch
pi-futex-rt-mutex-debug.patch
pi-futex-rt-mutex-tester.patch
pi-futex-rt-mutex-futex-api.patch
pi-futex-futex_lock_pi-futex_unlock_pi-support.patch
futex_requeue-optimization.patch
genirq-rename-desc-handler-to-desc-chip.patch
genirq-rename-desc-handler-to-desc-chip-power-fix.patch
genirq-rename-desc-handler-to-desc-chip-ia64-fix.patch
genirq-rename-desc-handler-to-desc-chip-ia64-fix-2.patch
genirq-sem2mutex-probe_sem-probing_active.patch
genirq-cleanup-merge-irq_affinity-into-irq_desc.patch
genirq-cleanup-remove-irq_descp.patch
genirq-cleanup-remove-irq_descp-fix.patch
genirq-cleanup-remove-fastcall.patch
genirq-cleanup-misc-code-cleanups.patch
genirq-cleanup-reduce-irq_desc_t-use-mark-it-obsolete.patch
genirq-cleanup-include-linux-irqh.patch
genirq-cleanup-merge-irq_dir-smp_affinity_entry-into-irq_desc.patch
genirq-cleanup-merge-pending_irq_cpumask-into-irq_desc.patch
genirq-cleanup-turn-arch_has_irq_per_cpu-into-config_irq_per_cpu.patch
genirq-debug-better-debug-printout-in-enable_irq.patch
genirq-add-retrigger-irq-op-to-consolidate-hw_irq_resend.patch
genirq-doc-comment-include-linux-irqh-structures.patch
genirq-doc-handle_irq_event-and-__do_irq-comments.patch
genirq-cleanup-no_irq_type-cleanups.patch
genirq-doc-add-design-documentation.patch
genirq-add-genirq-sw-irq-retrigger.patch
genirq-add-irq_noprobe-support.patch
genirq-add-irq_norequest-support.patch
genirq-add-irq_noautoen-support.patch
genirq-update-copyrights.patch
genirq-core.patch
genirq-msi-fixes-2.patch
genirq-add-irq-chip-support.patch
genirq-add-handle_bad_irq.patch
genirq-add-irq-wake-power-management-support.patch
genirq-add-sa_trigger-support.patch
genirq-cleanup-no_irq_type-no_irq_chip-rename.patch
genirq-convert-the-x86_64-architecture-to-irq-chips.patch
genirq-convert-the-i386-architecture-to-irq-chips.patch
genirq-convert-the-i386-architecture-to-irq-chips-fix-2.patch
genirq-more-verbose-debugging-on-unexpected-irq-vectors.patch
genirq-add-chip-eoi-fastack-fasteoi.patch
lock-validator-floppyc-irq-release-fix.patch
lock-validator-forcedethc-fix.patch
lock-validator-mutex-section-binutils-workaround.patch
lock-validator-add-__module_address-method.patch
lock-validator-better-lock-debugging.patch
lock-validator-locking-api-self-tests.patch
lock-validator-locking-init-debugging-improvement.patch
lock-validator-beautify-x86_64-stacktraces.patch
lock-validator-beautify-x86_64-stacktraces-fix.patch
lock-validator-beautify-x86_64-stacktraces-fix-2.patch
lock-validator-x86_64-document-stack-frame-internals.patch
lock-validator-stacktrace.patch
lock-validator-stacktrace-build-fix.patch
lock-validator-stacktrace-warning-fix.patch
lock-validator-stacktrace-fix-on-x86_64.patch
lock-validator-fown-locking-workaround.patch
lock-validator-sk_callback_lock-workaround.patch
lock-validator-irqtrace-core.patch
lock-validator-irqtrace-core-powerpc-fix-1.patch
lock-validator-irqtrace-core-non-x86-fix.patch
lock-validator-irqtrace-core-non-x86-fix-2.patch
lock-validator-irqtrace-core-non-x86-fix-3.patch
lock-validator-irqtrace-entrys-fix.patch
lock-validator-irqtrace-core-remove-softirqc-warn_on.patch
lock-validator-irqtrace-cleanup-include-asm-i386-irqflagsh.patch
lock-validator-irqtrace-cleanup-include-asm-x86_64-irqflagsh.patch
lock-validator-x86_64-irqflags-trace-entrys-fix.patch
lock-validator-lockdep-add-local_irq_enable_in_hardirq-api.patch
lock-validator-add-per_cpu_offset.patch
lock-validator-add-per_cpu_offset-fix.patch
lock-validator-core.patch
lock-validator-procfs.patch
lock-validator-core-multichar-fix.patch
lock-validator-core-count_matching_names-fix.patch
lock-validator-design-docs.patch
lock-validator-prove-rwsem-locking-correctness.patch
lock-validator-prove-rwsem-locking-correctness-fix.patch
lock-validator-prove-rwsem-locking-correctness-powerpc-fix.patch
lock-validator-prove-spinlock-rwlock-locking-correctness.patch
lock-validator-prove-mutex-locking-correctness.patch
lock-validator-prove-mutex-locking-correctness-fix-null-type-name-bug.patch
lock-validator-print-all-lock-types-on-sysrq-d.patch
lock-validator-x86_64-early-init.patch
lock-validator-smp-alternatives-workaround.patch
lock-validator-do-not-recurse-in-printk.patch
lock-validator-disable-nmi-watchdog-if-config_lockdep.patch
lock-validator-disable-nmi-watchdog-if-config_lockdep-i386.patch
lock-validator-disable-nmi-watchdog-if-config_lockdep-x86_64.patch
lock-validator-special-locking-bdev.patch
lock-validator-special-locking-direct-io.patch
lock-validator-special-locking-serial.patch
lock-validator-special-locking-serial-fix.patch
lock-validator-special-locking-dcache.patch
lock-validator-special-locking-i_mutex.patch
lock-validator-special-locking-s_lock.patch
lock-validator-special-locking-futex.patch
lock-validator-special-locking-genirq.patch
lock-validator-special-locking-completions.patch
lock-validator-special-locking-waitqueues.patch
lock-validator-special-locking-mm.patch
lock-validator-special-locking-slab.patch
lock-validator-special-locking-skb_queue_head_init.patch
lock-validator-special-locking-net-ipv4-igmpcpatch.patch
lock-validator-special-locking-net-ipv4-igmpc-2.patch
lock-validator-special-locking-timerc.patch
lock-validator-special-locking-schedc.patch
lock-validator-special-locking-hrtimerc.patch
lock-validator-special-locking-sock_lock_init.patch
lock-validator-special-locking-af_unix.patch
lock-validator-special-locking-bh_lock_sock.patch
lock-validator-special-locking-mmap_sem.patch
lock-validator-special-locking-sb-s_umount.patch
lock-validator-special-locking-sb-s_umount-fix.patch
lock-validator-special-locking-sb-s_umount-2.patch
lock-validator-special-locking-sb-s_umount-2-fix.patch
lockdep-annotate-rpc_populate-for.patch
lock-validator-special-locking-jbd.patch
lock-validator-special-locking-posix-timers.patch
lock-validator-special-locking-sch_genericc.patch
lock-validator-special-locking-xfrm.patch
lock-validator-special-locking-sound-core-seq-seq_portsc.patch
lock-validator-special-locking-sound-core-seq-seq_devicec.patch
lock-validator-special-locking-sound-core-seq-seq_devicec-fix.patch
lock-validator-fix-rt_hash_lock_sz.patch
lock-validator-introduce-irq__lockdep.patch
locking-validator-special-rule-8390c-disable_irq.patch
locking-validator-special-rule-3c59xc-disable_irq.patch
lock-validator-enable-lock-validator-in-kconfig.patch
lock-validator-enable-lock-validator-in-kconfig-require-trace_irqflags_support.patch
lock-validator-enable-lock-validator-in-kconfig-not-yet.patch
lockdep-one-stacktrace-column-if-config_lockdep=y.patch
lockdep-further-improve-stacktrace-output.patch
lock-validator-irqtrace-support-non-x86-architectures.patch
lock-validator-disable-oprofile-if-lockdep=y.patch
lock-validator-select-kallsyms_all.patch
lock-validator-special-locking-kgdb.patch
detect-atomic-counter-underflows.patch
debug-shared-irqs.patch
make-frame_pointer-default=y.patch
mutex-subsystem-synchro-test-module.patch
vdso-print-fatal-signals.patch
vdso-improve-print_fatal_signals-support-by-adding-memory-maps.patch

-
To unsubscribe from this list: send the line "unsubscribe mm-commits" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html
