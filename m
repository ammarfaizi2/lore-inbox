Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbQKDFoO>; Sat, 4 Nov 2000 00:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130658AbQKDFoE>; Sat, 4 Nov 2000 00:44:04 -0500
Received: from www.wen-online.de ([212.223.88.39]:28171 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130600AbQKDFnu>;
	Sat, 4 Nov 2000 00:43:50 -0500
Date: Sat, 4 Nov 2000 06:43:17 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process,
 2.4.0-test10
In-Reply-To: <20001103113818.T521@suse.de>
Message-ID: <Pine.Linu.4.10.10011040615300.793-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000, Jens Axboe wrote:

> On Fri, Nov 03 2000, Mike Galbraith wrote:
> > > I very much agree.  Kflushd is still hungry for free write
> > > bandwidth here.
> > 
> > In the LKML tradition of code talks and silly opinions walk...
> > 
> > Attached is a diagnostic patch which gets kflushd under control,
> > and takes make -j30 bzImage build times down from 12 minutes to
> > 9 here.  I have no more massive context switching on write, and
> > copies seem to go a lot quicker to boot.  (that may be because
> > some of my failures were really _really_ horrible)
> > 
> > Comments are very welcome.  I haven't had problems with this yet,
> > but it's early so...  This patch isn't supposed to be pretty either
> > (hw techs don't do pretty;) it's only supposed to say 'Huston...'
> > so be sure to grab a barfbag before you take a look. 
> 
> Super, looks pretty good from here. I'll give it a go when I get back.
> In addition, here's a small patch that disables the read stealing
> of requests from the write list -- does that improve behaviour
> when we are busy flushing?

Yes.  I've done this a bit differently here, and have had good
results.  I only disable stealing when I need flush throughput.

Now that the box isn't biting off more than it can chew quite
as often, I'll try this again.  I'm pretty darn sure that I can
get more throughput, but :> I've learned that getting too much
can do really OOGLY things. (turns box into single user single
tasking streaming IO monster from hell)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
