Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272528AbRIFTih>; Thu, 6 Sep 2001 15:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272530AbRIFTi1>; Thu, 6 Sep 2001 15:38:27 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1029 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272528AbRIFTiV>; Thu, 6 Sep 2001 15:38:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Thu, 6 Sep 2001 21:45:35 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Kurt Garloff <garloff@suse.de>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0109061623150.8103-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109061623150.8103-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010906193836Z16130-26183+40@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 09:25 pm, Rik van Riel wrote:
> On Thu, 6 Sep 2001, Daniel Phillips wrote:
> > On September 6, 2001 06:57 pm, Rik van Riel wrote:
> > > On Thu, 6 Sep 2001, Daniel Phillips wrote:
> > >
> > > > Err, not quite the whole story.  It is *never* right to leave the disk
> > > > sitting idle while there are dirty, writable IO buffers.
> > >
> > > Define "idle" ?
> >
> > Idle = not doing anything.  IO queue is empty.
> >
> > > Is idle the time it takes between two readahead requests
> > > to be issued, delaying the second request because you
> > > just moved the disk arm away ?
> >
> > Which two readahead requests?  It's idle.
> 
> OK, in this case I disagree with you ;)
> 
> Disk seek time takes ages, as much as 10 milliseconds.
> 
> I really don't think it's good to move the disk arm away
> from the data we are reading just to write out this one
> disk block.
> 
> Going 20 milliseconds out of our way to write out a single
> block really can't be worth it in any scenario I can imagine.
> 
> OTOH, flushing out 64 or 128 kB at once (or some fraction of
> the inactive list, say 5%?) almost certainly is worth it in
> many cases.

Again, I have to ask, which reads are you interfering with?  Ones that 
haven't happened yet?  Remember, the disk is idle.  So *at worst* you are 
going to get one extra seek before getting hit with the tidal wave of reads 
you seem to be worried about.  This simply isn't significant.

I've tested this, I know early writeout under light load is a win.

What we should be worrying about is how to balance reads against writes under 
heavy load.

--
Daniel
