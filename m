Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135314AbREHUcV>; Tue, 8 May 2001 16:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135318AbREHUcL>; Tue, 8 May 2001 16:32:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:23812 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135314AbREHUb7>; Tue, 8 May 2001 16:31:59 -0400
Date: Tue, 8 May 2001 15:53:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105080019420.15378-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105081553180.9717-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 May 2001, Linus Torvalds wrote:

> 
> On Mon, 7 May 2001, David S. Miller wrote:
> > 
> > The only downside would be that the formerly "quick case" in the loop
> > of dealing with referenced pages would now need to go inside the page
> > lock.  It's probably a non-issue...
> 
> It might easily be an issue. That function will touch pretty much every
> single page that we ever want to free, and it might be worthwhile to know
> what the pressure is.
> 
> However, the point is probably moot. I found a problem with my approach:
> using writepage() to try to get rid of swap cache pages early on (ie not
> doing the "if it is accessed, put it back on the list" thing early)
> doesn't work all that well: it doesn't handle the case of _clean_
> swap-cache pages at all. And those can be quite common, although usually
> not in the simple benchmarks which just dirty as quickly as they can.
> 
> [ The way to get a clean swap-cache page is to dirty it early in the
>   process lifetime, and then use the page read-only later on over
>   time. Maybe it's not common enough to worry about. ]

What about swapin readahead ? 

