Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130163AbRBNVOr>; Wed, 14 Feb 2001 16:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129510AbRBNVOh>; Wed, 14 Feb 2001 16:14:37 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:24657 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129397AbRBNVOb>; Wed, 14 Feb 2001 16:14:31 -0500
Message-Id: <200102142115.f1ELFk007175@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Steve Lord <lord@sgi.com>, simon@baydel.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: File IO performance 
In-Reply-To: Message from Marcelo Tosatti <marcelo@conectiva.com.br> 
   of "Wed, 14 Feb 2001 15:38:59 -0200." <Pine.LNX.4.21.0102141438470.31465-100000@freak.distro.conectiva> 
Date: Wed, 14 Feb 2001 15:15:46 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti wrote:
> 
> On Wed, 14 Feb 2001, Steve Lord wrote:
> 
> <snip>
> 
> > A break in the on disk mapping of data could be used to stop readahead
> > I suppose, especially if getting that readahead page is going to
> > involve evicting other pages. I suspect that doing this time of thing
> > is probably getting too complex for it's own good though.
> >
> > Try breaking the readahead loop apart, folding the page_cache_read into
> > the loop, doing all the page allocates first, and then all the readpage
> > calls. 
> 
> Its too dangerous it seems --- the amount of pages which are
> allocated/locked/mapped/submitted together must be based on the number of
> free pages otherwise you can run into an oom deadlock when you have a
> relatively high number of pages allocated/locked. 

Which says that as you ask for pages to put the readahead in, you want to
get a failure back under memory pressure, you push out what you allocated
already and carry on.

> 
> > I suspect you really need to go a bit further and get the mapping of
> > all the pages fixed up before you do the actual reads.
> 
> Hum, also think about a no-buffer-head deadlock when we're under a
> critical number of buffer heads while having quite a few buffer heads
> locked which are not going to be queued until all needed buffer heads are 
> allocated.

All this is probably attempting to be too clever for its own good, there is
probably a much simpler way to get more things happening in parallel. Plus, in
reality, lots of apps will spend some time between read calls processing
data, so there is overlap, a benchmark doing just reads is the end case
of all of this.

Steve



