Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSKTXto>; Wed, 20 Nov 2002 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSKTXto>; Wed, 20 Nov 2002 18:49:44 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:42116 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262387AbSKTXtn>; Wed, 20 Nov 2002 18:49:43 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 15:57:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021120235135.GA32715@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0211201546250.974-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Mark Mielke wrote:

> On Wed, Nov 20, 2002 at 03:19:30PM -0800, Davide Libenzi wrote:
> > On Wed, 20 Nov 2002, Mark Mielke wrote:
> > > >     struct epoll_event {
> > > >         unsigned short events;
> > > >         unsigned short revents;
> > > >         __uint64_t obj;
> > > >     };
> > > Forget any argument I had against removing 'fd'. This sounds good.
> > > Perhaps 'obj' should be named 'userdata'?
> > >      struct epoll_event {
> > >          unsigned short   events;
> > >          unsigned short   revents;
> > >          __uint64_t       userdata;
> > >      };
> > Do we want to have a union instead of a direct 64bit int ?
>
> I was going to suggest this, except I couldn't figure out what to
> suggest that it look like... I finally figured that the value could be
> cast, or wrapped in a union by userspace (although theoretically, this
> might mean more words than absolutely necessary to initialize on a
> 32-bit CPU...)
>
> What were you thinking? 1X64 bit or 2X32 bit?

Something like :

typedef union epoll_obj {
	void *ptr;
	__uint32_t u32[2];
	__uint64_t u64;
} epoll_obj_t;

I'm open to suggestions though. The "ptr" enable me to avoid wierd casts
to avoid gcc screaming.




- Davide



