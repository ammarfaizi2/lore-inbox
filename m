Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbREMTjn>; Sun, 13 May 2001 15:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261880AbREMTjd>; Sun, 13 May 2001 15:39:33 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:14854 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261877AbREMTjX>;
	Sun, 13 May 2001 15:39:23 -0400
Date: Sun, 13 May 2001 16:39:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105131231050.20452-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105131637060.5468-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2001, Linus Torvalds wrote:
> On Sun, 13 May 2001, Rik van Riel wrote:
> > 
> > Why the hell would we want this ?
> You've missed about half the discussion, it seems..

True, I was away at a conference ;)

> > If the page is referenced, it should be moved back to the
> > active list and should never be a candidate for writeout.
> 
> Wrong.
> 
> There are
>  (a) dead swap pages, where it doesn't matter one _whit_ whether it is
>      referenced or not, because we know with 100% certainty that nobody
>      will ever reference it again. This _may_ be true in other cases too,
>      but we know it is true for swap pages that have lost all references.
>  (b) filesystems and memory allocators that might want to get feedback on
>      the fact that we're even _looking_ at their pages, and that we're
>      aging them down. They might easily use these things for starting
>      background activity like deciding to close the logs..
> 
> The high-level VM layer simply doesn't have that kind of information.

Agreed.  I'd like to make sure, however, that we keep the
high-level VM cleanly separated from the lower layers so
we can keep the VM maintainable and predictable...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

