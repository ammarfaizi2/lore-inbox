Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVGHUOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVGHUOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVGHUOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:14:22 -0400
Received: from unused.mind.net ([69.9.134.98]:11394 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262856AbVGHUM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:12:58 -0400
Date: Fri, 8 Jul 2005 13:12:09 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
In-Reply-To: <20050708080359.GA32001@elte.hu>
Message-ID: <Pine.LNX.4.58.0507081246340.30549@echo.lysdexia.org>
References: <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
 <20050707104859.GD22422@elte.hu> <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org>
 <20050708080359.GA32001@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Ingo Molnar wrote:

> could you check whether the priority leakage happens if you disable SMP?  
> (if you can reproduce it easily)

No priority leakages have been seen with UP configs on any of the 
machines I've been testing.

The leakage is not hard to reproduce under SMT:  start up jackd from a
text vc with an rt prio of 60 (or some unique prio above the IRQ threads),
then restart X and login.  After several minutes, X and all of its
children will be running at whatever prio jackd was started at (but still
SCHED_NORMAL).  Eventually, init, a handful of SCHED_NORMAL kernel
threads, and other random processes are all running at the same priority.  
When reset to default priority with chrt or schedtool, these processes
eventually revert back to the leaked priority level.  When jackd is
stopped, the priorities stay in their elevated state.  If jackd is not 
started before logging in to X, then the priority of one of the SCHED_FF 
kernel threads is leaked to other processes in the same manner.

--ww

