Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSJ1X25>; Mon, 28 Oct 2002 18:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbSJ1X25>; Mon, 28 Oct 2002 18:28:57 -0500
Received: from dp.samba.org ([66.70.73.150]:3043 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261855AbSJ1X24>;
	Mon, 28 Oct 2002 18:28:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hugh Dickins <hugh@veritas.com>, mingming cao <cmm@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]updated ipc lock patch 
In-reply-to: Your message of "Mon, 28 Oct 2002 09:08:55 -0800."
             <Pine.LNX.4.44.0210280906150.966-100000@blue1.dev.mcafeelabs.com> 
Date: Tue, 29 Oct 2002 09:39:26 +1100
Message-Id: <20021028233518.0F5FF2C0FE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210280906150.966-100000@blue1.dev.mcafeelabs.com> yo
u write:
> On Mon, 28 Oct 2002, Rusty Russell wrote:
> 
> > I think it's clearer *why* it's being done than:
> >
> > 	struct ipc_rcu_kmalloc
> > 	{
> > 		struct rcu_head rcu;
> > 	} __attribute__((aligned(__alignof__(void *))));
> 
> Well, not really Rusty. The above syntax uses documented gcc features
> already used inside the kernel, while the fact that void *data[0];
> enforces alignment it is not ( to my knowledge ) documented anywhere.
> You can also avoid the comment using the aligned syntax ...

A comment is definitely required: you must say *why* you are aligning
the structure (a clearer comment would be better, of course):

	/* We return a pointer after the structure to the unwitting
	   caller: ensure safe alignment. */

The alignment of a structure member of type X is the alignment of type
X: this seems obvious to me.  And "type X data[0];" is the standard
way of representing a variable struct.

Have we picked all the nits yet? 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
