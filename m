Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269416AbUICRD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269416AbUICRD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269466AbUICRD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:03:28 -0400
Received: from mail4.utc.com ([192.249.46.193]:21917 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S269416AbUICRDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:03:18 -0400
Message-ID: <4138A397.3060103@cybsft.com>
Date: Fri, 03 Sep 2004 12:02:15 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu>
In-Reply-To: <20040902215728.GA28571@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -R0 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R0
>  
> ontop of:
> 
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> 
> i've given up on the netdev_backlog_granularity approach, and as a
> replacement i've modified specific network drivers to return at a safe
> point if softirq preemption is requested. This gives the same end result
> but is more robust. For the time being i've fixed 8193too.c and e100.c.
> (will fix up other drivers too as latencies get reported)
> 
> this should fix the crash reported by P.O. Gaillard, and it should solve
> the packet delay/loss issues reported by Mark H Johnson. I cannot see
> any problems on my rtl8193 testbox anymore.
> 
> 	Ingo
> 

OK. I previously reported about the system hanging trying to boot this 
patch. It may have been a fluke. In any event, it doesn't hang 
consistently. I have rebooted several times now without problems. I do 
however still get some of these:

(ksoftirqd/0/2): new 131 us maximum-latency critical section.
  => started at: <netif_receive_skb+0x82/0x280>
  => ended at:   <netif_receive_skb+0x1d7/0x280>
  [<c0136789>] check_preempt_timing+0x119/0x1f0
  [<c0255017>] netif_receive_skb+0x1d7/0x280
  [<c0255017>] netif_receive_skb+0x1d7/0x280
  [<c013699d>] sub_preempt_count+0x4d/0x70
  [<c013699d>] sub_preempt_count+0x4d/0x70
  [<c0255017>] netif_receive_skb+0x1d7/0x280
  [<d08d40b7>] e100_poll+0x5b7/0x630 [e100]
  [<c013699d>] sub_preempt_count+0x4d/0x70
  [<c025527f>] net_rx_action+0x7f/0x110
  [<c011eb55>] ___do_softirq+0x75/0x90
  [<c011ec1e>] _do_softirq+0xe/0x20
  [<c011f034>] ksoftirqd+0x94/0xe0
  [<c012f8aa>] kthread+0xaa/0xb0
  [<c011efa0>] ksoftirqd+0x0/0xe0
  [<c012f800>] kthread+0x0/0xb0
  [<c0104575>] kernel_thread_helper+0x5/0x10


