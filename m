Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTELNRC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbTELNRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:17:02 -0400
Received: from holomorphy.com ([66.224.33.161]:2737 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262134AbTELNRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:17:01 -0400
Date: Mon, 12 May 2003 06:29:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.69-mjb1
Message-ID: <20030512132939.GF19053@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <9380000.1052624649@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9380000.1052624649@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 08:44:09PM -0700, Martin J. Bligh wrote:
> thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
> 	Prep work to reduce kernel stacks to 4K
> interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
> 	Create a per-cpu interrupt stack.
> stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
> 	Check for kernel stack overflows.
> 4k_stack            (4K stacks pt 4)		Dave Hansen
> 	Config option to reduce kernel stacks to 4K


diff -urpN linux-2.5.69/include/asm-i386/processor.h kstk-2.5.69-1/include/asm-i386/processor.h
--- linux-2.5.69/include/asm-i386/processor.h	2003-05-04 16:53:00.000000000 -0700
+++ kstk-2.5.69-1/include/asm-i386/processor.h	2003-05-12 06:05:39.000000000 -0700
@@ -470,8 +470,8 @@ extern int kernel_thread(int (*fn)(void 
 extern unsigned long thread_saved_pc(struct task_struct *tsk);
 
 unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1022])
+#define KSTK_EIP(task)	(((unsigned long *)(task)->thread_info)[THREAD_SIZE/sizeof(unsigned long) - 5])
+#define KSTK_ESP(task)	(((unsigned long *)(task)->thread_info)[THREAD_SIZE/sizeof(unsigned long) - 2])
 
 struct microcode {
 	unsigned int hdrver;
