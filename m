Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934378AbWK3KWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934378AbWK3KWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934366AbWK3KWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:22:21 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:24792 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S933956AbWK3KWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:22:20 -0500
Date: Thu, 30 Nov 2006 13:22:06 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>,
       wenji@fnal.gov, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130102205.GA20654@2ka.mipt.ru>
References: <20061130061758.GA2003@elte.hu> <20061129.223055.05159325.davem@davemloft.net> <20061130064758.GD2003@elte.hu> <20061129.231258.65649383.davem@davemloft.net> <20061130073504.GA19437@elte.hu> <20061130095232.GA8990@2ka.mipt.ru> <456EAD6E.6040709@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <456EAD6E.6040709@yahoo.com.au>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 30 Nov 2006 13:22:06 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 09:07:42PM +1100, Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> >Doesn't the provided solution is just a in-kernel variant of the
> >SCHED_FIFO set from userspace? Why kernel should be able to mark some
> >users as having higher priority?
> >What if workload of the system is targeted to not the maximum TCP
> >performance, but maximum other-task performance, which will be broken
> >with provided patch.
> 
> David's line of thinking for a solution sounds better to me. This patch
> does not prevent the process from being preempted (for potentially a long
> time), by any means.

It steals timeslices from other processes to complete tcp_recvmsg()
task, and only when it does it for too long, it will be preempted.
Processing backlog queue on behalf of need_resched() will break fairness
too - processing itself can take a lot of time, so process can be
scheduled away in that part too.

> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com 

-- 
	Evgeniy Polyakov
