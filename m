Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVGIQCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVGIQCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 12:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVGIQCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 12:02:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36306 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261563AbVGIQCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 12:02:46 -0400
Date: Sat, 9 Jul 2005 18:02:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050709160210.GA14729@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709115817.GA4665@elte.hu> <200507091507.13215.s0348365@sms.ed.ac.uk> <20050709155704.GA14535@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709155704.GA14535@elte.hu>
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

>  c011ed50 t wakeup_softirqd
>  c011ed80 t trigger_softirqs
> 
> but it looks pretty weird. DEBUG_STACK_POISON (and the full-debug 
> .config i sent) could perhaps uncover other types of stack 
> corruptions.

there's one more pretty efficient debugging method:

  echo 1 > /proc/sys/kernel/trace_print_at_crash
  echo 1 > /proc/sys/kernel/trace_freerunning

and then upon oopses the kernel will print a full execution trace that 
led up to the crash. But this definitely needs a serial console to be 
usable, as the kernel will print out thousands of trace entries.

(also, since it seems your kernel crashes when trying to print out the 
stacktrace, you'd also have to move the print_traces(task) line within 
arch/i386/kernel/traps.c:show_trace() to the beginning of that 
function.)

	Ingo
