Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130744AbQL1QhI>; Thu, 28 Dec 2000 11:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbQL1Qg5>; Thu, 28 Dec 2000 11:36:57 -0500
Received: from hermes.mixx.net ([212.84.196.2]:62724 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130744AbQL1Qgm>;
	Thu, 28 Dec 2000 11:36:42 -0500
Message-ID: <3A4B6463.C18FB8C5@innominate.de>
Date: Thu, 28 Dec 2000 17:03:47 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012281210480.14052-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0012281227570.14052-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 28 Dec 2000, Rik van Riel wrote:
> > On Wed, 27 Dec 2000, Linus Torvalds wrote:
> > > On Wed, 27 Dec 2000, Rik van Riel wrote:
> > > >
> > > > The (trivial) patch below should fix this problem.
> > >
> > > It must be wrong.
> > >
> > > If we have a dirty page on the LRU lists, that page _must_ have
> > > a mapping.
> >
> > Hmm, last I looked buffercache pages didn't have
> > page->mapping set ...
> 
> OK, you're right ;)
> 
> We never set PG_dirty for buffercache pages, so a
> pure buffercache page shouldn't be caught here...

But we should, and something that does it is buried in Chris Mason's
patch under the thread [RFC] changes to buffer.c.  Chris is also trying
some other fancy things in that patch, but the buffer cache mapping part
is actually pretty simple.

For buffer cache pages I think the current thinking is that PG_dirty
should stay on until the last dirty buffer on the page has been
submitted for writing.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
