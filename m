Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758802AbWK2Ihv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758802AbWK2Ihv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758800AbWK2Ihv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:37:51 -0500
Received: from poczta.o2.pl ([193.17.41.142]:57575 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1758798AbWK2Ihu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:37:50 -0500
Date: Wed, 29 Nov 2006 09:44:28 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu, gandalf@wlug.westbo.se
Subject: Re: [PATCH] lockdep: fix sk->sk_callback_lock locking
Message-ID: <20061129084428.GC1001@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
	mingo@elte.hu, gandalf@wlug.westbo.se
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GpKC4-0005Vc-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-2006 08:49, Herbert Xu wrote:
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>> =========================================================
>> [ INFO: possible irq lock inversion dependency detected ]
>> 2.6.19-rc6 #4
>> ---------------------------------------------------------
>> nc/1854 just changed the state of lock:
>> (af_callback_keys + sk->sk_family#2){-.-?}, at: [<c0268a7f>] sock_def_error_report+0x1f/0x90
>> but this lock was taken by another, soft-irq-safe lock in the past:
>> (slock-AF_INET){-+..}
>>
>> and interrupts could create inverse lock ordering between them.
> 
> I think this is bogus.  The slock is not a standard lock.  When we
> hold it in process context we don't actually hold the spin lock part
> of it.  However, it does prevent the softirq path from running in
> critical sections which also prevents any attempt to grab the
> callback lock from softirq context.
> 
> If you still think there is a problem, please show an actual scenario
> where it dead locks.

It would be nice to have a look at other parts of stack
backtraces probably with softirq part, which took that
lock: sk->sk_family#2){-.-?}

Jarek P. 
