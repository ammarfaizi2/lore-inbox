Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbTAQEgQ>; Thu, 16 Jan 2003 23:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbTAQEgQ>; Thu, 16 Jan 2003 23:36:16 -0500
Received: from holomorphy.com ([66.224.33.161]:29844 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267349AbTAQEgP>;
	Thu, 16 Jan 2003 23:36:15 -0500
Date: Thu, 16 Jan 2003 20:44:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@zip.com.au
Subject: Re: Linux 2.5.59
Message-ID: <20030117044451.GO919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@zip.com.au
References: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 06:28:03PM -0800, Linus Torvalds wrote:
> Updates to sparc, alpha, ppc64, fbdev, XFS, AGP, kbuild, arm...
> Likely the last release by me in a while, but Andrew & co can hold the 
> fort..

struct thread_info is shared with the stack, not struct task_struct.
False positives have been seen.


-- wli


===== arch/i386/kernel/irq.c 1.24 vs edited =====
--- 1.24/arch/i386/kernel/irq.c	Thu Oct 31 07:28:34 2002
+++ edited/arch/i386/kernel/irq.c	Thu Jan 16 20:39:53 2003
@@ -338,9 +338,9 @@
 
 		__asm__ __volatile__("andl %%esp,%0" :
 					"=r" (esp) : "0" (8191));
-		if (unlikely(esp < (sizeof(struct task_struct) + 1024))) {
+		if (unlikely(esp < (sizeof(struct thread_info) + 1024))) {
 			printk("do_IRQ: stack overflow: %ld\n",
-				esp - sizeof(struct task_struct));
+				esp - sizeof(struct thread_info));
 			dump_stack();
 		}
 	}
