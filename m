Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267210AbSLEEZc>; Wed, 4 Dec 2002 23:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267211AbSLEEZc>; Wed, 4 Dec 2002 23:25:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:19966 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267210AbSLEEZb>;
	Wed, 4 Dec 2002 23:25:31 -0500
Message-ID: <3DEED6FA.B179FAFD@digeo.com>
Date: Wed, 04 Dec 2002 20:32:58 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2002 04:32:59.0427 (UTC) FILETIME=[63EA3730:01C29C17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> On Wed, Dec 04, 2002 at 11:34:35AM -0800, Andrew Morton wrote:
> > > +/* Use these with kmalloc_percpu */
> > > +#define get_cpu_ptr(ptr) per_cpu_ptr(ptr, get_cpu())
> > > +#define put_cpu_ptr(ptr) put_cpu()
> >
> > These names sound very much like get_cpu_var() and put_cpu_var(),
> > yet they are using a quite different subsystem.  It would be good
> > to choose something more distinct.  Not that I can think of anything
> > at present ;)
> 
> Well, they are similar, aren't they ? get_cpu_ptr() can just be thought
> of as the dynamic twin of get_cpu_var(). So, in that sense it seems ok
> to me.

hm.  spose so.

> >
> > If we were to remove the percpu_interlaced_alloc() leg here, we'd
> > have a nice, simple per-cpu kmalloc implementation.
> >
> > Could you please explain what all the other code is there for?
> 
> The interlaced allocator allows you to save space when kmalloc_percpu()
> is used to allocate small objects. That is done by interlacing each
> CPU's copy of the objects just like the static per-cpu data area.
> 

Where in the kernel is such a large number of 4-, 8- or 16-byte
objects being used?

The slab allocator will support caches right down to 1024 x 4-byte
objects per page.  Why is that not appropriate?

If it is for locality-of-reference between individual objects then
where in the kernel is this required, and are performance measurements
available?  It is very unusual to have objects which are so small,
and a better design would be to obtain the locality of reference
by aggregating the data into an array or structure.


Sorry, but you have what is basically a brand new allocator in
there, and we need a very good reason for including it.  I'd like
to know what that reason is, please.
