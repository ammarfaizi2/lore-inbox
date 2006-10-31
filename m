Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423299AbWJaOb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423299AbWJaOb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423375AbWJaOb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:31:27 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:1163 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1423299AbWJaOb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:31:26 -0500
Date: Tue, 31 Oct 2006 17:30:56 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taskstats: fix sub-threads accounting
Message-ID: <20061031143056.GA3114@oleg>
References: <20061030213749.GA3035@oleg> <4546BCE7.6020800@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4546BCE7.6020800@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Shailabh Nagar wrote:
> 
> Oleg Nesterov wrote:
> >
> >Q: We don't send TASKSTATS_TYPE_AGGR_TGID when single-threaded process
> >exits. Is it good? How can the listener figure out that it was actually
> >a process exit, not sub-thread?
> 
> We had a detailed discussion on this on lkml earlier. The overhead of
> sending essentially the same data twice (once as AGGR_TGID and once as
> PID) was deemed too heavy esp. as the taskstats structure size grew.
> Also, single threaded exit is a common case.
> 
> Using process events, its possible for user space to distinguish single
> threaded process exits.

Ok, I see.

The taskstats's code is very clean and understandable, the only thing
I can't get is: why these listeners are per-cpu? It is very easy to add
'int exited_on_this_cpu' to struct taskstats.

Probaly this was done to filter out unneeded events (cpusets) ? In that
case it seems better to add cpumask_t to 'struct listener' but have a
single listener_array list.

Thanks!

Oleg.

