Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269612AbUIRSdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269612AbUIRSdo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269610AbUIRSdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 14:33:44 -0400
Received: from gprs214-222.eurotel.cz ([160.218.214.222]:20356 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269609AbUIRSdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 14:33:40 -0400
Date: Sat, 18 Sep 2004 20:32:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com, cw@f00f.org, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040918183250.GA15198@elf.ucw.cz>
References: <1095045628.1173.637.camel@cube> <20040913075743.GA15722@elte.hu> <1095083649.1174.1293.camel@cube> <20040914153214.GA15558@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914153214.GA15558@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I'd much prefer LRU allocation. There are
> > > > lots of system calls that take PID values.
> > > > All such calls are hazardous. They're pretty
> > > > much broken by design.
> > > 
> > > this is a pretty sweeping assertion. Would you
> > > care to mention a few examples of such hazards?
> > 
> > kill(12345,9)
> > setpriority(PRIO_PROCESS,12345,-20)
> > sched_setscheduler(12345, SCHED_FIFO, &sp)
> > 
> > Prior to the call being handled, the process may
> > die and be replaced. Some random innocent process,
> > or a not-so-innocent one, will get acted upon by
> > mistake. This is broken and dangerous.
> 
> easy to fix: SIGSTOP the task, check it's really
> the one you want and then do the setpriority / 
> setscheduler call and SIGCONT it. Any privileged
> code that is about to spread some of its privileges
> via asynchronous system-calls need to be careful.

What if OOM killer decides it wants that memory in between? Attacker
could probably help it...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
