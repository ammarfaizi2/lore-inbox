Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWGMJIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWGMJIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWGMJIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:08:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46267 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964816AbWGMJIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:08:13 -0400
Date: Thu, 13 Jul 2006 02:08:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: sekharan@us.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, arjan@infradead.org
Subject: Re: [patch] lockdep: more annotations for mm/slab.c
Message-Id: <20060713020801.44b99061.akpm@osdl.org>
In-Reply-To: <20060713084613.GA7177@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra>
	<20060713071221.GA31349@elte.hu>
	<20060713002803.cd206d91.akpm@osdl.org>
	<20060713072635.GA907@elte.hu>
	<20060713004445.cf7d1d96.akpm@osdl.org>
	<20060713084213.GA6985@elte.hu>
	<20060713084613.GA7177@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 10:46:13 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> the SLAB code can hold multiple slab locks at once,
> for example at:
> 
>  [<c0105dd5>] show_trace+0xd/0x10
>  [<c0105def>] dump_stack+0x17/0x1c
>  [<c014182e>] __lock_acquire+0x7ab/0xa0e
>  [<c0141d6e>] lock_acquire+0x5e/0x80
>  [<c10b0d8e>] _spin_lock_nested+0x26/0x37
>  [<c017178b>] __cache_free+0x30d/0x3d2
>  [<c0171200>] slab_destroy+0xfd/0x11d
>  [<c0171360>] free_block+0x140/0x17d
>  [<c01717dd>] __cache_free+0x35f/0x3d2
>  [<c01718cd>] kfree+0x7d/0x9a
>  [<c0127889>] free_task+0xe/0x24
>  [<c0127ee8>] __put_task_struct+0xc2/0xc7
>  [<c012bc8f>] delayed_put_task_struct+0x1e/0x20
>  [<c0139d94>] __rcu_process_callbacks+0xff/0x15d
>  [<c0139e1a>] rcu_process_callbacks+0x28/0x40
>  [<c012f125>] tasklet_action+0x6e/0xd1
>  [<c012f2c7>] __do_softirq+0x6e/0xec
>  [<c01061b7>] do_softirq+0x61/0xc7
> 
> so add the 'nested' parameter to the affected functions.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  mm/slab.c |   45 +++++++++++++++++++++++++--------------------

geeze, what fuss.  Can't we just tell lockdep "the locking here is correct,
so buzz off"?
