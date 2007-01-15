Return-Path: <linux-kernel-owner+w=401wt.eu-S932123AbXAOX6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbXAOX6S (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 18:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbXAOX6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 18:58:18 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:48216 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932123AbXAOX6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 18:58:18 -0500
X-Greylist: delayed 4200 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 18:58:17 EST
Date: Tue, 16 Jan 2007 00:48:01 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I broke my port numbers :(
Message-ID: <20070115224801.GB3771@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20070115215515.GA3771@m.safari.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115215515.GA3771@m.safari.iki.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 23:55:15 +0200, Sami Farin wrote:
> I know this may be entirely my fault but I have tried reversing
> all of my _own_ patches I applied to 2.6.19.2 but can't find what broke this.
> I did three times "netcat 127.0.0.69 42", notice the different
> port numbers.

Hmm...  when I do "rmmod iptable_nat ip_nat", it works.

# iptables -t nat --list -nvx
Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
    pkts      bytes target     prot opt in     out     source               destination         

Chain POSTROUTING (policy ACCEPT 0 packets, 0 bytes)
    pkts      bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
    pkts      bytes target     prot opt in     out     source               destination         
I didn't know functions in ip_nat_proto_tcp.o were called
when I have empty nat table.  Oops...

without iptable_nat ip_nat:
64 bytes from 127.0.0.1: icmp_seq=3 ttl=61 time=0.053 ms

with them:
64 bytes from 127.0.0.1: icmp_seq=3 ttl=61 time=0.065 ms

*shrug* live and learn.

2007-01-16 00:44:43.616266500 <4>[ 5672.924459]  [<c0103cff>] dump_trace+0x215/0x21a
2007-01-16 00:44:43.616267500 <4>[ 5672.924492]  [<c0103da7>] show_trace_log_lvl+0x1a/0x30
2007-01-16 00:44:43.616269500 <4>[ 5672.924511]  [<c0103dcf>] show_trace+0x12/0x14
2007-01-16 00:44:43.616270500 <4>[ 5672.924529]  [<c0103ecc>] dump_stack+0x19/0x1b
2007-01-16 00:44:43.616271500 <4>[ 5672.924547]  [<f8c3756f>] tcp_unique_tuple+0xd7/0x130 [ip_nat]
2007-01-16 00:44:43.616272500 <4>[ 5672.924585]  [<f8c363db>] get_unique_tuple+0x5a/0x6e [ip_nat]
2007-01-16 00:44:43.616285500 <4>[ 5672.924593]  [<f8c36462>] ip_nat_setup_info+0x73/0x1e6 [ip_nat]
2007-01-16 00:44:43.616287500 <4>[ 5672.924601]  [<f8c3b378>] ip_nat_rule_find+0x90/0xb0 [iptable_nat]
2007-01-16 00:44:43.616288500 <4>[ 5672.924610]  [<f8c3b53a>] ip_nat_fn+0xd5/0x1ac [iptable_nat]
2007-01-16 00:44:43.616289500 <4>[ 5672.924617]  [<f8c3b706>] ip_nat_out+0x56/0xd3 [iptable_nat]
2007-01-16 00:44:43.616290500 <4>[ 5672.924624]  [<c0443dc1>] nf_iterate+0x4b/0x77
2007-01-16 00:44:43.616295500 <4>[ 5672.925610]  [<c0443e45>] nf_hook_slow+0x58/0xdf
2007-01-16 00:44:43.617058500 <4>[ 5672.926562]  [<c0451065>] ip_output+0x187/0x26a
2007-01-16 00:44:43.618005500 <4>[ 5672.927511]  [<c0451611>] ip_queue_xmit+0x4c9/0x5a4
2007-01-16 00:44:43.618955500 <4>[ 5672.928461]  [<c04628f8>] tcp_transmit_skb+0x25b/0x466
2007-01-16 00:44:43.619911500 <4>[ 5672.929417]  [<c04656ee>] tcp_connect+0x133/0x1d1
2007-01-16 00:44:43.620865500 <4>[ 5672.930371]  [<c0467343>] tcp_v4_connect+0x404/0x750
2007-01-16 00:44:43.621821500 <4>[ 5672.931327]  [<c0474be0>] inet_stream_connect+0x123/0x1b1
2007-01-16 00:44:43.622789500 <4>[ 5672.932295]  [<c04235ed>] sys_connect+0x9c/0xbe
2007-01-16 00:44:43.623679500 <4>[ 5672.933185]  [<c04240ae>] sys_socketcall+0xd2/0x272
2007-01-16 00:44:43.624612500 <4>[ 5672.934072]  [<c0102e77>] syscall_call+0x7/0xb
2007-01-16 00:44:43.624614500 <4>[ 5672.934092]  [<00645410>] 0x645410
2007-01-16 00:44:43.624615500 <4>[ 5672.934116]  =======================

-- 
