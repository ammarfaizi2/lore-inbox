Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUIHDoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUIHDoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUIHDoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:44:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60372 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269028AbUIHDmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:42:55 -0400
Subject: Re: [CHECKER] 2.6.8.1 deadlock in rpc_queue_lock <<===>> 
	rpc_sched_lock
From: Greg Banks <gnb@melbourne.sgi.com>
To: Dawson Engler <engler@coverity.dreamhost.com>
Cc: linux-kernel@vger.kernel.org, developers@coverity.com
In-Reply-To: <Pine.LNX.4.58.0409071915020.23546@coverity.dreamhost.com>
References: <Pine.LNX.4.58.0409071915020.23546@coverity.dreamhost.com>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1094615460.20243.165.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 08 Sep 2004 13:51:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 12:15, Dawson Engler wrote:
> Hi All,
> 
> below is a possible deadlock in linux-2.6.8.1 found by a static deadlock
> checker I'm writing.  Let me know if it looks valid and/or whether the
> output is too cryptic.  (Note, the error is in debugging code so maybe
> not such a big deal).
> 
>[...]
>              /u2/engler/mc/oses/linux/linux-2.6.8.1/net/sunrpc/sched.c:__rpc_wake_up_task
>                 430: __rpc_wake_up_task(struct rpc_task *task)
>                 431: {
>                 432: 	dprintk("RPC: %4d __rpc_wake_up_task (now %ld inh %d)\n",
>                 433: 					task->tk_pid, jiffies, rpc_inhibit);
>                 434:
>                 435: #ifdef RPC_DEBUG
>                 436: 	if (task->tk_magic != 0xf00baa) {
>                 437: 		printk(KERN_ERR "RPC: attempt to wake up non-existing task!\n");
>                 438: 		rpc_debug = ~0;
> ===>            439: 		rpc_show_tasks();

If this arc ever happens, you have data structure corruption issues
which are far more worrying than a deadlock.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


