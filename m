Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbSJ1Egt>; Sun, 27 Oct 2002 23:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262870AbSJ1Egt>; Sun, 27 Oct 2002 23:36:49 -0500
Received: from dp.samba.org ([66.70.73.150]:14979 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262868AbSJ1Egs>;
	Sun, 27 Oct 2002 23:36:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hugh Dickins <hugh@veritas.com>, mingming cao <cmm@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch 
In-reply-to: Your message of "Sun, 27 Oct 2002 17:35:58 -0800."
             <Pine.LNX.4.44.0210271734450.7252-100000@blue1.dev.mcafeelabs.com> 
Date: Mon, 28 Oct 2002 15:10:10 +1100
Message-Id: <20021028044308.CE3292C0C7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210271734450.7252-100000@blue1.dev.mcafeelabs.com> y
ou write:
> On Mon, 28 Oct 2002, Rusty Russell wrote:
> 
> > +struct ipc_rcu_kmalloc
> > +{
> > +	struct rcu_head rcu;
> > +	/* "void *" makes sure alignment of following data is sane. */
> > +	void *data[0];
> > +};
> 
> Rusty, why not using gcc "aligned" keywords instead of black magic :
> 
> void *data[0];

I think it's clearer *why* it's being done than:

	struct ipc_rcu_kmalloc
	{
		struct rcu_head rcu;
	} __attribute__((aligned(__alignof__(void *))));

And simpler than:

	struct ipc_rcu_kmalloc
	{
		struct rcu_head rcu;
		/* "void *" makes sure alignment of following data is sane. */
		char data[0] __attribute__((aligned(__alignof__(void *))));
	};

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
