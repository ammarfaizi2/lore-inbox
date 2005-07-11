Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVGKN6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVGKN6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVGKN56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:57:58 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:48328 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261755AbVGKNzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:55:33 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Mon, 11 Jul 2005 14:55:45 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050709155704.GA14535@elte.hu> <200507091704.12368.s0348365@sms.ed.ac.uk>
In-Reply-To: <200507091704.12368.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507111455.45105.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 Jul 2005 17:04, Alistair John Strachan wrote:
> On Saturday 09 Jul 2005 16:57, Ingo Molnar wrote:
> > * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > Okay, I'll send you the vmlinux from -18 with a new digital photo, and
> > > config, with CONFIG_4KSTACKS enabled.
> >
> > this crash too seems to indicate trigger_softirqs()/wakeup_softirqd().
> > Somewhere we somehow corrupt the stack and e.g. in oops7.jpg we return
> > to 00c011ed. Note that it's a right-shifted address that could be one of
> > these:
> >
> >  c011ed50 t wakeup_softirqd
> >  c011ed80 t trigger_softirqs
> >
> > but it looks pretty weird. DEBUG_STACK_POISON (and the full-debug
> > .config i sent) could perhaps uncover other types of stack corruptions.
>
> You weren't kidding about the overhead from DEBUG_STACK_POISON.
> Unfortunately that config causes a triple fault randomly after boot. The
> machine doesn't crash, or oops, it just resets.
>
> This problem has gone from bad to worse :-)

Okay, maybe not. Some combination of the debug options you enabled causes this 
problem, but DEBUG_STACK_POISON itself is not the cause. Today I compiled Yet 
Another (tm) CONFIG_4KSTACKS kernel with DEBUG_STACK_POISON, 
CONFIG_DEBUG_STACKOVERFLOW and CONFIG_LATENCY_TRACE, which worked fine (from 
a random reboot perspective).

I've also upgraded GCC to 4.0.1 as Jakub highlighted elsewhere in this thread 
that it had been released.

Here's a screenshot of the oops. Notice that "stack left" is now -52. We've 
confirmed this is a stack overflow!

http://devzero.co.uk/~alistair/oops8.jpeg

I'm going to try the 8K stack kernel with the same stuff and see if I can get 
a stack trace. I hope this is the beginning of the end for this problem.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
