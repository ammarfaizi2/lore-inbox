Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVISEX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVISEX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 00:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVISEX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 00:23:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36041 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932202AbVISEX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 00:23:26 -0400
Date: Mon, 19 Sep 2005 09:52:40 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050919042240.GA7506@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1127100518.9696.62.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127100518.9696.62.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 01:28:38PM +1000, Nigel Cunningham wrote:
> There is a race condition in taking down a cpu (kernel/cpu.c::cpu_down).
> A cpu can already be idling when we clear its online flag, and we do not
> force the idle task to reschedule. This results in __cpu_die timing out.

"when we clear its online flag" - This happens in take_cpu_down in the
context of stopmachine thread. take_cpu_down also ensures that idle 
thread runs when it returns (sched_idle_next). So when idle thread runs,
it should notice that it is offline and invoke play_dead.  So I don't 
understand why __cpu_die should time out.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
