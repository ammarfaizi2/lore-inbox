Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267015AbSKSRA2>; Tue, 19 Nov 2002 12:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSKSRA2>; Tue, 19 Nov 2002 12:00:28 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:52099 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S267015AbSKSRAZ>; Tue, 19 Nov 2002 12:00:25 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 19 Nov 2002 09:07:56 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Edgar Toernig <froese@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021119060941.GB17927@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0211190904260.1918-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Mark Mielke wrote:

> On Tue, Nov 19, 2002 at 06:35:46AM +0100, Edgar Toernig wrote:
> > Davide Libenzi wrote:
> > > > What happens if the epollfd is put into its own fd set?
> > > You might find your machine a little bit frozen :)
> > > Either 1) I remove the read lock from poll() or 2) I check the condition
> > > at insetion time to avoid it. I very much prefer 2)
> > Hehe, sure.  But could become tricky: someone may build a circular chain
> > of epoll-fd-sets.
>
> This could be an indication that epoll of an epoll fd should not be
> allowed.  This kind of sucks as epoll event hierarchies appear, at
> least on the surface, very natural, and better than poll()/epoll.
>
> Another option would be to allow a reasonable depth (2? 3?). The extra
> checking (depth calculation) only needs to be performed if a file is
> added or removed where f_op == epoll_f_op.

I will not enable epoll fds to be stored inside another epoll fd. With
limited numbers of fds poll scales good, and if you need to create a
priority hierarchy, you can use a small poll set of epoll fds. This is a
very corner case and I'm not willing to screw up the to to handle
something that made 0.1% of users are going to do. It _can_ be done in
other ways.



- Davide


