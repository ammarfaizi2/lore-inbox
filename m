Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265344AbRFVLcE>; Fri, 22 Jun 2001 07:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265346AbRFVLbz>; Fri, 22 Jun 2001 07:31:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45060 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265344AbRFVLbm>; Fri, 22 Jun 2001 07:31:42 -0400
Date: Fri, 22 Jun 2001 06:57:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac15
In-Reply-To: <Pine.LNX.4.33.0106221043360.226-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0106220655450.933-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jun 2001, Mike Galbraith wrote:

> On Thu, 21 Jun 2001, Marcelo Tosatti wrote:
> 
> > On Thu, 21 Jun 2001, Mike Galbraith wrote:
> >
> > > On Thu, 21 Jun 2001, Marcelo Tosatti wrote:
> > >
> > > > >  2  4  2  77084   1524  18396  66904   0 1876   108  2220 2464 66079   198   1
> > >                                                                    ^^^^^
> > > > Ok, I suspect that GFP_BUFFER allocations are fucking up here (they can't
> > > > block on IO, so they loop insanely).
> > >
> > > Why doesn't the VM hang the syncing of queued IO on these guys via
> > > wait_event or such instead of trying to just let the allocation fail?
> ...
> > > Does failing the allocation in fact accomplish more than what I'm
> > > (uhoh:) assuming?
> >
> > No.
> 
> hmm..
> 
> Jun 18 07:11:36 kernel: reclaim_page: salvaged ref:1 age:0 buf:0 cnt:1
> Jun 18 07:11:36 last message repeated 27 times
> 
> One thing that _could_ be done about looping allocations is to steal
> a page from the clean list ignoring PageReferenced (if you have any).
> That would be a very expensive 'rob Peter to pay Paul' trade though.

Don't like it.

This goes against the aging logic.

