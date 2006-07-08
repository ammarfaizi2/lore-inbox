Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWGHDHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWGHDHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 23:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWGHDHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 23:07:17 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:29195 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932495AbWGHDHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 23:07:16 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: arjan@infradead.org (Arjan van de Ven)
Subject: Re: auro deadlock  (was Re: e100 lockdep irq lock inversion.)
Cc: davej@redhat.com, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <1152295989.3111.116.camel@laptopd505.fenrus.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1Fz39n-0007tC-00@gondolin.me.apana.org.au>
Date: Sat, 08 Jul 2006 13:06:59 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
> 
> Act 1
> 
> Enter the mpi_start_xmit() function, which is airo's xmit function.
> This function takes the aux_lock first, with irq's off, then calls
> skb_queue_tail(). skb_queue_tail takes the sk_receive_queue.lock (with
> irqsave as well).

Nope, make that ai->txq.

> Act 2
> 
> Enter the ipcalc program. This program calls an ioctl, which ends up
> calling udp_ioctl. udp_ioctl does
>   spin_lock_bh(&sk->sk_receive_queue.lock);

Different queue.

So no deadlock.  Better luck next time :)
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
