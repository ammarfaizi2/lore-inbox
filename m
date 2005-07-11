Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVGKPMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVGKPMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVGKPJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:09:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23242 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261950AbVGKPHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:07:08 -0400
Date: Mon, 11 Jul 2005 17:07:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050711150711.GA19290@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050709155704.GA14535@elte.hu> <200507091704.12368.s0348365@sms.ed.ac.uk> <200507111455.45105.s0348365@sms.ed.ac.uk> <20050711141232.GA16586@elte.hu> <20050711141622.GA17327@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711141622.GA17327@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > might be an incorrect printout of stack_left :( The esp looks more or 
> > less normal. Not sure why it printed -52.
> 
> here's the stack_left calculation:
> 
> +       printk("ds: %04x   es: %04x   ss: %04x   preempt: %08x\n",
> +               regs->xds & 0xffff, regs->xes & 0xffff, ss, preempt_count());
> +       printk("Process %s (pid: %d, threadinfo=%p task=%p stack_left=%ld worst_left=%ld)",
> +               current->comm, current->pid, current_thread_info(), current,
> +               (regs->esp & (THREAD_SIZE-1))-sizeof(struct thread_info),
> +               worst_stack_left);
> 
> i cannot see anything wrong in it, [...]

that should be "esp", not "regs->esp". regs->esp is something different 
upon in-kernel faults. I've uploaded -27 with the fix - but it should 
only confirm that it's not a stack overflow.

	Ingo
