Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbSJ1Qxj>; Mon, 28 Oct 2002 11:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbSJ1Qxj>; Mon, 28 Oct 2002 11:53:39 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:12416 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261366AbSJ1Qxi>; Mon, 28 Oct 2002 11:53:38 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 09:08:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Hugh Dickins <hugh@veritas.com>, mingming cao <cmm@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]updated ipc lock patch 
In-Reply-To: <20021028044308.CE3292C0C7@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210280906150.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0210271734450.7252-100000@blue1.dev.mcafeelabs.com> y
> ou write:
> > On Mon, 28 Oct 2002, Rusty Russell wrote:
> >
> > > +struct ipc_rcu_kmalloc
> > > +{
> > > +	struct rcu_head rcu;
> > > +	/* "void *" makes sure alignment of following data is sane. */
> > > +	void *data[0];
> > > +};
> >
> > Rusty, why not using gcc "aligned" keywords instead of black magic :
> >
> > void *data[0];
>
> I think it's clearer *why* it's being done than:
>
> 	struct ipc_rcu_kmalloc
> 	{
> 		struct rcu_head rcu;
> 	} __attribute__((aligned(__alignof__(void *))));

Well, not really Rusty. The above syntax uses documented gcc features
already used inside the kernel, while the fact that void *data[0];
enforces alignment it is not ( to my knowledge ) documented anywhere.
You can also avoid the comment using the aligned syntax ...



- Davide


