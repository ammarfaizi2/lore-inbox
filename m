Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132870AbRDQV3e>; Tue, 17 Apr 2001 17:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132869AbRDQV3Z>; Tue, 17 Apr 2001 17:29:25 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:60676 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S132868AbRDQV3M>;
	Tue, 17 Apr 2001 17:29:12 -0400
Message-ID: <20010417232614.A4377@bug.ucw.cz>
Date: Tue, 17 Apr 2001 23:26:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: i386 cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These are tiny cleanups you might like. sizes are "logically"
long. No, it does not matter on i386.

processor.h makes INIT_TSS look much more readable. [Please tell me
applied or rejected]

							Pavel

Index: include/asm-i386/posix_types.h
===================================================================
RCS file: /home/cvs/Repository/linux/include/asm-i386/posix_types.h,v
retrieving revision 1.1.1.1
diff -u -u -r1.1.1.1 posix_types.h
--- include/asm-i386/posix_types.h	2000/09/04 16:50:33	1.1.1.1
+++ include/asm-i386/posix_types.h	2001/02/13 13:49:18
@@ -16,9 +16,9 @@
 typedef unsigned short	__kernel_ipc_pid_t;
 typedef unsigned short	__kernel_uid_t;
 typedef unsigned short	__kernel_gid_t;
-typedef unsigned int	__kernel_size_t;
-typedef int		__kernel_ssize_t;
-typedef int		__kernel_ptrdiff_t;
+typedef unsigned long	__kernel_size_t;
+typedef long		__kernel_ssize_t;
+typedef long		__kernel_ptrdiff_t;
 typedef long		__kernel_time_t;
 typedef long		__kernel_suseconds_t;
 typedef long		__kernel_clock_t;
Index: include/asm-i386/processor.h
===================================================================
RCS file: /home/cvs/Repository/linux/include/asm-i386/processor.h,v
retrieving revision 1.2
diff -u -u -r1.2 processor.h
--- include/asm-i386/processor.h	2000/09/12 21:27:18	1.2
+++ include/asm-i386/processor.h	2001/02/13 13:49:22
@@ -365,19 +365,11 @@
 { &init_mm, 0, 0, NULL, PAGE_SHARED, VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
 
 #define INIT_TSS  {						\
-	0,0, /* back_link, __blh */				\
-	sizeof(init_stack) + (long) &init_stack, /* esp0 */	\
-	__KERNEL_DS, 0, /* ss0 */				\
-	0,0,0,0,0,0, /* stack1, stack2 */			\
-	0, /* cr3 */						\
-	0,0, /* eip,eflags */					\
-	0,0,0,0, /* eax,ecx,edx,ebx */				\
-	0,0,0,0, /* esp,ebp,esi,edi */				\
-	0,0,0,0,0,0, /* es,cs,ss */				\
-	0,0,0,0,0,0, /* ds,fs,gs */				\
-	__LDT(0),0, /* ldt */					\
-	0, INVALID_IO_BITMAP_OFFSET, /* tace, bitmap */		\
-	{~0, } /* ioperm */					\
+	esp0: sizeof(init_stack) + (long) &init_stack,		\
+	ss0: __KERNEL_DS,					\
+	ldt: __LDT(0),						\
+	bitmap: INVALID_IO_BITMAP_OFFSET,			\
+	ioperm: {~0, }						\
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\
 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
