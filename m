Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVGIOHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVGIOHN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 10:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVGIOHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 10:07:13 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:30403 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261416AbVGIOHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 10:07:11 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Sat, 9 Jul 2005 15:07:13 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709115817.GA4665@elte.hu>
In-Reply-To: <20050709115817.GA4665@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507091507.13215.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 Jul 2005 12:58, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > Got this (slightly better) oops. Figured out how to use my camera :-)
> >
> > http://devzero.co.uk/~alistair/oops6.jpeg
>
> this was a bit more useful - shows a softirq wakeup. Could you send me
> your vmlinux (bzip -9 compressed, via private mail), your gcc generates
> a slightly different code layout so i couldnt match up everything that
> might be useful.

Okay, I'll send you the vmlinux from -18 with a new digital photo, and config, 
with CONFIG_4KSTACKS enabled.

Do you want me to apply the patch blitz you just sent to the list before 
testing? Those are some impressive stack reductions, the 
ip_sockglue.c/blkdev_get() ones in combination look promising.

>
> > Onto your stack-footprint metric. I don't know what the number means,
> > but at a guess it's the size of the stack. Unfortunately, if this is
> > the case, it's unlikely to be an overflow causing the crash. Here's a
> > grep of dmesg just before the crash.
>
> it could still be near an overflow. To make sure i've changed the oops
> printout to also include the current stack left, and the worst-case
> stack-left value, and have uploaded the -51-18 kernel - could you try
> it? That way we can tell for sure. (note that the maximum-tracker can
> not always do an immediate printout of a worst-case - we have to skip
> printouts if irqs are disabled. [or we could recurse from within the
> scheduler or the printk code] Even in those cases we save the worst-case
> stack and print it out as soon as interrupts are enabled again. (The
> worst-case stack-left value printed out at oops time is immediate.)

I guess also, as you suggested elsewhere in this thread, I could try an 8K 
stacks kernel, let openvpn run (even just for 5 minutes, then close it) and 
see if I get a stack-footprint dump *for openvpn*, which so far I've not been 
able to observe.

Hopefully this would negate the possibility that there's a stack-footprint 
waiting to be generated, but just masked by the crash.

Is this actually useful to you?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
