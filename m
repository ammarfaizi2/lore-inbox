Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWKRVZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWKRVZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 16:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbWKRVZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 16:25:51 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:28371 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751452AbWKRVZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 16:25:50 -0500
Date: Sun, 19 Nov 2006 00:25:42 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061118212542.GA235@oleg>
References: <20061118171410.GB4427@us.ibm.com> <Pine.LNX.4.44L0.0611181536050.15971-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611181536050.15971-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18, Alan Stern wrote:
>
> By the way, I think the fastpath for synchronize_srcu() should be safe, 
> now that you have added the memory barriers into srcu_read_lock() and 
> srcu_read_unlock().  You might as well try putting it in.

I still think the fastpath should do mb() unconditionally to be correct.

> Although now that I look at it again, you have forgotten to put smp_mb()
> after the atomic_inc() call and before the atomic_dec().

As I see it, currently we don't need this barrier because synchronize_srcu()
does synchronize_sched() before reading ->hardluckref.

But if we add the fastpath into synchronize_srcu() then yes, we need mb()
after atomic_inc().

Unless I totally confused :)

Oleg.

