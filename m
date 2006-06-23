Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932936AbWFWI2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbWFWI2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWFWI2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:28:51 -0400
Received: from mail.gmx.de ([213.165.64.21]:59571 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932936AbWFWI2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:28:51 -0400
X-Authenticated: #14349625
Subject: Re: Measuring tools - top and interrupts
From: Mike Galbraith <efault@gmx.de>
To: danial_thom@yahoo.com
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060622233744.99206.qmail@web33314.mail.mud.yahoo.com>
References: <20060622233744.99206.qmail@web33314.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:32:23 +0200
Message-Id: <1151051543.11381.43.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 16:37 -0700, Danial Thom wrote:
> I'm sorry, but you're being an idiot if you think
> that 16K interrupts per second and forwarding 75K
> pps generate no cpu load. Its just that simple.
> It also means that you've never profiled a kernel
> because you don't understand where the loads are
> generated. You've probably been on too many lists
> with too many people who have no idea what
> they're talking about.

(what horrid manners)

Hm.  You may be right about the load average calculation being broken.

Below is a 100 second profile sample of my 3GHz P4 handling 15K
interrupts per second while receiving a flood ping.  My interpretation
is that tools should be showing ~10% cpu load rather than zero.  Am I'm
misinterpreting it?

 97574 total                                      0.0258
 89549 default_idle                             1017.6023
  1734 ioread16                                  36.8936
  1138 ioread8                                   24.7391
   974 rhine_start_tx                             1.3994
   534 __do_softirq                               3.8417
   331 handle_IRQ_event                           3.2772
   223 rhine_interrupt                            0.0739
   222 memset                                     7.9286
   194 nf_iterate                                 1.5520
   140 local_bh_enable                            1.0769
    99 __kmalloc                                  1.0532
    92 net_rx_action                              0.2000
    85 kfree                                      0.9884
    82 skb_release_data                           0.6406
    77 csum_partial_copy_generic                  0.3105
    73 ip_push_pending_frames                     0.0681
    71 __alloc_skb                                0.2898
    69 kmem_cache_free                            1.3529
    66 kmem_cache_alloc                           1.3750
    62 csum_partial                               0.2153
    61 rt_hash_code                               0.4959
    61 ip_append_data                             0.0253
    60 netif_receive_skb                          0.0516
    58 ip_rcv                                     0.0471
    58 ip_local_deliver                           0.0854
    58 eth_type_trans                             0.2489
    55 ip_output                                  0.0957
    52 icmp_reply                                 0.1187


