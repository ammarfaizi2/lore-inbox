Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVGGSxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVGGSxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVGGSvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:51:37 -0400
Received: from unused.mind.net ([69.9.134.98]:14250 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261463AbVGGSue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:50:34 -0400
Date: Thu, 7 Jul 2005 11:49:39 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-06
In-Reply-To: <20050707104859.GD22422@elte.hu>
Message-ID: <Pine.LNX.4.58.0507071140420.24968@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
 <20050707104859.GD22422@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Ingo Molnar wrote:

> > Still looking into this issue on -51-06.  Found something really odd: 
> > SCHED_NORMAL tasks will start to inherit the priority value of some 
> > other SCHED_FIFO task.  If JACK is started at a given SCHED_FIFO 
> > priority, X and all of its children will inherit the same priority 
> > value after login.  Other random processes will inherit this, too -- 
> > sometimes init...
> > 
> > SCHED_NORMAL tasks suddenly inheriting priority values in the range 
> > normally reserved for SCHED_FIFO could explain at least part of the 
> > meltdown I've been seeing.  Any thoughts?
> 
> is this inheritance perpetual? It is normal for some tasks to be boosted 
> momentarily, but if the condition remains even after jackd has exited, 
> it's clearly an anomaly. (lets call it "RT priority leakage".) Priority 
> leakage on SMP was fixed recently, but there could be other bugs 
> remaining.

Yes, this leakage perpetual.  That's what struck me as odd.

> There's priority-leakage debugging code in the -RT kernel, which is 
> activated if you enable CONFIG_DEBUG_PREEMPT. This debugging code, if 
> triggered, should produce 'BUG: comm/123 leaked RT prio 123 (123)?" type 
> of messages. But ... due to a bug it would not print out anything but 
> would lock up hard if it detects the condition (and if 
> RT_DEADLOCK_DETECT is enabled). I have fixed this reporting bug in the 
> -51-08 kernel.

-51-08 is building now.  I'll check out the latest, too.

--ww
