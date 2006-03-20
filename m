Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbWCTWLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbWCTWLp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030566AbWCTWL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:11:29 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35729 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030565AbWCTWLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:11:23 -0500
Date: Tue, 21 Mar 2006 03:39:56 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Jesper Dangaard Brouer <hawk@diku.dk>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, jens.laas@data.slu.se,
       hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
Message-ID: <20060320220956.GA24792@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 10:44:21PM +0100, Jesper Dangaard Brouer wrote:
> 
> Kernel panic report.
> 
> Have experienced some kernel panic's on a production Linux box acting
> as a router for a large number of customers.
> 
> I have tried to track down the problem, and I think I have narrowed it
> a bit down.  My theory is that it is related to the route cache
> (ip_dst_cache) or FIB, which cannot dealloacate route cache slab
> elements (maybe RCU related).  (I have seen my route cache increase to
> around 520k entries using rtstat, before dying).
> 
> I'm using the FIB trie system/algorithm (CONFIG_IP_FIB_TRIE). Think
> that the error might be cause by the "fib_trie" code.  See the syslog,
> output below.
> 
> Below are some kernel panic outputs from the console and some
> interesting errors found in syslog.
> 
> Kernel panic#1
> --------------
> EIP is at _stext+0x3feffd68/0x49
>        c03f7380
> Call Trace:
>  [<c0103cc7>] show_stack+0x80/0x96
>  [<c0103e60>] show_registers+0x161/0x1c5
>  [<c0104057>] die+0x107/0x186
>  [<c0116c5f>] do_page_fault+0x2c6/0x57d
>  [<c0103997>] error_code+0x4f/0x54
>  [<c012fe7b>] __rcu_process_callbacks+0xaa/0xd3
>  [<c012feff>] rcu_process_callbacks+0x5b/0x65
>  [<c0124578>] tasklet_action+0x77/0xc9
>  [<c01241f1>] __do_softirq+0xc1/0xd6
>  [<c0124251>] do_softirq+0x4b/0x4d
>  [<c012433b>] irq_exit+0x47/0x49
>  [<c010533b>] do_IRQ+0x2b/0x3b
>  [<c010383e>] common_interrupt+0x1a/0x20
> Code:  Bad EIP value.
>  <0>Kernel panic - not syncing: Fatal exception in interrupt

Bad eip in processing rcu callback often indicates that the object
that embeds the rcu_head has already been freed. Can you enable
slab debugging and see if this can be detected there in a different
path ?

Thanks
Dipankar

