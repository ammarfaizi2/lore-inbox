Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSHOUJT>; Thu, 15 Aug 2002 16:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSHOUJT>; Thu, 15 Aug 2002 16:09:19 -0400
Received: from crack.them.org ([65.125.64.184]:34318 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S317398AbSHOUJG>;
	Thu, 15 Aug 2002 16:09:06 -0400
Date: Thu, 15 Aug 2002 16:13:14 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: PATCH (BK): Substantial ptrace improvements
Message-ID: <20020815201314.GA11380@nevyn.them.org>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This patch can also be pulled from:
  bk://nevyn.them.org:5000
 It's against linux-2.5, just merged.
]

This patch covers a couple of issues in the ptrace syscall.
 - It fixes a bug introduced when the syscall tracing flag moved
   out of current-> and into thread_info; it must be cleared when
   creating a new task.  This fixes a mysterious hang when stracing
   gdb.

 - It implements PTRACE_O_TRACESYSGOOD on all architectures
 - It renumbers PTRACE_SETOPTIONS to have the same number on all
architectures, and establishes an architecture-independent range
to use for future options.  The old value of PTRACE_SETOPTIONS is
still recognized.
 - It adds simplified framework for adding architecture-independent
ptrace calls.
 - It adds tracing of fork, vfork, clone, and exec events.
 - It adds a CLONE_UNTRACED flag to prevent kernel threads from being
traced by the above mechanism, and adds the flag in every architecture's
kernel_thread routine.
 - It uses the new mechanism to implement a PTRACE_GETEVENTMSG, which
can be used to find the PID of a child after a fork/vfork/clone event is
reported.

I've got strace using the new interfaces - no new functionality, but better
reliability and less grossness.  I've got GDB using the new interfaces also,
which permits much better debugging of fork/vfork/exec.  It'll be a few days
before I post the GDB patches, since they need a lot of cleanup yet.  A lot
of people have asked me about the functionality this patch adds recently, so
I finally took it off my TODO list and did it.

Linus, please apply - or comment, of course.  Thanks.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.549   -> 1.550  
#	arch/i386/kernel/process.c	1.32.1.4 -> 1.35   
#	arch/alpha/kernel/entry.S	1.14.1.1 -> 1.16   
#	arch/x86_64/kernel/process.c	1.7     -> 1.8    
#	include/asm-arm/ptrace.h	1.2     -> 1.3    
#	include/asm-mips/ptrace.h	1.2     -> 1.3    
#	  include/linux/mm.h	1.66.1.3 -> 1.71   
#	arch/cris/kernel/entryoffsets.c	1.3     -> 1.4    
#	include/asm-i386/ptrace.h	1.2     -> 1.3    
#	include/linux/sched.h	1.76.1.4 -> 1.81   
#	       kernel/fork.c	1.58.1.3 -> 1.62   
#	arch/s390x/kernel/ptrace.c	1.7     -> 1.9    
#	include/linux/ptrace.h	1.1     -> 1.6    
#	arch/arm/kernel/ptrace.c	1.12    -> 1.14   
#	arch/sh/kernel/ptrace.c	1.7     -> 1.9    
#	arch/parisc/kernel/ptrace.c	1.4     -> 1.6    
#	arch/sparc/kernel/process.c	1.15    -> 1.16   
#	include/asm-s390/ptrace.h	1.5     -> 1.6    
#	arch/s390x/kernel/process.c	1.10    -> 1.11   
#	    fs/binfmt_aout.c	1.12    -> 1.13   
#	include/asm-s390x/ptrace.h	1.3     -> 1.4    
#	arch/parisc/kernel/entry.S	1.3     -> 1.4    
#	arch/mips64/kernel/ptrace.c	1.6     -> 1.8    
#	arch/ppc/kernel/ptrace.c	1.9     -> 1.11   
#	arch/mips64/kernel/process.c	1.4     -> 1.5    
#	arch/i386/kernel/ptrace.c	1.13    -> 1.15   
#	arch/m68k/kernel/ptrace.c	1.7     -> 1.9    
#	arch/ppc64/kernel/ptrace.c	1.2     -> 1.4    
#	arch/x86_64/ia32/ptrace32.c	1.2     -> 1.4    
#	include/asm-x86_64/ptrace.h	1.3     -> 1.4    
#	arch/x86_64/kernel/ptrace.c	1.3     -> 1.5    
#	arch/cris/kernel/ptrace.c	1.8     -> 1.10   
#	arch/ppc64/kernel/misc.S	1.9     -> 1.10   
#	arch/s390/kernel/ptrace.c	1.8     -> 1.10   
#	arch/arm/kernel/process.c	1.18    -> 1.19   
#	arch/ppc/kernel/misc.S	1.24    -> 1.25   
#	arch/mips/kernel/process.c	1.7     -> 1.8    
#	arch/cris/kernel/entry.S	1.12    -> 1.13   
#	arch/sparc64/kernel/process.c	1.32    -> 1.33   
#	     fs/binfmt_elf.c	1.26    -> 1.27   
#	arch/sparc/kernel/ptrace.c	1.10    -> 1.12   
#	arch/ia64/kernel/process.c	1.14    -> 1.15   
#	arch/mips/kernel/ptrace.c	1.8     -> 1.10   
#	arch/m68k/kernel/process.c	1.10    -> 1.11   
#	arch/ppc64/kernel/ptrace32.c	1.3     -> 1.5    
#	arch/ia64/ia32/sys_ia32.c	1.17    -> 1.19   
#	include/asm-ia64/ptrace.h	1.4     -> 1.5    
#	arch/sh/kernel/process.c	1.12    -> 1.13   
#	arch/s390/kernel/process.c	1.12    -> 1.13   
#	include/asm-sh/ptrace.h	1.2     -> 1.3    
#	arch/alpha/kernel/ptrace.c	1.9     -> 1.11   
#	include/asm-mips64/ptrace.h	1.1     -> 1.2    
#	arch/sparc64/kernel/ptrace.c	1.14    -> 1.16   
#	arch/ia64/kernel/ptrace.c	1.11    -> 1.13   
#	     kernel/ptrace.c	1.15    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/15	drow@nevyn.them.org	1.550
# Merge nevyn.them.org:/nevyn/big/kernel/linux-2.5
# into nevyn.them.org:/nevyn/big/kernel/linux-2.5-trace
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
--- a/arch/alpha/kernel/entry.S	Thu Aug 15 16:01:57 2002
+++ b/arch/alpha/kernel/entry.S	Thu Aug 15 16:01:57 2002
@@ -213,7 +213,7 @@
 	stq	$2, 152($30)		/* HAE */
 
 	/* Shuffle FLAGS to the front; add CLONE_VM.  */
-	ldi	$1, CLONE_VM
+	ldi	$1, CLONE_VM|CLONE_UNTRACED
 	or	$18, $1, $16
 	bsr	$26, sys_clone
 
diff -Nru a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
--- a/arch/alpha/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/alpha/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -383,7 +383,7 @@
 		goto out;
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		goto out;
 	}
  out:
@@ -400,7 +400,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
--- a/arch/arm/kernel/process.c	Thu Aug 15 16:01:58 2002
+++ b/arch/arm/kernel/process.c	Thu Aug 15 16:01:58 2002
@@ -396,7 +396,7 @@
 	b	sys_exit					\n\
 1:	"
         : "=r" (__ret)
-        : "Ir" (flags), "I" (CLONE_VM), "r" (fn), "r" (arg)
+        : "Ir" (flags), "I" (CLONE_VM | CLONE_UNTRACED), "r" (fn), "r" (arg)
 	: "r0", "r1", "lr");
 	return __ret;
 }
diff -Nru a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
--- a/arch/arm/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
+++ b/arch/arm/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
@@ -629,16 +629,12 @@
 			ret = ptrace_setfpregs(child, (void *)data);
 			break;
 
-		case PTRACE_SETOPTIONS:
-			if (data & PTRACE_O_TRACESYSGOOD)
-				child->ptrace |= PT_TRACESYSGOOD;
-			else
-				child->ptrace &= ~PT_TRACESYSGOOD;
-			ret = 0;
+		case PTRACE_OLDSETOPTIONS:
+			ret = ptrace_setoptions(child, data);
 			break;
 
 		default:
-			ret = -EIO;
+			ret = ptrace_request(child, request, addr, data);
 			break;
 	}
 
diff -Nru a/arch/cris/kernel/entry.S b/arch/cris/kernel/entry.S
--- a/arch/cris/kernel/entry.S	Thu Aug 15 16:01:58 2002
+++ b/arch/cris/kernel/entry.S	Thu Aug 15 16:01:58 2002
@@ -748,6 +748,7 @@
 	/* r11 is argument 2 to clone, the flags */
 	move.d  $r12, $r11
 	or.w	LCLONE_VM, $r11
+	or.w	LCLONE_UNTRACED, $r11
 
 	/* Save FN for later.  */
 	move.d	$r10, $r12
diff -Nru a/arch/cris/kernel/entryoffsets.c b/arch/cris/kernel/entryoffsets.c
--- a/arch/cris/kernel/entryoffsets.c	Thu Aug 15 16:01:57 2002
+++ b/arch/cris/kernel/entryoffsets.c	Thu Aug 15 16:01:57 2002
@@ -57,5 +57,6 @@
 
 /* linux/sched.h values - doesn't have an #ifdef __ASSEMBLY__ for these.  */
 VAL (LCLONE_VM, CLONE_VM)
+VAL (LCLONE_UNTRACED, CLONE_UNTRACED)
 
 __asm__ (".endif");
diff -Nru a/arch/cris/kernel/ptrace.c b/arch/cris/kernel/ptrace.c
--- a/arch/cris/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/cris/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -292,7 +292,7 @@
 		}
 
 		default:
-			ret = -EIO;
+			ret = ptrace_request(child, request, addr, data);
 			break;
 	}
 out_tsk:
@@ -307,10 +307,8 @@
 	if ((current->ptrace & (PT_PTRACED | PT_TRACESYS)) !=
 	    (PT_PTRACED | PT_TRACESYS))
 		return;
-	/* TODO: make a way to distinguish between a syscall stop and SIGTRAP
-	 * delivery like in the i386 port ? 
-	 */
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Thu Aug 15 16:01:57 2002
+++ b/arch/i386/kernel/process.c	Thu Aug 15 16:01:57 2002
@@ -505,7 +505,7 @@
 	regs.eflags = 0x286;
 
 	/* Ok, create the new process.. */
-	p = do_fork(flags | CLONE_VM, 0, &regs, 0);
+	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
diff -Nru a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
--- a/arch/i386/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/i386/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -425,17 +425,12 @@
 		break;
 	}
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
+	case PTRACE_OLDSETOPTIONS:
+		ret = ptrace_setoptions(child, data);
 		break;
-	}
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
diff -Nru a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
--- a/arch/ia64/ia32/sys_ia32.c	Thu Aug 15 16:01:58 2002
+++ b/arch/ia64/ia32/sys_ia32.c	Thu Aug 15 16:01:58 2002
@@ -3079,11 +3079,12 @@
 	      case PTRACE_KILL:
 	      case PTRACE_SINGLESTEP:	/* execute chile for one instruction */
 	      case PTRACE_DETACH:	/* detach a process */
+	      case PTRACE_OLDSETOPTIONS:
 		ret = sys_ptrace(request, pid, addr, data, arg4, arg5, arg6, arg7, stack);
 		break;
 
 	      default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 
 	}
diff -Nru a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
--- a/arch/ia64/kernel/process.c	Thu Aug 15 16:01:58 2002
+++ b/arch/ia64/kernel/process.c	Thu Aug 15 16:01:58 2002
@@ -509,7 +509,7 @@
 	struct task_struct *parent = current;
 	int result, tid;
 
-	tid = clone(flags | CLONE_VM, 0);
+	tid = clone(flags | CLONE_VM | CLONE_UNTRACED, 0);
 	if (parent != current) {
 		result = (*fn)(arg);
 		_exit(result);
diff -Nru a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
--- a/arch/ia64/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/ia64/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -1268,16 +1268,12 @@
 		ret = ptrace_setregs(child, (struct pt_all_user_regs*) data);
 		goto out_tsk;
 
-	      case PTRACE_SETOPTIONS:
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
+	      case PTRACE_OLDSETOPTIONS:
+		ret = ptrace_setoptions(child, data);
 		break;
 
 	      default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		goto out_tsk;
 	}
   out_tsk:
diff -Nru a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
--- a/arch/m68k/kernel/process.c	Thu Aug 15 16:01:58 2002
+++ b/arch/m68k/kernel/process.c	Thu Aug 15 16:01:58 2002
@@ -152,7 +152,7 @@
 
 	{
 	register long retval __asm__ ("d0");
-	register long clone_arg __asm__ ("d1") = flags | CLONE_VM;
+	register long clone_arg __asm__ ("d1") = flags | CLONE_VM | CLONE_UNTRACED;
 
 	retval = __NR_clone;
 	__asm__ __volatile__
diff -Nru a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
--- a/arch/m68k/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/m68k/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -355,7 +355,7 @@
 		}
 
 		default:
-			ret = -EIO;
+			ret = ptrace_request(child, request, addr, data);
 			break;
 	}
 out_tsk:
@@ -370,7 +370,8 @@
 	if (!current->thread.work.delayed_trace &&
 	    !current->thread.work.syscall_trace)
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
--- a/arch/mips/kernel/process.c	Thu Aug 15 16:01:58 2002
+++ b/arch/mips/kernel/process.c	Thu Aug 15 16:01:58 2002
@@ -176,7 +176,7 @@
 		:"=r" (retval)
 		:"i" (__NR_clone), "i" (__NR_exit),
 		 "r" (arg), "r" (fn),
-		 "r" (flags | CLONE_VM)
+		 "r" (flags | CLONE_VM | CLONE_UNTRACED)
 		 /*
 		  * The called subroutine might have destroyed any of the
 		  * at, result, argument or temporary registers ...
diff -Nru a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
--- a/arch/mips/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/mips/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -304,16 +304,12 @@
 		res = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_SETOPTIONS:
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		res = 0;
+	case PTRACE_OLDSETOPTIONS:
+		res = ptrace_setoptions(child, data);
 		break;
 
 	default:
-		res = -EIO;
+		res = ptrace_request(child, request, addr, data);
 		goto out;
 	}
 out_tsk:
diff -Nru a/arch/mips64/kernel/process.c b/arch/mips64/kernel/process.c
--- a/arch/mips64/kernel/process.c	Thu Aug 15 16:01:58 2002
+++ b/arch/mips64/kernel/process.c	Thu Aug 15 16:01:58 2002
@@ -167,7 +167,7 @@
 		"1:\tmove\t%0, $2"
 		:"=r" (retval)
 		:"i" (__NR_clone), "i" (__NR_exit), "r" (arg), "r" (fn),
-		 "r" (flags | CLONE_VM)
+		 "r" (flags | CLONE_VM | CLONE_UNTRACED)
 
 		 /* The called subroutine might have destroyed any of the
 		  * at, result, argument or temporary registers ...  */
diff -Nru a/arch/mips64/kernel/ptrace.c b/arch/mips64/kernel/ptrace.c
--- a/arch/mips64/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
+++ b/arch/mips64/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
@@ -275,17 +275,12 @@
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
+	case PTRACE_OLDSETOPTIONS:
+		ret = ptrace_setoptions(child, data);
 		break;
-	}
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 
@@ -535,14 +530,10 @@
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
+	case PTRACE_OLDSETOPTIONS:
+	case PTRACE_SETOPTIONS:
+		ret = ptrace_setoptions(child, data);
 		break;
-	}
 
 	default:
 		ret = -EIO;
diff -Nru a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
--- a/arch/parisc/kernel/entry.S	Thu Aug 15 16:01:57 2002
+++ b/arch/parisc/kernel/entry.S	Thu Aug 15 16:01:57 2002
@@ -497,7 +497,8 @@
 #endif
 	STREG	%r26, PT_GR26(%r1)  /* Store function & argument for child */
 	STREG	%r25, PT_GR25(%r1)
-	ldo	CLONE_VM(%r0), %r26   /* Force CLONE_VM since only init_mm */
+	ldil	L%CLONE_UNTRACED
+	ldo	CLONE_VM(%r26), %r26   /* Force CLONE_VM since only init_mm */
 	or	%r26, %r24, %r26      /* will have kernel mappings.	 */
 	copy	%r0, %r25
 	bl	do_fork_FIXME_NOW_RETURNS_TASK_STRUCT, %r2
diff -Nru a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
--- a/arch/parisc/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
+++ b/arch/parisc/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
@@ -244,7 +244,7 @@
 		goto out_tsk;
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		goto out_tsk;
 	}
 
@@ -269,7 +269,8 @@
 	if ((current->ptrace & (PT_PTRACED|PT_TRACESYS)) !=
 			(PT_PTRACED|PT_TRACESYS))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S	Thu Aug 15 16:01:58 2002
+++ b/arch/ppc/kernel/misc.S	Thu Aug 15 16:01:58 2002
@@ -1023,6 +1023,7 @@
 	mr	r30,r3		/* function */
 	mr	r31,r4		/* argument */
 	ori	r3,r5,CLONE_VM	/* flags */
+	oris	r3,r3,CLONE_UNTRACED>>16
 	li	r0,__NR_clone
 	sc
 	cmpi	0,r3,0		/* parent or child? */
diff -Nru a/arch/ppc/kernel/ptrace.c b/arch/ppc/kernel/ptrace.c
--- a/arch/ppc/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/ppc/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -342,7 +342,7 @@
 #endif
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
@@ -357,7 +357,8 @@
         if (!test_thread_flag(TIF_SYSCALL_TRACE)
 	    || !(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/ppc64/kernel/misc.S b/arch/ppc64/kernel/misc.S
--- a/arch/ppc64/kernel/misc.S	Thu Aug 15 16:01:58 2002
+++ b/arch/ppc64/kernel/misc.S	Thu Aug 15 16:01:58 2002
@@ -485,6 +485,7 @@
 	/* XXX fix this when we optimise syscall entry to not save volatiles */
 	mr	r6,r3		/* function */
 	ori	r3,r5,CLONE_VM	/* flags */
+	oris	r3,r3,(CLONE_UNTRACED>>16)
 	li	r0,__NR_clone
 	sc
 	cmpi	0,r3,0		/* parent or child? */
diff -Nru a/arch/ppc64/kernel/ptrace.c b/arch/ppc64/kernel/ptrace.c
--- a/arch/ppc64/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/ppc64/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -254,7 +254,7 @@
 	}
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
@@ -270,7 +270,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/ppc64/kernel/ptrace32.c b/arch/ppc64/kernel/ptrace32.c
--- a/arch/ppc64/kernel/ptrace32.c	Thu Aug 15 16:01:58 2002
+++ b/arch/ppc64/kernel/ptrace32.c	Thu Aug 15 16:01:58 2002
@@ -344,7 +344,7 @@
 		break;
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
diff -Nru a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
--- a/arch/s390/kernel/process.c	Thu Aug 15 16:01:58 2002
+++ b/arch/s390/kernel/process.c	Thu Aug 15 16:01:58 2002
@@ -123,7 +123,7 @@
 
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-        int clone_arg = flags | CLONE_VM;
+        int clone_arg = flags | CLONE_VM | CLONE_UNTRACED;
         int retval;
 
         __asm__ __volatile__(
diff -Nru a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
--- a/arch/s390/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/s390/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -346,16 +346,11 @@
 		   ret=copy_user(child,parea.kernel_addr,parea.process_addr,
 				 parea.len,1,(request==PTRACE_POKEUSR_AREA));
 		break;
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
+	case PTRACE_OLDSETOPTIONS:
+		ret = ptrace_setoptions(child, data);
 		break;
-	}
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
  out_tsk:
diff -Nru a/arch/s390x/kernel/process.c b/arch/s390x/kernel/process.c
--- a/arch/s390x/kernel/process.c	Thu Aug 15 16:01:57 2002
+++ b/arch/s390x/kernel/process.c	Thu Aug 15 16:01:57 2002
@@ -120,7 +120,7 @@
 
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-        int clone_arg = flags | CLONE_VM;
+        int clone_arg = flags | CLONE_VM | CLONE_UNTRACED;
         int retval;
 
         __asm__ __volatile__(
diff -Nru a/arch/s390x/kernel/ptrace.c b/arch/s390x/kernel/ptrace.c
--- a/arch/s390x/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
+++ b/arch/s390x/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
@@ -576,16 +576,11 @@
 					      parea.len,1,(request==PTRACE_POKEUSR_AREA));
 		}
 		break;
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
+	case PTRACE_OLDSETOPTIONS:
+		ret = ptrace_setoptions(child, data);
 		break;
-	}
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
  out_tsk:
diff -Nru a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
--- a/arch/sh/kernel/process.c	Thu Aug 15 16:01:58 2002
+++ b/arch/sh/kernel/process.c	Thu Aug 15 16:01:58 2002
@@ -120,7 +120,7 @@
 {	/* Don't use this in BL=1(cli).  Or else, CPU resets! */
 	register unsigned long __sc0 __asm__ ("r0");
 	register unsigned long __sc3 __asm__ ("r3") = __NR_clone;
-	register unsigned long __sc4 __asm__ ("r4") = (long) flags | CLONE_VM;
+	register unsigned long __sc4 __asm__ ("r4") = (long) flags | CLONE_VM | CLONE_UNTRACED;
 	register unsigned long __sc5 __asm__ ("r5") = 0;
 	register unsigned long __sc8 __asm__ ("r8") = (long) arg;
 	register unsigned long __sc9 __asm__ ("r9") = (long) fn;
diff -Nru a/arch/sh/kernel/ptrace.c b/arch/sh/kernel/ptrace.c
--- a/arch/sh/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
+++ b/arch/sh/kernel/ptrace.c	Thu Aug 15 16:01:57 2002
@@ -356,17 +356,12 @@
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
+	case PTRACE_OLDSETOPTIONS:
+		ret = ptrace_setoptions(child, data);
 		break;
-	}
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
diff -Nru a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
--- a/arch/sparc/kernel/process.c	Thu Aug 15 16:01:57 2002
+++ b/arch/sparc/kernel/process.c	Thu Aug 15 16:01:57 2002
@@ -713,7 +713,7 @@
 			   /* Notreached by child. */
 			   "1: mov %%o0, %0\n\t" :
 			   "=r" (retval) :
-			   "i" (__NR_clone), "r" (flags | CLONE_VM),
+			   "i" (__NR_clone), "r" (flags | CLONE_VM | CLONE_UNTRACED),
 			   "i" (__NR_exit),  "r" (fn), "r" (arg) :
 			   "g1", "g2", "g3", "o0", "o1", "memory", "cc");
 	return retval;
diff -Nru a/arch/sparc/kernel/ptrace.c b/arch/sparc/kernel/ptrace.c
--- a/arch/sparc/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/sparc/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -575,10 +575,15 @@
 
 	/* PTRACE_DUMPCORE unsupported... */
 
-	default:
-		pt_error_return(regs, EIO);
+	default: {
+		int err = ptrace_request(child, request, addr, data);
+		if (err)
+			pt_error_return(regs, -err);
+		else
+			pt_succ_return(regs, 0);
 		goto out_tsk;
 	}
+	}
 out_tsk:
 	if (child)
 		put_task_struct(child);
@@ -595,7 +600,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	current->thread.flags ^= MAGIC_CONSTANT;
 	notify_parent(current, SIGCHLD);
diff -Nru a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
--- a/arch/sparc64/kernel/process.c	Thu Aug 15 16:01:58 2002
+++ b/arch/sparc64/kernel/process.c	Thu Aug 15 16:01:58 2002
@@ -682,7 +682,7 @@
 			   /* Notreached by child. */
 			   "1:" :
 			   "=r" (retval) :
-			   "i" (__NR_clone), "r" (flags | CLONE_VM),
+			   "i" (__NR_clone), "r" (flags | CLONE_VM | CLONE_UNTRACED),
 			   "i" (__NR_exit),  "r" (fn), "r" (arg) :
 			   "g1", "g2", "g3", "o0", "o1", "memory", "cc");
 	return retval;
diff -Nru a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
--- a/arch/sparc64/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/sparc64/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -562,10 +562,15 @@
 
 	/* PTRACE_DUMPCORE unsupported... */
 
-	default:
-		pt_error_return(regs, EIO);
+	default: {
+		int err = ptrace_request(child, request, addr, data);
+		if (err)
+			pt_error_return(regs, -err);
+		else
+			pt_succ_return(regs, 0);
 		goto out_tsk;
 	}
+	}
 flush_and_out:
 	{
 		unsigned long va;
@@ -603,7 +608,8 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
+	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -Nru a/arch/x86_64/ia32/ptrace32.c b/arch/x86_64/ia32/ptrace32.c
--- a/arch/x86_64/ia32/ptrace32.c	Thu Aug 15 16:01:58 2002
+++ b/arch/x86_64/ia32/ptrace32.c	Thu Aug 15 16:01:58 2002
@@ -172,17 +172,6 @@
 	__u32 val;
 
 	switch (request) { 
-	case PTRACE_TRACEME:
-	case PTRACE_ATTACH:
-	case PTRACE_SYSCALL:
-	case PTRACE_CONT:
-	case PTRACE_KILL:
-	case PTRACE_SINGLESTEP:
-	case PTRACE_DETACH:
-	case PTRACE_SETOPTIONS:
-		ret = sys_ptrace(request, pid, addr, data); 
-		return ret;
-
 	case PTRACE_PEEKTEXT:
 	case PTRACE_PEEKDATA:
 	case PTRACE_POKEDATA:
@@ -198,7 +187,8 @@
 		break;
 		
 	default:
-		return -EIO;
+		ret = sys_ptrace(request, pid, addr, data); 
+		return ret;
 	} 
 
 	child = find_target(request, pid, &ret);
diff -Nru a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
--- a/arch/x86_64/kernel/process.c	Thu Aug 15 16:01:57 2002
+++ b/arch/x86_64/kernel/process.c	Thu Aug 15 16:01:57 2002
@@ -58,7 +58,7 @@
 
 asmlinkage extern void ret_from_fork(void);
 
-unsigned long kernel_thread_flags = CLONE_VM;
+unsigned long kernel_thread_flags = CLONE_VM | CLONE_UNTRACED;
 
 int hlt_counter;
 
diff -Nru a/arch/x86_64/kernel/ptrace.c b/arch/x86_64/kernel/ptrace.c
--- a/arch/x86_64/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/arch/x86_64/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -396,17 +396,12 @@
 		break;
 	}
 
-	case PTRACE_SETOPTIONS: {
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
+	case PTRACE_OLDSETOPTIONS:
+		ret = ptrace_setoptions(child, data);
 		break;
-	}
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
diff -Nru a/fs/binfmt_aout.c b/fs/binfmt_aout.c
--- a/fs/binfmt_aout.c	Thu Aug 15 16:01:57 2002
+++ b/fs/binfmt_aout.c	Thu Aug 15 16:01:57 2002
@@ -425,8 +425,12 @@
 	regs->gp = ex.a_gpvalue;
 #endif
 	start_thread(regs, ex.a_entry, current->mm->start_stack);
-	if (current->ptrace & PT_PTRACED)
-		send_sig(SIGTRAP, current, 0);
+	if (current->ptrace & PT_PTRACED) {
+		if (current->ptrace & PT_TRACE_EXEC)
+			ptrace_notify ((PTRACE_EVENT_EXEC << 8) | SIGTRAP);
+		else
+			send_sig(SIGTRAP, current, 0);
+	}
 	return 0;
 }
 
diff -Nru a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	Thu Aug 15 16:01:58 2002
+++ b/fs/binfmt_elf.c	Thu Aug 15 16:01:58 2002
@@ -786,8 +786,12 @@
 #endif
 
 	start_thread(regs, elf_entry, bprm->p);
-	if (current->ptrace & PT_PTRACED)
-		send_sig(SIGTRAP, current, 0);
+	if (current->ptrace & PT_PTRACED) {
+		if (current->ptrace & PT_TRACE_EXEC)
+			ptrace_notify ((PTRACE_EVENT_EXEC << 8) | SIGTRAP);
+		else
+			send_sig(SIGTRAP, current, 0);
+	}
 	retval = 0;
 out:
 	return retval;
diff -Nru a/include/asm-arm/ptrace.h b/include/asm-arm/ptrace.h
--- a/include/asm-arm/ptrace.h	Thu Aug 15 16:01:57 2002
+++ b/include/asm-arm/ptrace.h	Thu Aug 15 16:01:57 2002
@@ -6,10 +6,7 @@
 #define PTRACE_GETFPREGS	14
 #define PTRACE_SETFPREGS	15
 
-#define PTRACE_SETOPTIONS	21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD	0x00000001
+#define PTRACE_OLDSETOPTIONS	21
 
 #include <asm/proc/ptrace.h>
 
diff -Nru a/include/asm-i386/ptrace.h b/include/asm-i386/ptrace.h
--- a/include/asm-i386/ptrace.h	Thu Aug 15 16:01:57 2002
+++ b/include/asm-i386/ptrace.h	Thu Aug 15 16:01:57 2002
@@ -49,10 +49,7 @@
 #define PTRACE_GETFPXREGS         18
 #define PTRACE_SETFPXREGS         19
 
-#define PTRACE_SETOPTIONS         21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_OLDSETOPTIONS         21
 
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
diff -Nru a/include/asm-ia64/ptrace.h b/include/asm-ia64/ptrace.h
--- a/include/asm-ia64/ptrace.h	Thu Aug 15 16:01:58 2002
+++ b/include/asm-ia64/ptrace.h	Thu Aug 15 16:01:58 2002
@@ -287,9 +287,6 @@
 #define PTRACE_GETREGS		18	/* get all registers (pt_all_user_regs) in one shot */
 #define PTRACE_SETREGS		19	/* set all registers (pt_all_user_regs) in one shot */
 
-#define PTRACE_SETOPTIONS	21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD	0x00000001
+#define PTRACE_OLDSETOPTIONS	21
 
 #endif /* _ASM_IA64_PTRACE_H */
diff -Nru a/include/asm-mips/ptrace.h b/include/asm-mips/ptrace.h
--- a/include/asm-mips/ptrace.h	Thu Aug 15 16:01:57 2002
+++ b/include/asm-mips/ptrace.h	Thu Aug 15 16:01:57 2002
@@ -59,10 +59,7 @@
 /* #define PTRACE_GETFPXREGS		18 */
 /* #define PTRACE_SETFPXREGS		19 */
 
-#define PTRACE_SETOPTIONS	21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD	0x00000001
+#define PTRACE_OLDSETOPTIONS	21
 
 #ifdef _LANGUAGE_ASSEMBLY
 #include <asm/offset.h>
diff -Nru a/include/asm-mips64/ptrace.h b/include/asm-mips64/ptrace.h
--- a/include/asm-mips64/ptrace.h	Thu Aug 15 16:01:58 2002
+++ b/include/asm-mips64/ptrace.h	Thu Aug 15 16:01:58 2002
@@ -64,7 +64,7 @@
 /* #define PTRACE_GETFPXREGS		18 */
 /* #define PTRACE_SETFPXREGS		19 */
 
-#define PTRACE_SETOPTIONS	21
+#define PTRACE_OLDSETOPTIONS	21
 
 /* options set using PTRACE_SETOPTIONS */
 #define PTRACE_O_TRACESYSGOOD	0x00000001
diff -Nru a/include/asm-s390/ptrace.h b/include/asm-s390/ptrace.h
--- a/include/asm-s390/ptrace.h	Thu Aug 15 16:01:57 2002
+++ b/include/asm-s390/ptrace.h	Thu Aug 15 16:01:57 2002
@@ -105,10 +105,7 @@
 
 #define STACK_FRAME_OVERHEAD	96	/* size of minimum stack frame */
 
-#define PTRACE_SETOPTIONS         21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_OLDSETOPTIONS         21
 
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
diff -Nru a/include/asm-s390x/ptrace.h b/include/asm-s390x/ptrace.h
--- a/include/asm-s390x/ptrace.h	Thu Aug 15 16:01:57 2002
+++ b/include/asm-s390x/ptrace.h	Thu Aug 15 16:01:57 2002
@@ -85,10 +85,7 @@
 
 #define STACK_FRAME_OVERHEAD    160      /* size of minimum stack frame */
 
-#define PTRACE_SETOPTIONS         21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_OLDSETOPTIONS         21
 
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
diff -Nru a/include/asm-sh/ptrace.h b/include/asm-sh/ptrace.h
--- a/include/asm-sh/ptrace.h	Thu Aug 15 16:01:58 2002
+++ b/include/asm-sh/ptrace.h	Thu Aug 15 16:01:58 2002
@@ -44,10 +44,7 @@
 #define REG_XDREG14	47
 #define REG_FPSCR	48
 
-#define PTRACE_SETOPTIONS         21
-
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_OLDSETOPTIONS         21
 
 /*
  * This struct defines the way the registers are stored on the
diff -Nru a/include/asm-x86_64/ptrace.h b/include/asm-x86_64/ptrace.h
--- a/include/asm-x86_64/ptrace.h	Thu Aug 15 16:01:58 2002
+++ b/include/asm-x86_64/ptrace.h	Thu Aug 15 16:01:58 2002
@@ -32,7 +32,7 @@
 /* top of stack page */ 
 #define FRAME_SIZE 168
 
-#define PTRACE_SETOPTIONS         21
+#define PTRACE_OLDSETOPTIONS         21
 
 /* options set using PTRACE_SETOPTIONS */
 #define PTRACE_O_TRACESYSGOOD     0x00000001
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Thu Aug 15 16:01:57 2002
+++ b/include/linux/mm.h	Thu Aug 15 16:01:57 2002
@@ -359,6 +359,9 @@
 extern int ptrace_detach(struct task_struct *, unsigned int);
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_check_attach(struct task_struct *task, int kill);
+extern int ptrace_setoptions(struct task_struct *child, long data);
+extern int ptrace_request(struct task_struct *child, long request, long addr, long data);
+extern void ptrace_notify(int exit_code);
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
diff -Nru a/include/linux/ptrace.h b/include/linux/ptrace.h
--- a/include/linux/ptrace.h	Thu Aug 15 16:01:57 2002
+++ b/include/linux/ptrace.h	Thu Aug 15 16:01:57 2002
@@ -21,6 +21,23 @@
 
 #define PTRACE_SYSCALL		  24
 
+/* 0x4200-0x4300 are reserved for architecture-independent additions.  */
+#define PTRACE_SETOPTIONS	0x4200
+#define PTRACE_GETEVENTMSG	0x4201
+
+/* options set using PTRACE_SETOPTIONS */
+#define PTRACE_O_TRACESYSGOOD	0x00000001
+#define PTRACE_O_TRACEFORK	0x00000002
+#define PTRACE_O_TRACEVFORK	0x00000004
+#define PTRACE_O_TRACECLONE	0x00000008
+#define PTRACE_O_TRACEEXEC	0x00000010
+
+/* Wait extended result codes for the above trace options.  */
+#define PTRACE_EVENT_FORK	1
+#define PTRACE_EVENT_VFORK	2
+#define PTRACE_EVENT_CLONE	3
+#define PTRACE_EVENT_EXEC	4
+
 #include <asm/ptrace.h>
 
 #endif
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Aug 15 16:01:57 2002
+++ b/include/linux/sched.h	Thu Aug 15 16:01:57 2002
@@ -49,6 +49,7 @@
 #define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
 #define CLONE_DETACHED	0x00200000	/* parent wants no child-exit signal */
 #define CLONE_RELEASE_VM 0x00400000	/* release the userspace VM */
+#define CLONE_UNTRACED  0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 
@@ -371,6 +372,8 @@
 /* journalling filesystem info */
 	void *journal_info;
 	struct dentry *proc_dentry;
+
+	unsigned long ptrace_message;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
@@ -407,6 +410,10 @@
 #define PT_DTRACE	0x00000002	/* delayed trace (used on m68k, i386) */
 #define PT_TRACESYSGOOD	0x00000004
 #define PT_PTRACE_CAP	0x00000008	/* ptracer can follow suid-exec */
+#define PT_TRACE_FORK	0x00000010
+#define PT_TRACE_VFORK	0x00000020
+#define PT_TRACE_CLONE	0x00000040
+#define PT_TRACE_EXEC	0x00000080
 
 /*
  * Limit the stack by to some sane default: root can always
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Aug 15 16:01:57 2002
+++ b/kernel/fork.c	Thu Aug 15 16:01:57 2002
@@ -26,6 +26,7 @@
 #include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/ptrace.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -755,6 +756,10 @@
 	if (retval)
 		goto bad_fork_cleanup_namespace;
 	
+	/* Syscall tracing should be turned off in the child regardless
+	   of CLONE_PTRACE.  */
+	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
+
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
 	   
@@ -858,6 +863,22 @@
 	goto fork_out;
 }
 
+static inline int fork_traceflag (unsigned clone_flags)
+{
+	if (clone_flags & (CLONE_UNTRACED | CLONE_IDLETASK))
+		return 0;
+	else if (clone_flags & CLONE_VFORK) {
+		if (current->ptrace & PT_TRACE_VFORK)
+			return PTRACE_EVENT_VFORK;
+	} else if ((clone_flags & CSIGNAL) != SIGCHLD) {
+		if (current->ptrace & PT_TRACE_CLONE)
+			return PTRACE_EVENT_CLONE;
+	} else if (current->ptrace & PT_TRACE_FORK)
+		return PTRACE_EVENT_FORK;
+
+	return 0;
+}
+
 /*
  *  Ok, this is the main fork-routine.
  *
@@ -870,8 +891,16 @@
 			    unsigned long stack_size)
 {
 	struct task_struct *p;
+	int trace = 0;
+
+	if (unlikely(current->ptrace)) {
+		trace = fork_traceflag (clone_flags);
+		if (trace)
+			clone_flags |= CLONE_PTRACE;
+	}
 
 	p = copy_process(clone_flags, stack_start, regs, stack_size);
+
 	if (!IS_ERR(p)) {
 		struct completion vfork;
 
@@ -885,6 +914,12 @@
 
 		wake_up_forked_process(p);		/* do this last */
 		++total_forks;
+
+		if (unlikely (trace)) {
+			current->ptrace_message = (unsigned long) p->pid;
+			ptrace_notify ((trace << 8) | SIGTRAP);
+		}
+
 		if (clone_flags & CLONE_VFORK)
 			wait_for_completion(&vfork);
 		else
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
+++ b/kernel/ptrace.c	Thu Aug 15 16:01:58 2002
@@ -13,6 +13,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/ptrace.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -216,4 +217,70 @@
 		len -= retval;			
 	}
 	return copied;
+}
+
+int ptrace_setoptions(struct task_struct *child, long data)
+{
+	if (data & PTRACE_O_TRACESYSGOOD)
+		child->ptrace |= PT_TRACESYSGOOD;
+	else
+		child->ptrace &= ~PT_TRACESYSGOOD;
+
+	if (data & PTRACE_O_TRACEFORK)
+		child->ptrace |= PT_TRACE_FORK;
+	else
+		child->ptrace &= ~PT_TRACE_FORK;
+
+	if (data & PTRACE_O_TRACEVFORK)
+		child->ptrace |= PT_TRACE_VFORK;
+	else
+		child->ptrace &= ~PT_TRACE_VFORK;
+
+	if (data & PTRACE_O_TRACECLONE)
+		child->ptrace |= PT_TRACE_CLONE;
+	else
+		child->ptrace &= ~PT_TRACE_CLONE;
+
+	if (data & PTRACE_O_TRACEEXEC)
+		child->ptrace |= PT_TRACE_EXEC;
+	else
+		child->ptrace &= ~PT_TRACE_EXEC;
+
+	if ((data & (PTRACE_O_TRACESYSGOOD | PTRACE_O_TRACEFORK
+		    | PTRACE_O_TRACEVFORK | PTRACE_O_TRACECLONE
+		    | PTRACE_O_TRACEEXEC))
+	    != data)
+		return -EINVAL;
+
+	return 0;
+}
+
+int ptrace_request(struct task_struct *child, long request,
+		   long addr, long data)
+{
+	int ret = -EIO;
+
+	switch (request) {
+	case PTRACE_SETOPTIONS:
+		ret = ptrace_setoptions(child, data);
+		break;
+	case PTRACE_GETEVENTMSG:
+		ret = put_user(child->ptrace_message, (unsigned long *) data);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+void ptrace_notify(int exit_code)
+{
+	if (current->ptrace & PT_PTRACED) {
+		/* Let the debugger run.  */
+		current->exit_code = exit_code;
+		set_current_state(TASK_STOPPED);
+		notify_parent(current, SIGCHLD);
+		schedule();
+	}
 }
