Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVGGOvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVGGOvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVGGNjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:39:51 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:16258 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261526AbVGGNjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:39:19 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Thu, 7 Jul 2005 14:38:50 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507071315.24669.s0348365@sms.ed.ac.uk> <20050707122959.GA4962@elte.hu>
In-Reply-To: <20050707122959.GA4962@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071438.50575.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Jul 2005 13:29, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > http://devzero.co.uk/~alistair/oops1.jpeg
> >
> > I disabled the trace and the STACKOVERFLOW option seems to help; I've
> > got a (slightly truncated) oops from the kernel. What happens is that
> > I get an oops, then I get a BUG: warning me about the softlock, then I
> > get another oops. I'm about to reboot to confirm whether the second
> > oops is identical to the first (I suspect that it is).
>
> unfortunately the EIP is at 0xedc, which is a corrupted value. The stack
> trace portion that is visible on the screen is the usual pagefault trace
> - without any information about the crash site itself. What the oops
> tells us is that it's the openvpn process that crashed (if this was the
> first oops). The preempt_count is 0x20010004, which shows us that this
> was a section that had soft-IRQ-flags disabled and was in a hardirq
> context.  (see the meaning of the preempt bits at the top of
> include/linux/hardirq.h) That it's a hardirq handler that crashed is
> further corroborated by the esp, which points into a kernel data area
> (hardirq_ctx[], the 4K irq stacks), not into the process's kernel stack
> (which is at threadinfo).
>
> the stack pointer itself looks healthy, it's near the end of a 4K page,
> i.e. far from overflowing. So it would be really useful to get the full
> oops output. (that way you can also be sure it's the first crash you are
> seeing.)
>
> (i doubt netconsole debugging will work, given that we are in a hardirq
> context. Serial logging will work.)
>
> one thing you could try is to apply the attached patch and reproduce the
> crash. It should print a pure backtrace and lock the box up afterwards,
> so that you can take a picture.

Done, sorry for the delay.

http://devzero.co.uk/~alistair/oops4.jpeg

I don't think this is really any more helpful, the dereference is at "virtual 
address 00000001" which sounds fishy.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
