Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVCUUdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVCUUdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVCUUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:33:39 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:53012 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261862AbVCUUcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:32:43 -0500
Date: Mon, 21 Mar 2005 21:25:51 +0100
Message-Id: <200503212025.j2LKPpUt011337@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 547] M68k: Add missing pieces of thread info TIF_MEMDIE support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing pieces of thread info TIF_MEMDIE support (introduced in
2.6.11-rc3)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc1/include/asm-m68k/processor.h	2004-04-30 17:54:35.000000000 +0200
+++ linux-m68k-2.6.12-rc1/include/asm-m68k/processor.h	2005-03-20 11:57:32.743537879 +0100
@@ -63,7 +63,8 @@ struct task_work {
 	char          need_resched;
 	unsigned char delayed_trace;	/* single step a syscall */
 	unsigned char syscall_trace;	/* count of syscall interceptors */
-	unsigned char pad[3];
+	unsigned char memdie;		/* task was selected to be killed */
+	unsigned char pad[2];
 };
 
 struct thread_struct {
--- linux-2.6.12-rc1/include/asm-m68k/thread_info.h	2005-02-03 15:05:36.000000000 +0100
+++ linux-m68k-2.6.12-rc1/include/asm-m68k/thread_info.h	2005-02-04 13:20:27.000000000 +0100
@@ -70,6 +70,9 @@ extern int thread_flag_fixme(void);
 	case TIF_SYSCALL_TRACE:				\
 		tsk->thread.work.syscall_trace = val;	\
 		break;					\
+	case TIF_MEMDIE:				\
+		tsk->thread.work.memdie = val;		\
+		break;					\
 	default:					\
 		thread_flag_fixme();			\
 	}						\
@@ -87,6 +90,9 @@ extern int thread_flag_fixme(void);
 	case TIF_SYSCALL_TRACE:				\
 		___res = tsk->thread.work.syscall_trace;\
 		break;					\
+	case TIF_MEMDIE:				\
+		___res = tsk->thread.work.memdie;\
+		break;					\
 	default:					\
 		___res = thread_flag_fixme();		\
 	}						\

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
