Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWHWQKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWHWQKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 12:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWHWQKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 12:10:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56761 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965020AbWHWQKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 12:10:40 -0400
Date: Wed, 23 Aug 2006 09:09:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jari Sundell <sundell.software@gmail.com>,
       David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-Id: <20060823090920.18e4d1da.akpm@osdl.org>
In-Reply-To: <20060823075056.GA18029@2ka.mipt.ru>
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
	<20060822231129.GA18296@ms2.inr.ac.ru>
	<b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com>
	<20060822.173200.126578369.davem@davemloft.net>
	<b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com>
	<20060823065659.GC24787@2ka.mipt.ru>
	<20060823000758.5ebed7dd.akpm@osdl.org>
	<20060823075056.GA18029@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 11:50:56 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> On Wed, Aug 23, 2006 at 12:07:58AM -0700, Andrew Morton (akpm@osdl.org) wrote:
> > On Wed, 23 Aug 2006 10:56:59 +0400
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > 
> > > On Wed, Aug 23, 2006 at 02:43:50AM +0200, Jari Sundell (sundell.software@gmail.com) wrote:
> > > > Actually, I didn't miss that, it is an orthogonal issue. A timespec
> > > > timeout parameter for the syscall does not imply the use of timespec
> > > > in any timer event, etc. Nor is there any timespec timer in kqueue's
> > > > struct kevent, which is the only (interface related) thing that will
> > > > be exposed.
> > > 
> > > void * in structure exported to userspace is forbidden.
> > > long in syscall requires wrapper in per-arch code (although that
> > > workaround _is_ there, it does not mean that broken interface should 
> > > be used).
> > > poll uses millisecods - it is perfectly ok.
> > 
> > I wonder whether designing-in a millisecond granularity is the right thing
> > to do.  If in a few years the kernel is running tickless with high-res clock
> > interrupt sources, that might look a bit lumpy.
> > 
> > Switching it to a __u64 nanosecond counter would be basically free on
> > 64-bit machines, and not very expensive on 32-bit, no?
> 
> I can put nanoseconds as timer interval too (with aligned_u64 as David
> mentioned), and put it for timeout value too - 64 bit nanosecods ends up
> with 58 years, probably enough.
> Structures with u64 a really not so good idea.
> 

OK.  One could do u32 seconds/u32 nsecs, but a simple aligned_u64 will be
better for 64-bit machines, and OK for 32-bit.
