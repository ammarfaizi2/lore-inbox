Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVGKOnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVGKOnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVGKOkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:40:13 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:55002 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261882AbVGKOiK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:38:10 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Mon, 11 Jul 2005 15:38:22 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050711141232.GA16586@elte.hu> <20050711141622.GA17327@elte.hu>
In-Reply-To: <20050711141622.GA17327@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507111538.22551.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 Jul 2005 15:16, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > might be an incorrect printout of stack_left :( The esp looks more or
> > less normal. Not sure why it printed -52.
>
> here's the stack_left calculation:
>
> +       printk("ds: %04x   es: %04x   ss: %04x   preempt: %08x\n",
> +               regs->xds & 0xffff, regs->xes & 0xffff, ss,
> preempt_count()); +       printk("Process %s (pid: %d, threadinfo=%p
> task=%p stack_left=%ld worst_left=%ld)", +               current->comm,
> current->pid, current_thread_info(), current, +               (regs->esp &
> (THREAD_SIZE-1))-sizeof(struct thread_info), +              
> worst_stack_left);
>
> i cannot see anything wrong in it, but your esp is 0xc04cded0,
> THREAD_SIZE-1 is 0xfff, so the result should be:
>
> 	0xed0-sizeof(struct thread_info).
>
> which should not be -52.

Actually, it's now pretty much confirmed that this ISN'T a stack overflow, not 
just because of what you've said (now and before), but also because I've 
tried an 8K stacks kernel and, sadly, there's no stand-out stack abusers.

It's annoying that this is so readily reproducible here, yet almost impossible 
to debug, and clearly a sideaffect of 4KSTACKS.. without it actually being a 
stack overflow.

I realise 4KSTACKS is a considerable rework of the IRQ handler, etc. and 
probably even more heavily modified by rt-preempt, but is there nothing else 
that can be tested before a serial console run?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
