Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRBHST7>; Thu, 8 Feb 2001 13:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRBHSTj>; Thu, 8 Feb 2001 13:19:39 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:48006 "EHLO
	smtprelay3.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S129131AbRBHSTg>; Thu, 8 Feb 2001 13:19:36 -0500
Message-ID: <3A82E27A.E718E175@adelphia.net>
Date: Thu, 08 Feb 2001 13:16:26 -0500
From: Stephen Wille Padnos <stephenwp@adelphia.net>
X-Mailer: Mozilla 4.76C-SGI [en] (X11; U; IRIX64 6.5 IP28)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <Pine.LNX.3.95.1010208125335.2003B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 8 Feb 2001, Stephen Wille Padnos wrote:
> 
> > "Richard B. Johnson" wrote:
> > [snip]
> > > Another problem with 'volatile' has to do with pointers. When
> > > it's possible for some object to be modified by some external
> > > influence, we see:
> > >
> > >         volatile struct whatever *ptr;
> > >
> > > Now, it's unclear if gcc knows that we don't give a damn about
> > > the address contained in 'ptr'. We know that it's not going to
> > > change. What we are concerned with are the items within the
> > > 'struct whatever'. From what I've seen, gcc just reloads the
> > > pointer.
> > >
[snip]

> Yes. My point is that a lot of authors have declared just about everything
> 'volatile' `grep volatile /usr/src/linux/drivers/net/*.c`, just to
> be "safe". It's likely that there are many hundreds of thousands of
> unneeded register-reloads because of this.
> 
> It might be useful for somebody who has a lot of time on his/her
> hands to go through some of these drivers.

I would be willing to do this (on the slow boat - I don't have THAT much
spare time :), but only if we can be sure that the gcc optimizer will
correctly handle a normal pointer to volatile data.  Your experiences
would seem to indicate that the optimizer needs fixing before much
effort should be spent on this.

-- 
Stephen Wille Padnos
Programmer, Engineer, Problem Solver
swpadnos@adelphia.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
