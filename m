Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTLTQRh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 11:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbTLTQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 11:17:37 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:59009
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S264925AbTLTQR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 11:17:28 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031220111917.GA18267@elte.hu>
References: <1071864709.1044.172.camel@localhost>
	 <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au>
	 <200312201355.08116.kernel@kolivas.org>
	 <1071891168.1044.256.camel@localhost> <3FE3C6FC.7050401@cyberone.com.au>
	 <1071893802.1363.21.camel@localhost> <3FE3D0CB.603@cyberone.com.au>
	 <1071897314.1363.43.camel@localhost>  <20031220111917.GA18267@elte.hu>
Content-Type: text/plain
Message-Id: <1071937040.1025.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Dec 2003 17:17:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-20 at 12:19, Ingo Molnar wrote:
> * Christian Meder <chris@onestepahead.de> wrote:
> 
> > That would leave me with two possibilities: 2.6. is doing something
> > different in the gnomemeeting case or gnomemeeting is doing something
> > different in the 2.6 case. A cursory look at the gnomemeeting sources
> > didn't give me the impression that it's doing anything which would be
> > affected by 2.6 deployment but I'll ask on the gnomemeeting-devel list
> > for advice.
> 
> yep, i've looked at the source too and it doesnt do anything that 
> changed in 2.6 from an interactivity POV.
> 
> To analyze the precise workload that hurts gnomemeeting, could you try
> the following workload:
> 
> 	main()
> 	{
> 		for (;;) sched_yield();
> 	}
> 
> and run 1-2 copies of such a load-generator - does it degrade
> gnome-meeting audio just as much as eg. a kernel compile does?
> 
> as a next step, does the following degrade gnomemeeting?:
> 
> 	main()
> 	{
> 		for (;;) ;
> 	}
> 
> my guess would be that if the yield() one degrades interactivity too
> then this is unlikely to be somehow related to the scheduler proper.
> 
> If it doesnt degrade but the simple non-yield loop above does, then it's
> probably something scheduling related in the sound architecture. (eg. 
> use of yield() by some codepath of the sound drivers - although they
> dont seem to be doing anything like this.)
> 
> If neither of these workloads degrades gnomemeeting, but a kernel-make
> does, then it's the interactivity estimator.

Ok, the results are in. Running up to three yield-loops doesn't degrade
gnomemeeting. Running one non-yield loop does degrade gnomemeeting
_very_ slightly. Adding a second non-yield loop has approximately the
same stuttering effect as a kernel compile. Adding a third non-yield
loop makes gnomemeeting totally unusable.

All these tests were done with Nick's scheduler patch. If I should retry
with stock 2.6.0 just tell me.

Sound driver is by the way snd_es1968 in ALSA and maestro in OSS.

			Christian 

-- 
Christian Meder, email: chris@onestepahead.de
 
What's the railroad to me ?
I never go to see
Where it ends.
It fills a few hollows,
And makes banks for the swallows, 
It sets the sand a-blowing,
And the blackberries a-growing.
                      (Henry David Thoreau)
 




