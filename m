Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbRFQQln>; Sun, 17 Jun 2001 12:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbRFQQlY>; Sun, 17 Jun 2001 12:41:24 -0400
Received: from www.wen-online.de ([212.223.88.39]:53778 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261515AbRFQQlV>;
	Sun, 17 Jun 2001 12:41:21 -0400
Date: Sun, 17 Jun 2001 18:40:46 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: <thunder7@xs4all.nl>
cc: <linux-kernel@vger.kernel.org>, <riel@conectiva.com.br>
Subject: Re: (lkml)Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
In-Reply-To: <20010617144938.A2300@middle.of.nowhere>
Message-ID: <Pine.LNX.4.33.0106171748070.476-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2001 thunder7@xs4all.nl wrote:

> On Sun, Jun 17, 2001 at 12:05:10PM +0200, Mike Galbraith wrote:
> >
> > It _juuust_ so happens that I was tinkering... what do you think of
> > something like the below?  (and boy do I ever wonder what a certain
> > box doing slrn stuff thinks of it.. hint hint;)
> >
> I'm sorry to say this box doesn't really think any different of it.

Well darn.  But..

> Everything that's in the cache before running slrn on a big group seems
> to stay there the whole time, making my active slrn-process use swap.

It should not be the same data if page aging is working at all.  Better
stated, if it _is_ the same data and page aging is working, it's needed
data, so the movement of momentarily unused rss to disk might have been
the right thing to do.. it just has to buy you the use of the pages moved
for long enough to offset the (large) cost of dropping those pages.

I saw it adding rss to the aging pool, but not terribly much IO.  The
fact that it is using page replacement is only interesting in regard to
total system efficiency.

> I applied the patch to 2.4.5-ac15, and this was the result:

<saves vmstat>

Thanks for running it.  Can you (afford to) send me procinfo or such
(what I would like to see is job efficiency) information?  Full logs
are fine, as long as they're not truely huge :)  Anything under a meg
is gratefully accepted (privately 'course).

I think (am pretty darn sure) the aging fairness change is what is
affecting you, but it's not possible to see whether this change is
affecting you in a negative or positive way without timing data.

	-Mike

misc:

wrt this ~patch, it only allows you to move the rolldown to sync disk
behavior some.. moving write delay back some (knob) is _supposed_ to
get that IO load (at least) a modest throughput increase.  The flushto
thing was basically directed toward laptop use, but ~seems to exhibit
better IO clustering/bandwidth sharing as well.  (less old/new request
merging?.. distance?)

