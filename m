Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264488AbUEaBic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUEaBic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 21:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUEaBib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 21:38:31 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:10249 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S264488AbUEaBia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 21:38:30 -0400
Message-ID: <1085958812.40ba6a9c828f6@vds.kolivas.org>
Date: Mon, 31 May 2004 09:13:32 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired with a single array
References: <40B81F24.9080405@bigpond.net.au> <200405292117.56089.kernel@kolivas.org> <40B92874.50009@bigpond.net.au> <200405302256.02703.kernel@kolivas.org> <40BA7683.2000501@bigpond.net.au>
In-Reply-To: <40BA7683.2000501@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Williams <pwil3058@bigpond.net.au>:

> Con Kolivas wrote:
> > The interactive credit?
> 
> No.  I was asking about the mechanism in schedule() that, based on the 
> value of "activated", allows some tasks to count their time on the run 
> queue as sleep time.

No this is different again. When there is significant load and an interactive
task (like X) is using bursts of cpu it will not get a chance to sleep. It will
either run out of timeslice or be preempted and thus will be constantly on the
runqueue. In that time if only sleep time is counted it is progressively seen
as a cpu bound task - in fact this was a major problem before where X would
basically die under load because you'd move a window and it would be constantly
waiting for more cpu time rather than ever sleeping.
 
> I also think that their is a category of task that may be automatically 
> detected and that needs special attention and that is tasks that need 
> very regular access to small bursts of CPU.  I suspect that the tasks 
> doing the mpeg and divx encoding/decoding that you refer to above fall 
> into this category.  The key to identifying these tasks would be that 
> the variance (or standard deviation) of their sleeps would be close to 
> zero and as they probably do much the same amount of work each CPU burst 
> the same would be true of the variance of the length of the CPU bursts.

I've already tried that experiment and I personally failed to make the pattern
of sleep/burst correspond with interactivity. There is a huge variation in the
duration of sleep/run for all different things, and it changes with load. Of
course your modelling may be better than mine.

> Dr Peter Williams                                pwil3058@bigpond.net.au

Oooh I've got one of those too but I normally dont use it on lkml.
So just for this once...

Dr Con Kolivas
