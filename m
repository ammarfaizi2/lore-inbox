Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030994AbWKPRRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030994AbWKPRRH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 12:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031116AbWKPRRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 12:17:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1712 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030994AbWKPRRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 12:17:04 -0500
Date: Thu, 16 Nov 2006 18:16:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: -rc6, "DWARF2 unwinder stuck at" ...
Message-ID: <20061116171614.GA4575@elte.hu>
References: <20060928192048.GA17436@elte.hu> <45351782.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45351782.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan,

in 2.6.19-rc6 i'm getting frequent unwinder failures, like:

  [<c0104eb5>] dump_trace+0x69/0x1b0
  [<c0105013>] show_trace_log_lvl+0x17/0x2b
  [<c034e6c4>] __func__.18297+0xf3fd/0x3ccf5
 DWARF2 unwinder stuck at __func__.18297+0xf3fd/0x3ccf5

 Leftover inexact backtrace:

  [<c010534b>] show_trace+0xf/0x11
  [<c0105360>] dump_stack+0x13/0x15
  [<c01419e9>] __lock_acquire+0x6fe/0x98a
  [<c0175956>] cache_alloc_refill+0x8f/0x534
  [<c0141f14>] lock_acquire+0x5b/0x77
  [<f0a32963>] __ip_ct_refresh_acct+0x123/0x15b [ip_conntrack]
  [<f0a32963>] __ip_ct_refresh_acct+0x123/0x15b [ip_conntrack]
  [<f0a34acc>] udp_packet+0x9e/0xaa [ip_conntrack]
  [<f0a33437>] ip_conntrack_in+0x385/0x479 [ip_conntrack]
  [<c01215d8>] try_to_wake_up+0x3ea/0x3f4
  [<c0324300>] netlbl_mgmt_listall_cb+0xc8/0x1bd
  [<c02dfe28>] nf_iterate+0x38/0x6a
  [<c02e4dbf>] ip_rcv_finish+0x0/0x271
  [<c02dfeac>] nf_hook_slow+0x52/0xc9
  [<c02e4dbf>] ip_rcv_finish+0x0/0x271
  [<c02e564f>] ip_rcv+0x1fc/0x491
  [<c02e4dbf>] ip_rcv_finish+0x0/0x271
  [<c02c1f2a>] sock_queue_rcv_skb+0xd5/0xdc
  [<c02e5453>] ip_rcv+0x0/0x491
  [<c02cac42>] netif_receive_skb+0x339/0x366
  [<c02cad04>] process_backlog+0x95/0xed
  [<c02c909e>] net_rx_action+0xad/0x1da
  [<c012bfdc>] ksoftirqd+0x107/0x1e0
  [<c012bed5>] ksoftirqd+0x0/0x1e0
  [<c0139520>] kthread+0xbf/0xeb
  [<c0139461>] kthread+0x0/0xeb
  [<c0104c23>] kernel_thread_helper+0x7/0x10
  =======================

it's quite an annoyance, i rarely see the unwinder getting a stackdump 
right, without 'falling back' to the inexact backtrace ...

	Ingo
