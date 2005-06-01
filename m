Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVFAX3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVFAX3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFAX1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:27:01 -0400
Received: from users.ccur.com ([208.248.32.211]:36293 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261453AbVFAXQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:16:17 -0400
Date: Wed, 1 Jun 2005 19:16:15 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: steve.rotolo@ccur.com, linux-kernel@vger.kernel.org, bugsy@ccur.com
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
Message-ID: <20050601231615.GA11301@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1117561608.1439.168.camel@whiz> <200506020047.16752.kernel@kolivas.org> <1117651285.22879.73.camel@bonefish> <200506020737.20098.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506020737.20098.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 2 Jun 2005 04:41, Steve Rotolo wrote:
> > I guess the bottom-line is: given N logical cpus, 1/N of all
> > SCHED_NORMAL tasks may get stuck on a sibling cpu with no chance to
> > run.  All it takes is one spinning SCHED_FIFO task.  Sounds like a bug.
> 
> You're right, and excuse me for missing it. We have to let SCHED_NORMAL tasks 
> run for some period with rt tasks. There shouldn't be any combination of 
> mutually exclusive tasks for siblings.
> 
> I'll work on something.

Wild thought: how about doing this for the sibling ...

	rp->nr_running += SOME_BIG_NUMBER

when a SCHED_FIFO task starts running on some cpu, and
undo the above when the cpu is released.   This fools
the load balancer into _gradually_ moving tasks off the
sibling, when the cpu is hogged by some SCHED_FIFO task,
but should have little effect if a SCHED_FIFO task takes
little cpu time.

Regards,
Joe
--
"Money can buy bandwidth, but latency is forever" -- John Mashey


