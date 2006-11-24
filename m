Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935042AbWKXUr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935042AbWKXUr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935056AbWKXUr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:47:58 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:43201 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S935042AbWKXUr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:47:58 -0500
Date: Fri, 24 Nov 2006 15:47:56 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061124182153.GA9868@oleg>
Message-ID: <Pine.LNX.4.44L0.0611241545400.16422-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006, Oleg Nesterov wrote:

> Ok, synchronize_xxx() passed 1 hour rcutorture test on dual P-III.
> 
> It behaves the same as srcu but optimized for writers. The fast path
> for synchronize_xxx() is mutex_lock() + atomic_read() + mutex_unlock().
> The slow path is __wait_event(), no polling. However, the reader does
> atomic inc/dec on lock/unlock, and the counters are not per-cpu.
> 
> Jens, is it ok for you? Alan, Paul, what is your opinion?

Given that you aren't using per-cpu data, why not just rely on a spinlock?  
Then everything will be simple and easy to verify, with no need to worry 
about atomic instructions or memory barriers.

Alan

