Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWD1XTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWD1XTp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWD1XTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:19:45 -0400
Received: from smtpout.mac.com ([17.250.248.185]:37073 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932491AbWD1XTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:19:44 -0400
In-Reply-To: <200604281409.00287.dvhltc@us.ibm.com>
References: <200604281409.00287.dvhltc@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E4F03A99-DFD6-4D59-81AA-DCE4129495DA@mac.com>
Cc: Ingo Molnar <mingo@elte.hu>, "lkml, " <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RT interrupt handling
Date: Fri, 28 Apr 2006 19:19:29 -0400
To: Darren Hart <dvhltc@us.ibm.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 28, 2006, at 17:08:59, Darren Hart wrote:
> I ran into a situation where binding a realtime testsuite to cpu 0  
> (on a 4 way opteron machine) locked the machine hard while binding  
> it to cpu 2 worked fine.  Some investigation suggests that the  
> interrupt handlers for eth0 and ioc0 (IRQ 24 and 26) had the  
> smp_affinity mask set to only cpu 0.  With the test case running  
> threads with rt prios in the 90s and the irqs running in the ~40s  
> (don't recall, somewhere around there I think), it isn't surprising  
> that the machine locked up.
>
> I'd like to hear people's thoughts on the following:
>
> o Why would those irqs be bound to just cpu 0?  Why not all cpus?

Are you running an irq balancing daemon of some sort?  (Or kernel IRQ  
balancer?)  I believe those alter the CPU affinity for various  
interrupt threads to optimize IRQ efficiency.


> o Is it reasonable to extend the smp_affinity for all interrupts to  
> all cpus to minimize this type of problem?

Probably so, although I would bet that it is already (unless I  
misunderstand the situation).


> o Should a userspace RT task be able to take down the system?  Do  
> we roll with the spiderman addage "With great power comes great  
> responsibility" when  discussing RT systems, or should we consider  
> some kind of priority boosting mechanism for kernel services that  
> must be run every so often to keep the system running?

The general consensus is that Linux RT code strives to be as hard-RT  
as possible, which means if you prioritize your code over the  
networking interrupt, you expect to get runtime even when the network  
card has work to do.  If you don't want it that way, don't set the  
priorities that way :-D.

Cheers,
Kyle Moffett

