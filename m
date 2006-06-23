Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932991AbWFWKLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932991AbWFWKLK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932992AbWFWKLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:11:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45494 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932991AbWFWKLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:11:07 -0400
Date: Fri, 23 Jun 2006 12:06:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 51/61] lock validator: special locking: sock_lock_init()
Message-ID: <20060623100608.GJ4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212714.GY3155@elte.hu> <20060529183604.324ee331.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183604.324ee331.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > +/*
> > + * Each address family might have different locking rules, so we have
> > + * one slock key per address family:
> > + */
> > +static struct lockdep_type_key af_family_keys[AF_MAX];
> > +
> > +static void noinline sock_lock_init(struct sock *sk)
> > +{
> > +	spin_lock_init_key(&sk->sk_lock.slock, af_family_keys + sk->sk_family);
> > +	sk->sk_lock.owner = NULL;
> > +	init_waitqueue_head(&sk->sk_lock.wq);
> > +}
> 
> OK, no code outside net/core/sock.c uses sock_lock_init().

yeah.

> Hopefully the same is true of out-of-tree code...

it wont go unnoticed even if it does: we'll get a nonfatal lockdep 
message and fix it up. I dont expect out-of-tree code to mess with 
sk_lock.slock though ...

	Ingo
