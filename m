Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274593AbSITBGd>; Thu, 19 Sep 2002 21:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274595AbSITBFP>; Thu, 19 Sep 2002 21:05:15 -0400
Received: from packet.digeo.com ([12.110.80.53]:49067 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S274594AbSITBEm>;
	Thu, 19 Sep 2002 21:04:42 -0400
Message-ID: <3D8A754E.5BA2E28D@digeo.com>
Date: Thu, 19 Sep 2002 18:09:34 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Hirokazu Takahashi <taka@valinux.co.jp>, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
References: <3D89176B.40FFD09B@digeo.com.suse.lists.linux.kernel> <20020919.221513.28808421.taka@valinux.co.jp.suse.lists.linux.kernel> <3D8A36A5.846D806@digeo.com.suse.lists.linux.kernel> <p73lm5xtqyv.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 01:09:37.0773 (UTC) FILETIME=[63C491D0:01C26042]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Andrew Morton <akpm@digeo.com> writes:
> 
> > Hirokazu Takahashi wrote:
> > >
> > > ...
> > > > It needs redoing.  These differences are really big, and this
> > > > is the kernel's most expensive function.
> > > >
> > > > A little project for someone.
> > >
> > > OK, if there is nobody who wants to do it I'll do it by myself.
> >
> > That would be fantastic - thanks.  This is more a measurement
> > and testing exercise than a coding one.  And if those measurements
> > are sufficiently nice (eg: >5%) then a 2.4 backport should be done.
> 
> Very interesting IMHO would be to find a heuristic to switch between
> a write combining copy and a cache hot copy. Write combining is good
> for blasting huge amounts of data quickly without killing your caches.
> Cache hot is good for everything else.

I expect that caching userspace and not pagecache would be
a reasonable choice.

> But it'll need hints from the higher level code. e.g. read and write
> could turn on write combining for bigger writes (let's say >8K)
> I discovered that just unconditionally turning it on for all copies
> is not good because it forces data out of cache. But I still have hope
> that it helps for selected copies.

Well if it's a really big read then bypassing the CPU cache on
the userspace-side buffer would make sense.

Can you control the cachability of the memory reads as well?

What restrictions are there on these instructions?  Would
they force us to bear the cost of the aligment problem?
