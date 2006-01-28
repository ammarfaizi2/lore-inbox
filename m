Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWA1Pnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWA1Pnh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 10:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWA1Pnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 10:43:37 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:8162 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751446AbWA1Pnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 10:43:37 -0500
Date: Sat, 28 Jan 2006 16:44:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060128154409.GA18701@elte.hu>
References: <20060127001807.GA17179@elte.hu> <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128152204.GA13940@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

>  to a softirq-unsafe lock:
>   (&newsk->sk_dst_lock){+-}, at: [<c048f385>] inet6_destroy_sock+0x25/0x100
>  ... which became softirq-unsafe at:
>  ... [<00000000>] 0x0

fyi, here is where sk_dst_lock became softirq-unsafe:

marked lock as {softirq-on}:
 (&sk->sk_dst_lock){--}, at: [<c04b45d3>] ip6_datagram_connect+0x3b3/0x520
softirq was enabled at: c0497738
hardirq was enabled at: c0102e27
 (&sk->sk_dst_lock){--}, at: [<c04b45d3>] ip6_datagram_connect+0x3b3/0x520
 [<c010432d>] show_trace+0xd/0x10
 [<c0104347>] dump_stack+0x17/0x20
 [<c0139243>] mark_lock+0x173/0x3a0
 [<c01399a5>] debug_lock_chain+0x535/0x1090
 [<c013a53d>] debug_lock_chain_spin+0x3d/0x60
 [<c0268542>] _raw_write_lock+0x32/0x1a0
 [<c04d48c8>] _write_lock+0x8/0x10
 [<c04b45d3>] ip6_datagram_connect+0x3b3/0x520
 [<c04805c7>] inet_dgram_connect+0x37/0x80
 [<c0436f0a>] sys_connect+0x5a/0x80
 [<c0437414>] sys_socketcall+0x94/0x260
 [<c0102df7>] sysenter_past_esp+0x54/0x8d

	Ingo
