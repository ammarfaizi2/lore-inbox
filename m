Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755317AbWKRSr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbWKRSr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 13:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbWKRSr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 13:47:26 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:51343 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1755317AbWKRSrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 13:47:25 -0500
Date: Sat, 18 Nov 2006 21:46:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Alan Stern <stern@rowland.harvard.edu>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061118184624.GA163@oleg>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061117183945.GA367@oleg> <20061118002845.GF2632@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118002845.GF2632@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17, Paul E. McKenney wrote:
>
> Oleg, any thoughts about Jens's optimization?  He would code something
> like:
> 
> 	if (srcu_readers_active(&my_srcu))
> 		synchronize_srcu();
> 	else
> 		smp_mb();

Well, this is clearly racy, no? I am not sure, but may be we can do

	smp_mb();
	if (srcu_readers_active(&my_srcu))
		synchronize_srcu();

in this case we also need to add 'smp_mb()' into srcu_read_lock() after
'atomic_inc(&sp->hardluckref)'.

> However, he is doing ordered I/O requests rather than protecting data
> structures.

Probably this makes a difference, but I don't understand this.

Oleg.

