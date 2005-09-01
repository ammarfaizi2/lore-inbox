Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbVIAT74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbVIAT74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbVIAT74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:59:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:64390 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030336AbVIAT7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:59:55 -0400
Date: Thu, 1 Sep 2005 21:59:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] m68k: indent sys_ptrace
Message-ID: <Pine.LNX.4.61.0509012158560.7106@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This reformats and properly indents sys_ptrace
(only whitespace changes).

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/ptrace.c |  337 ++++++++++++++++++++++------------------------
 1 files changed, 168 insertions(+), 169 deletions(-)

Index: linux-2.6/arch/m68k/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/ptrace.c	2005-08-30 16:15:02.616672533 +0200
+++ linux-2.6/arch/m68k/kernel/ptrace.c	2005-08-30 16:19:46.290131062 +0200
@@ -95,7 +95,7 @@ static inline int put_reg(struct task_st
 	if (regno == PT_USP)
 		addr = &task->thread.usp;
 	else if (regno < sizeof(regoff)/sizeof(regoff[0]))
-		addr = (unsigned long *) (task->thread.esp0 + regoff[regno]);
+		addr = (unsigned long *)(task->thread.esp0 + regoff[regno]);
 	else
 		return -1;
 	*addr = data;
@@ -157,216 +157,215 @@ asmlinkage int sys_ptrace(long request, 
 
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
-		case PTRACE_PEEKTEXT: /* read word at location addr. */
-		case PTRACE_PEEKDATA: {
-			unsigned long tmp;
-			int copied;
-
-			copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
-			ret = -EIO;
-			if (copied != sizeof(tmp))
-				break;
-			ret = put_user(tmp,(unsigned long *) data);
+	case PTRACE_PEEKTEXT:	/* read word at location addr. */
+	case PTRACE_PEEKDATA: {
+		unsigned long tmp;
+		int copied;
+
+		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+		ret = -EIO;
+		if (copied != sizeof(tmp))
 			break;
-		}
+		ret = put_user(tmp, (unsigned long *)data);
+		break;
+	}
 
 	/* read the word at location addr in the USER area. */
-		case PTRACE_PEEKUSR: {
-			unsigned long tmp;
+	case PTRACE_PEEKUSR: {
+		unsigned long tmp;
 
-			ret = -EIO;
-			if ((addr & 3) || addr < 0 ||
-			    addr > sizeof(struct user) - 3)
-				break;
+		ret = -EIO;
+		if ((addr & 3) || addr < 0 ||
+		    addr > sizeof(struct user) - 3)
+			break;
 
-			tmp = 0;  /* Default return condition */
-			addr = addr >> 2; /* temporary hack. */
-			ret = -EIO;
-			if (addr < 19) {
-				tmp = get_reg(child, addr);
-				if (addr == PT_SR)
-					tmp >>= 16;
-			} else if (addr >= 21 && addr < 49) {
-				tmp = child->thread.fp[addr - 21];
+		tmp = 0;  /* Default return condition */
+		addr = addr >> 2; /* temporary hack. */
+		ret = -EIO;
+		if (addr < 19) {
+			tmp = get_reg(child, addr);
+			if (addr == PT_SR)
+				tmp >>= 16;
+		} else if (addr >= 21 && addr < 49) {
+			tmp = child->thread.fp[addr - 21];
 #ifdef CONFIG_M68KFPU_EMU
-				/* Convert internal fpu reg representation
-				 * into long double format
-				 */
-				if (FPU_IS_EMU && (addr < 45) && !(addr % 3))
-					tmp = ((tmp & 0xffff0000) << 15) |
-					      ((tmp & 0x0000ffff) << 16);
+			/* Convert internal fpu reg representation
+			 * into long double format
+			 */
+			if (FPU_IS_EMU && (addr < 45) && !(addr % 3))
+				tmp = ((tmp & 0xffff0000) << 15) |
+				      ((tmp & 0x0000ffff) << 16);
 #endif
-			} else
-				break;
-			ret = put_user(tmp,(unsigned long *) data);
+		} else
 			break;
-		}
+		ret = put_user(tmp, (unsigned long *)data);
+		break;
+	}
 
-      /* when I and D space are separate, this will have to be fixed. */
-		case PTRACE_POKETEXT: /* write the word at location addr. */
-		case PTRACE_POKEDATA:
-			ret = 0;
-			if (access_process_vm(child, addr, &data, sizeof(data), 1) == sizeof(data))
-				break;
-			ret = -EIO;
+	/* when I and D space are separate, this will have to be fixed. */
+	case PTRACE_POKETEXT:	/* write the word at location addr. */
+	case PTRACE_POKEDATA:
+		ret = 0;
+		if (access_process_vm(child, addr, &data, sizeof(data), 1) == sizeof(data))
 			break;
+		ret = -EIO;
+		break;
 
-		case PTRACE_POKEUSR: /* write the word at location addr in the USER area */
-			ret = -EIO;
-			if ((addr & 3) || addr < 0 ||
-			    addr > sizeof(struct user) - 3)
-				break;
-
-			addr = addr >> 2; /* temporary hack. */
-
-			if (addr == PT_SR) {
-				data &= SR_MASK;
-				data <<= 16;
-				data |= get_reg(child, PT_SR) & ~(SR_MASK << 16);
-			}
-			if (addr < 19) {
-				if (put_reg(child, addr, data))
-					break;
-				ret = 0;
-				break;
-			}
-			if (addr >= 21 && addr < 48)
-			{
-#ifdef CONFIG_M68KFPU_EMU
-				/* Convert long double format
-				 * into internal fpu reg representation
-				 */
-				if (FPU_IS_EMU && (addr < 45) && !(addr % 3)) {
-					data = (unsigned long)data << 15;
-					data = (data & 0xffff0000) |
-					       ((data & 0x0000ffff) >> 1);
-				}
-#endif
-				child->thread.fp[addr - 21] = data;
-				ret = 0;
-			}
+	case PTRACE_POKEUSR:	/* write the word at location addr in the USER area */
+		ret = -EIO;
+		if ((addr & 3) || addr < 0 ||
+		    addr > sizeof(struct user) - 3)
 			break;
 
-		case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
-		case PTRACE_CONT: { /* restart after signal. */
-			long tmp;
+		addr = addr >> 2; /* temporary hack. */
 
-			ret = -EIO;
-			if (!valid_signal(data))
+		if (addr == PT_SR) {
+			data &= SR_MASK;
+			data <<= 16;
+			data |= get_reg(child, PT_SR) & ~(SR_MASK << 16);
+		}
+		if (addr < 19) {
+			if (put_reg(child, addr, data))
 				break;
-			if (request == PTRACE_SYSCALL) {
-					child->thread.work.syscall_trace = ~0;
-			} else {
-					child->thread.work.syscall_trace = 0;
-			}
-			child->exit_code = data;
-			/* make sure the single step bit is not set. */
-			tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
-			put_reg(child, PT_SR, tmp);
-			child->thread.work.delayed_trace = 0;
-			wake_up_process(child);
 			ret = 0;
 			break;
 		}
-
-/*
- * make the child exit.  Best I can do is send it a sigkill.
- * perhaps it should be put in the status that it wants to
- * exit.
- */
-		case PTRACE_KILL: {
-			long tmp;
-
+		if (addr >= 21 && addr < 48) {
+#ifdef CONFIG_M68KFPU_EMU
+			/* Convert long double format
+			 * into internal fpu reg representation
+			 */
+			if (FPU_IS_EMU && (addr < 45) && !(addr % 3)) {
+				data = (unsigned long)data << 15;
+				data = (data & 0xffff0000) |
+				       ((data & 0x0000ffff) >> 1);
+			}
+#endif
+			child->thread.fp[addr - 21] = data;
 			ret = 0;
-			if (child->exit_state == EXIT_ZOMBIE) /* already dead */
-				break;
-			child->exit_code = SIGKILL;
-	/* make sure the single step bit is not set. */
-			tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
-			put_reg(child, PT_SR, tmp);
-			child->thread.work.delayed_trace = 0;
-			wake_up_process(child);
-			break;
 		}
+		break;
 
-		case PTRACE_SINGLESTEP: {  /* set the trap flag. */
-			long tmp;
-
-			ret = -EIO;
-			if (!valid_signal(data))
-				break;
+	case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */
+	case PTRACE_CONT: {	/* restart after signal. */
+		long tmp;
+
+		ret = -EIO;
+		if (!valid_signal(data))
+			break;
+		if (request == PTRACE_SYSCALL) {
+			child->thread.work.syscall_trace = ~0;
+		} else {
 			child->thread.work.syscall_trace = 0;
-			tmp = get_reg(child, PT_SR) | (TRACE_BITS << 16);
-			put_reg(child, PT_SR, tmp);
-			child->thread.work.delayed_trace = 1;
-
-			child->exit_code = data;
-	/* give it a chance to run. */
-			wake_up_process(child);
-			ret = 0;
-			break;
 		}
+		child->exit_code = data;
+		/* make sure the single step bit is not set. */
+		tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
+		put_reg(child, PT_SR, tmp);
+		child->thread.work.delayed_trace = 0;
+		wake_up_process(child);
+		ret = 0;
+		break;
+	}
+
+	/*
+	 * make the child exit.  Best I can do is send it a sigkill.
+	 * perhaps it should be put in the status that it wants to
+	 * exit.
+	 */
+	case PTRACE_KILL: {
+		long tmp;
+
+		ret = 0;
+		if (child->exit_state == EXIT_ZOMBIE) /* already dead */
+			break;
+		child->exit_code = SIGKILL;
+		/* make sure the single step bit is not set. */
+		tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
+		put_reg(child, PT_SR, tmp);
+		child->thread.work.delayed_trace = 0;
+		wake_up_process(child);
+		break;
+	}
+
+	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
+		long tmp;
 
-		case PTRACE_DETACH:	/* detach a process that was attached. */
-			ret = ptrace_detach(child, data);
+		ret = -EIO;
+		if (!valid_signal(data))
 			break;
+		child->thread.work.syscall_trace = 0;
+		tmp = get_reg(child, PT_SR) | (TRACE_BITS << 16);
+		put_reg(child, PT_SR, tmp);
+		child->thread.work.delayed_trace = 1;
+
+		child->exit_code = data;
+		/* give it a chance to run. */
+		wake_up_process(child);
+		ret = 0;
+		break;
+	}
 
-		case PTRACE_GETREGS: { /* Get all gp regs from the child. */
-			int i;
-			unsigned long tmp;
-			for (i = 0; i < 19; i++) {
-			    tmp = get_reg(child, i);
-			    if (i == PT_SR)
+	case PTRACE_DETACH:	/* detach a process that was attached. */
+		ret = ptrace_detach(child, data);
+		break;
+
+	case PTRACE_GETREGS: { /* Get all gp regs from the child. */
+		int i;
+		unsigned long tmp;
+		for (i = 0; i < 19; i++) {
+			tmp = get_reg(child, i);
+			if (i == PT_SR)
 				tmp >>= 16;
-			    if (put_user(tmp, (unsigned long *) data)) {
+			if (put_user(tmp, (unsigned long *)data)) {
 				ret = -EFAULT;
 				break;
-			    }
-			    data += sizeof(long);
 			}
-			ret = 0;
-			break;
+			data += sizeof(long);
 		}
+		ret = 0;
+		break;
+	}
 
-		case PTRACE_SETREGS: { /* Set all gp regs in the child. */
-			int i;
-			unsigned long tmp;
-			for (i = 0; i < 19; i++) {
-			    if (get_user(tmp, (unsigned long *) data)) {
+	case PTRACE_SETREGS: { /* Set all gp regs in the child. */
+		int i;
+		unsigned long tmp;
+		for (i = 0; i < 19; i++) {
+			if (get_user(tmp, (unsigned long *)data)) {
 				ret = -EFAULT;
 				break;
-			    }
-			    if (i == PT_SR) {
+			}
+			if (i == PT_SR) {
 				tmp &= SR_MASK;
 				tmp <<= 16;
 				tmp |= get_reg(child, PT_SR) & ~(SR_MASK << 16);
-			    }
-			    put_reg(child, i, tmp);
-			    data += sizeof(long);
 			}
-			ret = 0;
-			break;
+			put_reg(child, i, tmp);
+			data += sizeof(long);
 		}
+		ret = 0;
+		break;
+	}
 
-		case PTRACE_GETFPREGS: { /* Get the child FPU state. */
-			ret = 0;
-			if (copy_to_user((void *)data, &child->thread.fp,
-					 sizeof(struct user_m68kfp_struct)))
-				ret = -EFAULT;
-			break;
-		}
+	case PTRACE_GETFPREGS: { /* Get the child FPU state. */
+		ret = 0;
+		if (copy_to_user((void *)data, &child->thread.fp,
+				 sizeof(struct user_m68kfp_struct)))
+			ret = -EFAULT;
+		break;
+	}
 
-		case PTRACE_SETFPREGS: { /* Set the child FPU state. */
-			ret = 0;
-			if (copy_from_user(&child->thread.fp, (void *)data,
-					   sizeof(struct user_m68kfp_struct)))
-				ret = -EFAULT;
-			break;
-		}
+	case PTRACE_SETFPREGS: { /* Set the child FPU state. */
+		ret = 0;
+		if (copy_from_user(&child->thread.fp, (void *)data,
+				   sizeof(struct user_m68kfp_struct)))
+			ret = -EFAULT;
+		break;
+	}
 
-		default:
-			ret = ptrace_request(child, request, addr, data);
-			break;
+	default:
+		ret = ptrace_request(child, request, addr, data);
+		break;
 	}
 out_tsk:
 	put_task_struct(child);
