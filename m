Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268779AbUIXOSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268779AbUIXOSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUIXOQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:16:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51890 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268779AbUIXOQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:16:12 -0400
Date: Thu, 23 Sep 2004 15:18:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Albert Cahalan <albert@users.sf.net>
Cc: Ingo Molnar <mingo@elte.hu>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com, cw@f00f.org, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040923131802.GR467@openzaurus.ucw.cz>
References: <1095045628.1173.637.camel@cube> <20040913075743.GA15722@elte.hu> <1095083649.1174.1293.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095083649.1174.1293.camel@cube>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > this is a pretty sweeping assertion. Would you
> > care to mention a few examples of such hazards?
> 
> kill(12345,9)
> setpriority(PRIO_PROCESS,12345,-20)
> sched_setscheduler(12345, SCHED_FIFO, &sp)
> 
> Prior to the call being handled, the process may
> die and be replaced. Some random innocent process,
> or a not-so-innocent one, will get acted upon by
> mistake. This is broken and dangerous.
> 
> Well, it's in the UNIX standard. The best one can
> do is to make the race window hard to hit, with LRU.

Well, you could create new state "DEAD" and enforce that every process stays there for
5 seconds after death. Throttle fork if no pids are free. Hide "DEAD" processes from ps/top.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

