Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRCAVIC>; Thu, 1 Mar 2001 16:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRCAVG3>; Thu, 1 Mar 2001 16:06:29 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:54011 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130016AbRCAVF4>; Thu, 1 Mar 2001 16:05:56 -0500
Date: Thu, 1 Mar 2001 18:05:29 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0103012021470.1542-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0103011747560.1961-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Mike Galbraith wrote:
> On Thu, 1 Mar 2001, Rik van Riel wrote:
> > On Thu, 1 Mar 2001, Mike Galbraith wrote:

> No no no and again no (perhaps I misread that bit).  But otoh,
> you haven't tested the patch I sent in good faith.  I sent it
> because I have thought about it.  I may be wrong in my
> interpretation of the results, but those results were thought
> about.. and they exist.

I haven't tested it yet for a number of reasons. The most
important one is that the FreeBSD people have been playing
with this thing for a few years now and Matt Dillon has
told me the result of their tests ;)

> > But if the amount of dirtied pages is _small_, it means that we can
> > allow the reads to continue uninterrupted for a while before we
> > flush all dirty pages in one go...
>
> "If wishes were horses, beggers would ride."
>
> There is no mechanysm in place that ensures that dirty pages
> can't get out of control, and they do in fact get out of
> control, and it is exaserbated (mho) by attempting to define
> 'too much I/O' without any information to base this definition
> upon.

True. I think we want something in-between our ideas...

> > Also, the elevator can only try to optimise whatever you throw at
> > it. If you throw random requests at the elevator, you cannot expect
> > it to do ANY GOOD ...
>
> This is a very good point (which I will think upon).  I ask you this
> in return.  Why do you think that the random junk you throw at the
> elevator is different than the random junk I throw at it? ;-)  I see
> no difference at all.. it's the same exact junk.

Except that your code throws the random junk at the elevator all
the time, while my code only bothers the elevator every once in
a while. This should make it possible for the disk reads to
continue with less interruptions.

> > The merging at the elevator level only works if the requests sent to
> > it are right next to each other on disk. This means that randomly
> > sending stuff to disk really DOES DESTROY PERFORMANCE and there's
> > nothing the elevator could ever hope to do about that.
>
> True to some (very real) extent because of the limited buffering
> of requests.  However, I can not find any useful information
> that the vm is using to guarantee the IT does not destroy
> performance by your own definition.

Indeed. IMHO we should fix this by putting explicit IO
clustering in the ->writepage() functions.

Doing this, in combination with *WAITING* for dirty pages
to accumulate on the inactive list will give us the
possibility to do more writeout of dirty data with less
disk seeks (and less slowdown of the reads).

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

