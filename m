Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266553AbSLJBsQ>; Mon, 9 Dec 2002 20:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266555AbSLJBsQ>; Mon, 9 Dec 2002 20:48:16 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:53237 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S266553AbSLJBsN>; Mon, 9 Dec 2002 20:48:13 -0500
Message-ID: <3DF549A3.5D63B4B0@attbi.com>
Date: Mon, 09 Dec 2002 20:55:47 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: akpm@digeo.com, linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
References: <3DF4B5C1.D36D4CCF@attbi.com> <20021209223515.GC20686@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Mon, Dec 09, 2002 at 10:24:49AM -0500, Jim Houston wrote:
> > I got started on this before Ingo did his magic for hashing
> > pids.  I prototyped in user space and did a quick hack to
> > make it work in the kernel.  Yes, it uses a recursive approach
> > for the allocate and remove path.  The recursion is limited
> > to only a few levels and the stack frame is tiny.  For example
> > if there are 1000000 ids it will have 6 levels of recursion.
> 
> I'm not Ingo but you'll figure it out.
> 
> Recursion is unnecessary; the depths are bounded by BITS_PER_LONG
> divided by the log of the branch factor and looping over levels
> directly suffices.
> 
> I started somewhat before the first for_each_task-* patches are
> dated on kernel.org, which puts it sometime before May (obviously
> I spent time writing & testing before dropping it onto an ftp site).
> 
> My original allocator(s) used a radix tree structured bitmap like this
> in order to provide hard constant time bounds, but statically-allocated
> them. Static allocation didn't fit in with larger pid space, though.
> 
> Bill

Hi Bill,

Gee Bill, what can I say?  I'm sorry I misattributed your work to Ingo.

I'm curious about the reaction to recursion.  I use the obvious loop
for the lookup path, but the allocate and remove cases start getting
ugly as an iterative solution.

Jim Houston - Concurrent Computer Corp.
