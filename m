Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281174AbRKTRlr>; Tue, 20 Nov 2001 12:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281185AbRKTRlh>; Tue, 20 Nov 2001 12:41:37 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:44551 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S281174AbRKTRlb>;
	Tue, 20 Nov 2001 12:41:31 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111201741.UAA02990@ms2.inr.ac.ru>
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
To: trond.myklebust@fys.uio.no
Date: Tue, 20 Nov 2001 20:41:21 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15353.28112.350734.11894@charged.uio.no> from "Trond Myklebust" at Nov 19, 1 09:38:40 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> You are saying that the it is impossible for sock_alloc_send_skb() to
> fail when using non-blocking writes?

It is possible and normal provided frame is not fragmented.
And this is bug in nfsd if this happens with its frames.


> writes. (Note: by 'simultaneous' I mean that we don't wait for the
> server to reply before firing off the next request)

I do not understand, you have said you wait for write space yet. :-)


> I haven't done anything about this because IMHO it makes more sense to
> have the QDIO driver drop their special spinlock when calling external
> functions such as dev_kfree_skb_any() 

It is pretty normal, if I understand your words correctly.
kfree_skb() is called under various kinds of locks in lots of places.

> rather than to force the RPC layer to use the spin_lock_irqsave().

I see no relation at all. Do it irqsave and nothing will change,
write_space is called only from softirqs.

It is bug in xprt level to grab spinlock which can cause deadlocks
inside write_space. Probably, I misunderstood you.

Alexey
