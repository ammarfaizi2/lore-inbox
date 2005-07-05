Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVGEMZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVGEMZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 08:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVGEMZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 08:25:51 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:61568 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261839AbVGEMQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:16:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.2.1 for 2.6.11 and 2.6.12
Date: Tue, 5 Jul 2005 22:16:44 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <42B65525.1060308@bigpond.net.au> <200507051953.49132.kernel@kolivas.org> <42CA6E2F.7000408@bigpond.net.au>
In-Reply-To: <42CA6E2F.7000408@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507052216.45018.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005 21:25, Peter Williams wrote:
> Con Kolivas wrote:
> > On Tue, 5 Jul 2005 17:46, Peter Williams wrote:
> >>Peter Williams wrote:
> >>>Con Kolivas wrote:
> >>>>On Mon, 20 Jun 2005 15:33, Peter Williams wrote:
> >>>>>PlugSched-5.2.1 is available for 2.6.11 and 2.6.12 kernels.  This
> >>>>>version applies Con Kolivas's latest modifications to his "nice" aware
> >>>>>SMP load balancing patches.
> >>>>
> >>>>Thanks Peter.
> >>>>Any word from your own testing/testers on how well smp nice balancing
> >>>>is working for them now?
> >>>
> >>>No, they got side tracked onto something else but should start working
> >>>on it again soon.  I'll give them a prod :-)
> >>
> >>Con,
> >>	We've done some more testing with this with results that are still
> >>disappointing.
> >
> > Is this with the migration thread accounted patch as well?

The results from smp nice I've received so far show that a 30% slowdown 
(instead of 5% on uniprocessor) occurs to high priority tasks in the presence 
of low priority tasks worst case scenario when the tasks sleep frequently. 
However excellent smp nice support with negligible slowdown occurs (ie nice 
is well respected) when the tasks are fully cpu bound. This suggests that 
what is happening on task wakeup is the limiting factor with this smp nice 
implementation. This makes sense given that most of the balancing occurs 
during busy rebalance when the queues are busy. I tried ignoring the length 
of queue (ie not having the single task running check for idle rebalance) and 
while this improved the nice effect substantially, it also cost us heavily in 
throughput making it unwarranted.

Cheers,
Con
