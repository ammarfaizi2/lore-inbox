Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265379AbRFVJHb>; Fri, 22 Jun 2001 05:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbRFVJHW>; Fri, 22 Jun 2001 05:07:22 -0400
Received: from www.wen-online.de ([212.223.88.39]:62216 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S265379AbRFVJHN>;
	Fri, 22 Jun 2001 05:07:13 -0400
Date: Fri, 22 Jun 2001 11:06:33 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac15
In-Reply-To: <Pine.LNX.4.21.0106210226330.14247-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106221043360.226-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Marcelo Tosatti wrote:

> On Thu, 21 Jun 2001, Mike Galbraith wrote:
>
> > On Thu, 21 Jun 2001, Marcelo Tosatti wrote:
> >
> > > >  2  4  2  77084   1524  18396  66904   0 1876   108  2220 2464 66079   198   1
> >                                                                    ^^^^^
> > > Ok, I suspect that GFP_BUFFER allocations are fucking up here (they can't
> > > block on IO, so they loop insanely).
> >
> > Why doesn't the VM hang the syncing of queued IO on these guys via
> > wait_event or such instead of trying to just let the allocation fail?
...
> > Does failing the allocation in fact accomplish more than what I'm
> > (uhoh:) assuming?
>
> No.

hmm..

Jun 18 07:11:36 kernel: reclaim_page: salvaged ref:1 age:0 buf:0 cnt:1
Jun 18 07:11:36 last message repeated 27 times

One thing that _could_ be done about looping allocations is to steal
a page from the clean list ignoring PageReferenced (if you have any).
That would be a very expensive 'rob Peter to pay Paul' trade though.

	-Mike

