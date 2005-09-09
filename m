Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVIIRwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVIIRwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVIIRwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:52:01 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:6582 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030289AbVIIRwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:52:00 -0400
Date: Fri, 9 Sep 2005 13:50:35 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Message-ID: <200509091351_MC3-1-A9A7-F01A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.61.0509091208350.6247@goblin.wat.veritas.com>

On Fri, 9 Sep 2005 at 12:14:38 +0100 (BST), Hugh Dickins wrote:

> On Fri, 9 Sep 2005, Andi Kleen wrote:
> > 
> > It won't give more accurate backtraces, not even on i386 because show_stack
> > doesn't have any code to follow frame pointers.
> 
> Ah, right.

What's this for, then? (arch/i386/kernel/traps.c line 116)


static inline unsigned long print_context_stack(struct thread_info *tinfo,
                                unsigned long *stack, unsigned long ebp)
{
        unsigned long addr;

#ifdef  CONFIG_FRAME_POINTER
        while (valid_stack_ptr(tinfo, (void *)ebp)) {
                addr = *(unsigned long *)(ebp + 4);
                printk(" [<%08lx>] ", addr);
                print_symbol("%s", addr);
                printk("\n");
                ebp = *(unsigned long *)ebp;
        }
#else


I get nice clean stack traces on i386 with frame pointers enabled and
the kernel is smaller as well.

__
Chuck
Subliminal URL: www.sluggy.com/daily.php?date=050905
