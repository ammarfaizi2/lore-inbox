Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSKUBNN>; Wed, 20 Nov 2002 20:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSKUBNM>; Wed, 20 Nov 2002 20:13:12 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:3717 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261732AbSKUBNL>; Wed, 20 Nov 2002 20:13:11 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 17:20:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021121012334.GG32715@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0211201719060.974-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Mark Mielke wrote:

> On Thu, Nov 21, 2002 at 12:28:16AM +0000, Jamie Lokier wrote:
> > Davide Libenzi wrote:
> > > typedef union epoll_obj {
> > > 	void *ptr;
> > > 	__uint32_t u32[2];
> > > 	__uint64_t u64;
> > > } epoll_obj_t;
> > > I'm open to suggestions though. The "ptr" enable me to avoid wierd casts
> > > to avoid gcc screaming.
> > That makes more sense to me, because it will be fine to use `ptr' even
> > on 128-bit pointer machines when they arrive, yet preserves the
> > property that 64<->32 bit conversion functions don't need to reformat
> > the buffer when running 32-bit applications on a 64-bit CPU... even if
> > the 32-bit application uses the `ptr' field.
> > Did I just write that? :)
>
> The problem with sizeof(void *) being >= sizeof(__uint64_t) is that the
> data structure is the wrong length. Binary compatibility would not be
> maintained.
>
> Still... I believe that the days of 128-bit pointers are comfortably
> far enough away that it does not cause any concerns at all for me. (I
> suspect the kernel will need quite a few more changes than just this
> to support 128-bit poitners...)

In theory it is possible to pass epoll_create() an extra parameter that
will set the size of the extra data, from 0 up to N. And the kernel will
return this data "as is". It'll become nasty in user space to access data
though.




- Davide


