Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261838AbREMTem>; Sun, 13 May 2001 15:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261880AbREMTec>; Sun, 13 May 2001 15:34:32 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14857 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261838AbREMTeV>; Sun, 13 May 2001 15:34:21 -0400
Date: Sun, 13 May 2001 12:34:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105131332050.5468-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105131231050.20452-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 May 2001, Rik van Riel wrote:
> 
> Why the hell would we want this ?

You've missed about half the discussion, it seems..

> If the page is referenced, it should be moved back to the
> active list and should never be a candidate for writeout.

Wrong.

There are
 (a) dead swap pages, where it doesn't matter one _whit_ whether it is
     referenced or not, because we know with 100% certainty that nobody
     will ever reference it again. This _may_ be true in other cases too,
     but we know it is true for swap pages that have lost all references.
 (b) filesystems and memory allocators that might want to get feedback on
     the fact that we're even _looking_ at their pages, and that we're
     aging them down. They might easily use these things for starting
     background activity like deciding to close the logs..

The high-level VM layer simply doesn't have that kind of information.

		Linus

