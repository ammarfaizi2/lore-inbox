Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbRENE1r>; Mon, 14 May 2001 00:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262267AbRENE1i>; Mon, 14 May 2001 00:27:38 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:4760 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262252AbRENE1Z>; Mon, 14 May 2001 00:27:25 -0400
Date: Sun, 13 May 2001 22:27:17 -0600
Message-Id: <200105140427.f4E4RHY09517@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.21.0105140007400.4671-100000@imladris.rielhome.conectiva>
In-Reply-To: <200105140239.f4E2dNd08399@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.21.0105140007400.4671-100000@imladris.rielhome.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Sun, 13 May 2001, Richard Gooch wrote:
> > Larry McVoy writes:
> 
> > > Ha.  For once you're both wrong but not where you are thinking.  One
> > > of the few places that I actually hacked Linux was for exactly this
> > > - it was in the 0.99 days I think.  I saved the list of I/O's in a
> > > file and filled the buffer cache with them at next boot.  It
> > > actually didn't help at all.
> > 
> > Maybe you did something wrong :-)
> 
> How about "the data loads got instrumented, but the metadata
> loads which caused over half of the disk seeks didn't" ?
> 
> (just a wild guess ... if it turns out to be true we may want
> to look into doing agressive readahead on inode blocks ;))

Caching metadata is definately part of my cunning plan. I'd like to
think that once Al's metadata-in-page-cache patches go in, we'll get
that for free.

However, that will still leave indirect blocks unordered. I don't see
a clean way of fixing that. Which is why doing things at the block
device layer has it's attractions (except it doesn't work).

Hm. Is there a reason why the page cache can't see if a a block is in
the block cache, and read it from there first?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
