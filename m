Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVGKOTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVGKOTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVGKOQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:16:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32132 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261814AbVGKOQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:16:20 -0400
Date: Mon, 11 Jul 2005 16:16:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050711141622.GA17327@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050709155704.GA14535@elte.hu> <200507091704.12368.s0348365@sms.ed.ac.uk> <200507111455.45105.s0348365@sms.ed.ac.uk> <20050711141232.GA16586@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711141232.GA16586@elte.hu>
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

> might be an incorrect printout of stack_left :( The esp looks more or 
> less normal. Not sure why it printed -52.

here's the stack_left calculation:

+       printk("ds: %04x   es: %04x   ss: %04x   preempt: %08x\n",
+               regs->xds & 0xffff, regs->xes & 0xffff, ss, preempt_count());
+       printk("Process %s (pid: %d, threadinfo=%p task=%p stack_left=%ld worst_left=%ld)",
+               current->comm, current->pid, current_thread_info(), current,
+               (regs->esp & (THREAD_SIZE-1))-sizeof(struct thread_info),
+               worst_stack_left);

i cannot see anything wrong in it, but your esp is 0xc04cded0, 
THREAD_SIZE-1 is 0xfff, so the result should be:

	0xed0-sizeof(struct thread_info).

which should not be -52.

	Ingo
