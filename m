Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274205AbSITA5U>; Thu, 19 Sep 2002 20:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274305AbSITA4I>; Thu, 19 Sep 2002 20:56:08 -0400
Received: from ns.suse.de ([213.95.15.193]:57864 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S274205AbSITAzh>;
	Thu, 19 Sep 2002 20:55:37 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
References: <3D89176B.40FFD09B@digeo.com.suse.lists.linux.kernel> <20020919.221513.28808421.taka@valinux.co.jp.suse.lists.linux.kernel> <3D8A36A5.846D806@digeo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Sep 2002 03:00:40 +0200
In-Reply-To: Andrew Morton's message of "19 Sep 2002 22:46:12 +0200"
Message-ID: <p73lm5xtqyv.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Hirokazu Takahashi wrote:
> > 
> > ...
> > > It needs redoing.  These differences are really big, and this
> > > is the kernel's most expensive function.
> > >
> > > A little project for someone.
> > 
> > OK, if there is nobody who wants to do it I'll do it by myself.
> 
> That would be fantastic - thanks.  This is more a measurement
> and testing exercise than a coding one.  And if those measurements
> are sufficiently nice (eg: >5%) then a 2.4 backport should be done.

Very interesting IMHO would be to find a heuristic to switch between
a write combining copy and a cache hot copy. Write combining is good 
for blasting huge amounts of data quickly without killing your caches.
Cache hot is good for everything else.

But it'll need hints from the higher level code. e.g. read and write
could turn on write combining for bigger writes (let's say >8K) 
I discovered that just unconditionally turning it on for all copies 
is not good because it forces data out of cache. But I still have hope
that it helps for selected copies.


-Andi
