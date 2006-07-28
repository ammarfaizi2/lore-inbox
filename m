Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWG1Tpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWG1Tpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWG1Tpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:45:30 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:51218 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1030286AbWG1Tp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:45:29 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=pvA/VpX64uXiFb9xa7DDYNzTAr4kM9mEaj40cwvAB+c6uwllBE7ZbjfYl4620o4Zey2HLz7Q7H7iyds7RNVVuLf1E3cV1JjJXQhtMBxTtm+rM1pgKdRqasOSNmNd5at8;
X-IronPort-AV: i="4.07,193,1151902800"; 
   d="scan'208"; a="52463183:sNHT27231615"
Date: Fri, 28 Jul 2006 14:45:31 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: lockdep tcp_v6_rcv message
Message-ID: <20060728194531.GA17744@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Triggered on Fedora rawhide kernel-2.6.17-1.2462.fc6 x86_64 which is
based on 2.6.18rc2-git6.  IPv6 was in use at the time.


=================================
[ INFO: inconsistent lock state ]
---------------------------------
inconsistent {softirq-on-W} -> {in-softirq-R} usage.
swapper/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
 (&sk->sk_dst_lock){---?}, at: [<ffffffff80418ef3>]
 sk_dst_check+0x26/0x12b
{softirq-on-W} state was registered at:
  [<ffffffff802a874d>] lock_acquire+0x4a/0x69
  [<ffffffff802672a1>] _write_lock+0x24/0x31
  [<ffffffff8044a26b>] ip4_datagram_connect+0x2e1/0x350
  [<ffffffff80451214>] inet_dgram_connect+0x57/0x65
  [<ffffffff8041652a>] sys_connect+0x7d/0xa4
  [<ffffffff8025ff0d>] system_call+0x7d/0x83
irq event stamp: 3507830
hardirqs last  enabled at (3507830): [<ffffffff8020aaa8>]
kmem_cache_alloc+0xd3/0xf7
hardirqs last disabled at (3507829): [<ffffffff8020aa20>]
kmem_cache_alloc+0x4b/0xf7
softirqs last  enabled at (3507808): [<ffffffff80212a9d>]
__do_softirq+0xec/0xf5
softirqs last disabled at (3507811): [<ffffffff802611ba>]
call_softirq+0x1e/0x28

other info that might help us debug this:
1 lock held by swapper/0:
 #0:  (slock-AF_INET6){-+..}, at: [<ffffffff883dc3d6>]
 tcp_v6_rcv+0x30e/0x770 [ipv6]

stack backtrace:

Call Trace:
 [<ffffffff8026e269>] show_trace+0xaa/0x23d
 [<ffffffff8026e411>] dump_stack+0x15/0x17
 [<ffffffff802a67bd>] print_usage_bug+0x259/0x26a
 [<ffffffff802a6fc2>] mark_lock+0x1d5/0x3e3
 [<ffffffff802a7b80>] __lock_acquire+0x427/0xa54
 [<ffffffff802a874e>] lock_acquire+0x4b/0x69
 [<ffffffff802673b8>] _read_lock+0x28/0x34
 [<ffffffff80418ef3>] sk_dst_check+0x26/0x12b
 [<ffffffff883bd9be>] :ipv6:ip6_dst_lookup+0x3a/0x1a2
 [<ffffffff883d9dcf>] :ipv6:tcp_v6_send_synack+0x185/0x2ec
 [<ffffffff883dac02>] :ipv6:tcp_v6_conn_request+0x291/0x2f3
 [<ffffffff80243ce6>] tcp_rcv_state_process+0x5f/0xe7b
 [<ffffffff883da1bd>] :ipv6:tcp_v6_do_rcv+0x268/0x372
 [<ffffffff883dc7e7>] :ipv6:tcp_v6_rcv+0x71f/0x770
 [<ffffffff883bf4ef>] :ipv6:ip6_input+0x223/0x315
 [<ffffffff883bfb9d>] :ipv6:ipv6_rcv+0x254/0x2af
 [<ffffffff8022154d>] netif_receive_skb+0x260/0x2dd
 [<ffffffff881163ef>] :e1000:e1000_clean_rx_irq+0x423/0x4c2
 [<ffffffff881148c9>] :e1000:e1000_clean+0x88/0x15b
 [<ffffffff8020cc82>] net_rx_action+0xac/0x1c7
 [<ffffffff80212a19>] __do_softirq+0x68/0xf5
 [<ffffffff802611ba>] call_softirq+0x1e/0x28


Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
