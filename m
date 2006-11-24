Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933061AbWKXUET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbWKXUET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933065AbWKXUET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:04:19 -0500
Received: from brick.kernel.dk ([62.242.22.158]:19564 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S933061AbWKXUES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:04:18 -0500
Date: Fri, 24 Nov 2006 21:04:19 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061124200419.GG5400@kernel.dk>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg> <20061124182153.GA9868@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124182153.GA9868@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24 2006, Oleg Nesterov wrote:
> Ok, synchronize_xxx() passed 1 hour rcutorture test on dual P-III.
> 
> It behaves the same as srcu but optimized for writers. The fast path
> for synchronize_xxx() is mutex_lock() + atomic_read() + mutex_unlock().
> The slow path is __wait_event(), no polling. However, the reader does
> atomic inc/dec on lock/unlock, and the counters are not per-cpu.
> 
> Jens, is it ok for you? Alan, Paul, what is your opinion?

This looks good from my end, much more appropriate than the current SRCU
code. Even if I could avoid synchronize_srcu() for most cases, when I
did have to issue it, the 3x synchronize_sched() was a performance
killer.

Thanks Oleg! And Alan and Paul for your excellent ideas.

-- 
Jens Axboe

