Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130111AbRB1IpK>; Wed, 28 Feb 2001 03:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130126AbRB1IpB>; Wed, 28 Feb 2001 03:45:01 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:2310 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130111AbRB1Ioq>; Wed, 28 Feb 2001 03:44:46 -0500
Date: Wed, 28 Feb 2001 03:58:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0102280556040.972-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0102280209160.7315-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Feb 2001, Mike Galbraith wrote:

> On Tue, 27 Feb 2001, Marcelo Tosatti wrote:
> 
> > On Tue, 27 Feb 2001, Mike Galbraith wrote:
> >
> > > What the patch does is simply to push I/O as fast as we can.. we're
> > > by definition I/O bound and _can't_ defer it under any circumstance,
> > > for in this direction lies constipation.  The only thing in the world
> > > which will make it better is pushing I/O.
> >
> > In your I/O bound case, yes. But not in all cases.
> 
> That's one reason I tossed it out.  I don't _think_ it should have any
> negative effect on other loads, but a test run might find otherwise.

Writes are more expensive than reads. Apart from the aggressive read
caching on the disk, writes have limited caching or no caching at all if
you need security (journalling, for example). (I'm not sure about write
caching details, any harddisk expert?)

On read intensive loads, doing IO to free memory (writing pages out) will
be horribly harmful for these reads (which you can free easily), so its
better to avoid the writes as much as possible.

I remember Matthew Dillon (FreeBSD VM guy) had a read intensive case were
using 20:1 clean/flush ratio to free pages in FreeBSD's launder routine
(at that time, IIRC, their launder routine was looping twice the inactive
dirty list looking for clean pages to throw away, and only on the third
loop it would do IO) was still being a problem for disk performance
because of the writes. Yes, it sounds weird.

I suppose you're running dbench. 

