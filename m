Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbREOKoW>; Tue, 15 May 2001 06:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262731AbREOKoM>; Tue, 15 May 2001 06:44:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15024 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262730AbREOKoK>;
	Tue, 15 May 2001 06:44:10 -0400
Date: Tue, 15 May 2001 06:44:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <01051512333507.24410@starship>
Message-ID: <Pine.GSO.4.21.0105150637070.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Daniel Phillips wrote:

> That's because you left out his invalidate:
> 
>  	* create an instance in pagecache
>  	* start reading into buffer cache (doesn't invalidate, right?)
>  	* start writing using pagecache (invalidate buffer copy)

Bzzert. You have a race here. Let's make it explicit:

start writing
put write request in queue
block on that
					start reading into buffer cache
					put read request into queue
					read from media
write to media

And no, we can't invalidate from IO completion hook.

>  	* lose the page
>  	* try to read it (via pagecache)
> 
> Everthing ok.

Nope.

