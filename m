Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSJYHWJ>; Fri, 25 Oct 2002 03:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbSJYHWJ>; Fri, 25 Oct 2002 03:22:09 -0400
Received: from dp.samba.org ([66.70.73.150]:29575 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261296AbSJYHWI>;
	Fri, 25 Oct 2002 03:22:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: cmm@us.ibm.com
Subject: Re: [PATCH]updated ipc lock patch 
Cc: Andrew Morton <akpm@digeo.com>, hugh@veritas.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
In-reply-to: Your message of "Thu, 24 Oct 2002 22:53:54 MST."
             <3DB8DC72.6A08C74F@us.ibm.com> 
Date: Fri, 25 Oct 2002 17:27:37 +1000
Message-Id: <20021025072822.8CD812C09E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DB8DC72.6A08C74F@us.ibm.com> you write:
> > This is unacceptable crap, sorry.  You *must* allocate the resources
> > required to free the object *at the time you allocate the object*,
> > since freeing must not fail.
> > 
> > > Even better: is it possible to embed the rcu_ipc_free inside the
> > > object-to-be-freed?  Perhaps not?
> > 
> > Yes, this must be done.
> > 
> I thought about embed rcu_ipc_free inside the ipc_ids structure before. 
> But there could be a problem if grow_ary() is called again before the
> old array associated with the previous grow_ary() has not scheduled to
> be freed yet.  I see a need to do that now, as you made very good point.
> I will make the changes tomorrow.

You don't need to allocate it in the object, but you *do* need to fail
grow_ary() if you can't allocate it.

I had the same dilemma when I tried to write a generic "kfree_rcu(void
*)" last year: you simply can't do it 8(

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
