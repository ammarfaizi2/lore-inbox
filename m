Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131756AbRDTSXa>; Fri, 20 Apr 2001 14:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131809AbRDTSXU>; Fri, 20 Apr 2001 14:23:20 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:16389 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S131756AbRDTSXI>;
	Fri, 20 Apr 2001 14:23:08 -0400
Message-ID: <20010420201713.A981@bug.ucw.cz>
Date: Fri, 20 Apr 2001 20:17:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Tiny cleanup of entry.S
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I believe that no ifdefs are worth several bytes of code expansion...

Index: arch/i386/kernel/head.S
===================================================================
RCS file: /home/cvs/Repository/linux/arch/i386/kernel/head.S,v
retrieving revision 1.1.1.1
diff -u -u -r1.1.1.1 head.S
--- arch/i386/kernel/head.S	2000/09/04 16:54:43	1.1.1.1
+++ arch/i386/kernel/head.S	2001/02/13 13:44:48
@@ -169,9 +169,7 @@
 	rep
 	movsl
 1:
-#ifdef CONFIG_SMP
 checkCPUtype:
-#endif
 
 	movl $-1,X86_CPUID		#  -1 for no CPUID initially
 
@@ -244,9 +242,7 @@
 	orl $2,%eax		# set MP
 2:	movl %eax,%cr0
 	call check_x87
-#ifdef CONFIG_SMP
 	incb ready
-#endif
 	lgdt gdt_descr
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
@@ -278,9 +274,7 @@
 	jmp L6			# main should never return here, but
 				# just in case, we know what happens.
 
-#ifdef CONFIG_SMP
 ready:	.byte 0
-#endif
 
 /*
  * We depend on ET to be correct. This checks for 287/387.

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
