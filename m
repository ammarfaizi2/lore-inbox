Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUH3BHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUH3BHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 21:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUH3BHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 21:07:17 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:47760 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S265977AbUH3BHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 21:07:14 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q1
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@RAYTHEON.COM, nando@ccrma.Stanford.EDU
In-Reply-To: <20040828130128.GA19751@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824195122.GA9949@yoda.timesys> <20040828123622.GC17908@elte.hu>
	 <20040828130128.GA19751@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1093827987.19042.49.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Aug 2004 18:06:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 06:01, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * Scott Wood <scott@timesys.com> wrote:
> > 
> > > If I'm missing something, please let me know, but I don't see a good
> > > way to implement it without blocking for the IRQ thread's completion
> > > (such as with the per-IRQ waitqueues in M5).
> > 
> > agreed, this is a hole in generic_synchronize_irq(). I've added
> > handler-completion waitqueues to my current tree, it will show up in
> > -Q1.
> 
> i've uploaded -Q1:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q1
> 
> as with -Q0, the following patch has to be applied to 2.6.8.1 first:
> 
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> 
> those who still have DRI problems under -Q1 - please unapply the
> drm_os_linux.h change, does the fix the lockups?

I managed to do a few quick tests yesterday of voluntary Q3:

SMP kernel on UP machine (Athlon64): hangs during boot, goes a little
further than before but hangs anyway:

requesting new irq thread for IRQ169
ata1: dev 0 ATA, max UDMA/133 ...
IRQ#169 thread started up
ata1: dev 0 configured for UDMA/133 ...
scsi0: sata_promise
ata2: dev 0 ATA ...
  --- hangs ---

SMP kernel on SMP machine (dual Athlon):
softirq-preempt=0 hardirq-preempt=0 acpi=on: hangs
  afaik hang happens when something needs interrupts, first culprit in
  my machine is eth0, if I disable it I can go further ahead and boot
  but alsa has timeouts, presumably because it is not getting
  interrupts.
softirq-preempt=0 hardirq-preempt=0 acpi=off: boots normally, 
  jack, glxgears work fine (but high latency spikes)
softirq-preempt=1 hardirq-preempt=1 acpi=off: boots normally,
  jack works fine, glxgears hangs machine after a while
Sorry I was not able to check all permutations, I was late and stopped
rebooting the machine :-) I think I did one more test with sort=1,
hard=1, acpi=off and did not manage to hang the machine. 

-- Fernando


