Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSJ1XgX>; Mon, 28 Oct 2002 18:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSJ1XgX>; Mon, 28 Oct 2002 18:36:23 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:23448 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261238AbSJ1XgW>; Mon, 28 Oct 2002 18:36:22 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 15:52:07 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Hugh Dickins <hugh@veritas.com>, mingming cao <cmm@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]updated ipc lock patch 
In-Reply-To: <20021028233518.0F5FF2C0FE@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210281546530.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0210280906150.966-100000@blue1.dev.mcafeelabs.com> yo
> u write:
> > On Mon, 28 Oct 2002, Rusty Russell wrote:
> >
> > > I think it's clearer *why* it's being done than:
> > >
> > > 	struct ipc_rcu_kmalloc
> > > 	{
> > > 		struct rcu_head rcu;
> > > 	} __attribute__((aligned(__alignof__(void *))));
> >
> > Well, not really Rusty. The above syntax uses documented gcc features
> > already used inside the kernel, while the fact that void *data[0];
> > enforces alignment it is not ( to my knowledge ) documented anywhere.
> > You can also avoid the comment using the aligned syntax ...
>
> A comment is definitely required: you must say *why* you are aligning
> the structure (a clearer comment would be better, of course):
>
> 	/* We return a pointer after the structure to the unwitting
> 	   caller: ensure safe alignment. */
>
> The alignment of a structure member of type X is the alignment of type
> X: this seems obvious to me.  And "type X data[0];" is the standard
> way of representing a variable struct.
>
> Have we picked all the nits yet? 8)

Rusty, I give you two reason why you should be using the gcc documented
"aligned" features :)

1) using "void *data[0];" and expecting an alignement, being undocumented,
	will force not obvious constraints for the gcc folks

2) I was looking at my latest copy of the ISO standard, section :
	6.7.5.2 "Array declarators" - Point 1)
	where it is explicitly declared that the constant expression that
	declared the size of the array must be greater then zero

Looking at how gcc folks is driving towards standards I will expect them
screaming at you in a near future :)



- Davide


