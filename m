Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbTA1D3n>; Mon, 27 Jan 2003 22:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTA1D3n>; Mon, 27 Jan 2003 22:29:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38661 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S264681AbTA1D3m>;
	Mon, 27 Jan 2003 22:29:42 -0500
Date: Mon, 27 Jan 2003 22:39:03 -0500
From: Christopher Faylor <cgf@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: andersg@0x63.nu, lkernel2003@tuxers.net, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
Message-ID: <20030128033903.GA882@redhat.com>
References: <Pine.LNX.4.44.0301270920150.5267-100000@harappa.oldtrail.reston.va.us> <20030127.101128.104592362.davem@redhat.com> <20030127182856.GE20701@h55p111.delphi.afb.lu.se> <20030127.143625.84825692.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030127.143625.84825692.davem@redhat.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 02:36:25PM -0800, David S. Miller wrote:
>Hey guys, can you all see if this patch makes the problem go away in
>2.5.x?  It is merely a guess, but it is worth enough to experiment.
>
>Alexey, this piece of code was buggy first time it was coded, and it
>may still have some holes. :-)))
>
>--- net/ipv4/tcp_output.c.~1~	Mon Jan 27 14:45:49 2003
>+++ net/ipv4/tcp_output.c	Mon Jan 27 14:46:33 2003
>@@ -889,7 +889,7 @@
> 	if (atomic_read(&sk->wmem_alloc) > min(sk->wmem_queued+(sk->wmem_queued>>2),sk->sndbuf))
> 		return -EAGAIN;
> 
>-	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
>+	if (0 && before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
> 		if (before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))
> 			BUG();

Sorry, but this doesn't do it for me.  I still get a hang.

cgf
