Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWAIJbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWAIJbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWAIJbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:31:47 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:21925 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751196AbWAIJbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:31:46 -0500
Date: Mon, 9 Jan 2006 15:01:42 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
Message-ID: <20060109093141.GA10811@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <43C165BC.F7C6DCF5@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C165BC.F7C6DCF5@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 10:19:24PM +0300, Oleg Nesterov wrote:
> ->donelist becomes != NULL only in rcu_process_callbacks().
> 
> rcu_process_callbacks() always calls rcu_do_batch() when
> ->donelist != NULL.
> 
> rcu_do_batch() schedules rcu_process_callbacks() again if
> ->donelist was not flushed entirely.
> 
> So ->donelist != NULL means that rcu_tasklet is either
> TASKLET_STATE_SCHED or TASKLET_STATE_RUN, we don't need to
> check it in __rcu_pending().

Do I smell a bug wrt CPU Hotplug here? Basically, I see that we do
a rcu_move_batch of ->curlist and ->nxtlist of the dead CPU. Why not
->donelist? If we have to do a rcu_move_batch of ->donelist also,
then perhaps the ->donelist != NULL check is required in
rcu_pending? This is considering that the RCU tasklet of the dead
CPU is killed (rather than moved over to a different CPU).


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
