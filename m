Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275391AbRJFRss>; Sat, 6 Oct 2001 13:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275398AbRJFRsj>; Sat, 6 Oct 2001 13:48:39 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:59909 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275391AbRJFRsa>; Sat, 6 Oct 2001 13:48:30 -0400
Date: Sat, 6 Oct 2001 19:48:52 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.4.33L.0110061357560.12110-200000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.3.96.1011006194028.5632A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2001, Rik van Riel wrote:

> On Sat, 6 Oct 2001, Mikulas Patocka wrote:
> > On Sat, 6 Oct 2001, Rik van Riel wrote:
> > > On Sat, 6 Oct 2001, Mikulas Patocka wrote:
> > >
> > > > Buddy allocator is broken - kill it. Or at least do not misuse it for
> > > > anything except kernel or driver initialization.
> > >
> > > Please send patches to get rid of the buddy allocator while
> > > still making it possible to allocate contiguous chunks of
> > > memory.
> > >
> > > If you have any idea on how to fix things, this would be a
> > > good time to let us know.
> >
> > Here goes the fix. (note that I didn't try to compile it so there may be
> > bugs, but you see the point).
> 
> So what are you going to do when your 64MB of vmalloc space
> runs out ?

Make larger vmalloc space :-) Virtual memory costs very little.
Besides 64M / 8k = 8192 - so it runs out at 8192 processes.

Of course vmalloc space can overflow - but it overflows only when the
machine is overloaded with too many processes, too many processes with
many filedescriptors etc. On the other hand, the buddy allocator fails
*RANDOMLY*. Totally randomly, depending on cache access patterns and
page allocation times.

Mikulas

