Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRJYNKP>; Thu, 25 Oct 2001 09:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJYNKE>; Thu, 25 Oct 2001 09:10:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:61457 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273345AbRJYNJz>;
	Thu, 25 Oct 2001 09:09:55 -0400
Date: Thu, 25 Oct 2001 11:10:25 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Steven Butler <stevenb1@bigpond.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Memory Paging and fork copy-on-write semantics
In-Reply-To: <3BD7AA3A.8040104@bigpond.net.au>
Message-ID: <Pine.LNX.4.33L.0110251105030.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, Steven Butler wrote:

> I have been making use of copy-on-write semantics of linux fork to
> duplicate a process around 100+ times to generate client load against a
> server.  The copy-on-write allows me to run many more processes without
> swap thrashing than I'd otherwise be able to.  The client code is in
> perl, so the process sizes are in the MBs.  Using this technique I only
> need about 2 MB per user, with around 5.5 MB shared.

	[snip COW undone on swapout, leading to thrashing]

> Is this expected and reasonable behaviour?

Absolutely not, this is not supposed to happen.

>  Is it possible for pages to remain shared, even when they are swapped
> to disk?

I think this already happens in the -ac kernels, probably
in -linus too (though I'm not 100% sure).

> Does that already happen anyway, meaning my analysis of the situation
> is off base?

Possible, but it's also possible you ran into a real bug,
it would be interesting to debug this further...

I wouldn't rule out a bug with the remove-from-swapcache
logic on swapin, either.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

