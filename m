Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbTFZKSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 06:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbTFZKSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 06:18:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23205 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265522AbTFZKSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 06:18:06 -0400
Date: Thu, 26 Jun 2003 11:32:17 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remove *_segments() dummy functions again
Message-ID: <20030626103217.GJ451@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus.  Back on 4th November you applied a patch to remove the
now-unused *_segments() functions from all architectures ... but some
of the newer architecures still have them.  Please apply.

 asm-arm26/processor.h  |    4 ----
 asm-h8300/processor.h  |    3 ---
 asm-x86_64/processor.h |    2 --
 3 files changed, 9 deletions(-)

Index: include/asm-arm26/processor.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-arm26/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-arm26/processor.h	14 Jun 2003 22:15:54 -0000	1.2
+++ include/asm-arm26/processor.h	26 Jun 2003 10:24:47 -0000
@@ -100,10 +100,6 @@ struct task_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()			barrier()
Index: include/asm-h8300/processor.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-h8300/processor.h,v
retrieving revision 1.2
diff -u -p -r1.2 processor.h
--- include/asm-h8300/processor.h	24 Apr 2003 01:37:23 -0000	1.2
+++ include/asm-h8300/processor.h	26 Jun 2003 10:24:47 -0000
@@ -89,9 +89,6 @@ static inline void release_thread(struct
 
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)	do { } while (0)
-#define release_segments(mm)	do { } while (0)
-#define forget_segments()	do { } while (0)
 #define prepare_to_copy(tsk)	do { } while (0)
 
 /*
Index: include/asm-x86_64/processor.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-x86_64/processor.h,v
retrieving revision 1.14
diff -u -p -r1.14 processor.h
--- include/asm-x86_64/processor.h	14 Jun 2003 22:16:00 -0000	1.14
+++ include/asm-x86_64/processor.h	26 Jun 2003 10:24:47 -0000
@@ -280,8 +280,6 @@ extern void prepare_to_copy(struct task_
  */
 extern long kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-static inline void release_segments(struct mm_struct *mm) { }
-
 /*
  * Return saved PC of a blocked thread.
  * What is this good for? it will be always the scheduler or ret_from_fork.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
