Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUJIUSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUJIUSt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUJIUSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:18:04 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5273 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267368AbUJIUOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:14:49 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: karim@opersys.com
Cc: stefan.eletzhofer@eletztrick.de,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <416845E4.206@opersys.com>
References: <41677E4D.1030403@mvista.com> <416822B7.5050206@opersys.com>
	 <1097346628.1428.11.camel@krustophenia.net>
	 <20041009212614.GA25441@tier.local>
	 <1097350227.1428.41.camel@krustophenia.net>
	 <20041009213817.GB25441@tier.local>
	 <1097351221.1428.46.camel@krustophenia.net>  <416845E4.206@opersys.com>
Content-Type: text/plain
Message-Id: <1097352885.1428.60.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 16:14:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 16:11, Karim Yaghmour wrote:
> Lee Revell wrote:
> > Yes.  The upper bound on the response time of an RT task is a function
> > of the longest non-preemptible code path in the kernel.  Currently this
> > is the processing of a single packet by netif_receive_skb.
> 
> And this has been demonstrated mathematically/algorithmically to be
> true 100% of the time, regardless of the load and the driver set? IOW,
> if I was building an automated industrial saw (based on a VP+IRQ-thread
> kernel or a combination of the above-mentioned agregate) with a
> safety mechanism that depended on the kernel's responsivness to
> outside events to avoid bodily harm, would you be willing to put your
> hand beneath it?
> 

In theory, I think yes, if all IRQs on the system run in threads except
the saw interrupt, and the RT task that controls the saw runs at a
higher priority than all the IRQ threads.  You can guarantee that other
interrupts won't delay the saw, because the saw irq is the only thing on
the system that runs in interrupt context.  With the current VP
implementation you are still bounded by the longest non-preemptible code
path in the kernel AKA the longest time that a spinlock is held. 
Replacing most spinlocks with mutexes reduces this to less than 20 code
paths according to Mvista, which then can be individually audited for
RT-safeness. 

That being said, no way would I put my hand under the saw with the
current implementation.  But, unless I am missing something, it seems
like this kind of determinism is possible with the Mvista design.

> How about things like a hard-rt deterministic nanosleep() 100% of the
> time with RTAI/fusion?

I will check that out, I have not looked at RTAI in over a year.

Lee

