Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264621AbRFUHTy>; Thu, 21 Jun 2001 03:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbRFUHTp>; Thu, 21 Jun 2001 03:19:45 -0400
Received: from zeus.kernel.org ([209.10.41.242]:34986 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264621AbRFUHTh>;
	Thu, 21 Jun 2001 03:19:37 -0400
Date: Thu, 21 Jun 2001 02:44:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac15
In-Reply-To: <Pine.LNX.4.33.0106210836340.1043-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0106210226330.14247-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jun 2001, Mike Galbraith wrote:

> On Thu, 21 Jun 2001, Marcelo Tosatti wrote:
> 
> > >  2  4  2  77084   1524  18396  66904   0 1876   108  2220 2464 66079   198   1
>                                                                    ^^^^^
> > Ok, I suspect that GFP_BUFFER allocations are fucking up here (they can't
> > block on IO, so they loop insanely).
> 
> Why doesn't the VM hang the syncing of queued IO on these guys via
> wait_event or such instead of trying to just let the allocation fail?

Actually the VM should limit the amount of data being queued for _all_
kind of allocations.

The problem is the lack of a mechanism which allows us to account the
approximated amount of queued IO by the VM. (except for swap pages)

You can see it this way: To get free memory we're "polling" instead of
waiting on the IO completion of pages.

> (which seems to me will only cause the allocation to be resubmitted,
> effectively changing nothing but adding overhead) 

Yes.

> Does failing the allocation in fact accomplish more than what I'm
> (uhoh:) assuming?

No.

It sucks really badly.

