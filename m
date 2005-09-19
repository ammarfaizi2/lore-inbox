Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVISFXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVISFXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVISFXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:23:12 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:63940 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932310AbVISFXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:23:11 -0400
Subject: RE: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Li Shaohua <shaohua.li@intel.com>
Cc: vatsa@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1127107381.9696.85.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 19 Sep 2005 15:23:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-09-19 at 14:48, Li, Shaohua wrote:
> Hi,
> >
> >On Mon, Sep 19, 2005 at 01:28:38PM +1000, Nigel Cunningham wrote:
> >> There is a race condition in taking down a cpu
> (kernel/cpu.c::cpu_down).
> >> A cpu can already be idling when we clear its online flag, and we do
> not
> >> force the idle task to reschedule. This results in __cpu_die timing
> out.
> >
> >"when we clear its online flag" - This happens in take_cpu_down in the
> >context of stopmachine thread. take_cpu_down also ensures that idle
> >thread runs when it returns (sched_idle_next). So when idle thread
> runs,
> >it should notice that it is offline and invoke play_dead.  So I don't
> >understand why __cpu_die should time out.
> I guess Nigel's point is cpu_idle is preempted before take_cpu_down. If
> the preempt occurs after the cpu_is_offline check, when the cpu (after
> sched_idle_next) goes into idle again, nobody can wake it up. Nigel,
> isn't it?

Maybe I'm just an ignoramus, but I was thinking (without being a
scheduler expert at all) that if the idle thread was already running,
trying to set it up to run next might possibly have zero effect. I've
added a bit of debugging code to try and see in better detail what's
happening.

Regards,

Nigel

> Thanks,
> Shaohua
-- 


