Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTKJEnL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 23:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbTKJEnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 23:43:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:5075 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262868AbTKJEnI (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 23:43:08 -0500
Date: Sun, 9 Nov 2003 20:42:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Burton Windle <bwindle@fint.org>, <Linux-kernel@vger.kernel.org>
Subject: Re: slab corruption in test9 (NFS related?)
In-Reply-To: <shs7k28vo0f.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0311092038340.3002-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Nov 2003, Trond Myklebust wrote:
> 
> Given that d_free() now uses rcu, and hence defers the actual call to
> kmem_cache_free(), might that not suffice to explain why actual
> consequences are rare?

The thing is, since it gets free'd before all users have let go of their 
pointers to it, I'd expect people to now have a pointer to a _totally_ 
stale entry somewhere.

Although I guess in 99% of all cases there just won't be any other users
for the new dentry in particular (it might be different if it was the old
dentry that got dropped too much), and clearly it hasn't been noticed for
the last 20 months.

Even so, I'm a bit surprised. But I obviously applied the patch.

		Linus

