Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272522AbRIFTbr>; Thu, 6 Sep 2001 15:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272523AbRIFTb3>; Thu, 6 Sep 2001 15:31:29 -0400
Received: from [209.10.41.242] ([209.10.41.242]:14542 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S272521AbRIFTbK>;
	Thu, 6 Sep 2001 15:31:10 -0400
Date: Thu, 6 Sep 2001 16:25:23 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Kurt Garloff <garloff@suse.de>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010906171545Z16135-26183+15@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109061623150.8103-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Daniel Phillips wrote:
> On September 6, 2001 06:57 pm, Rik van Riel wrote:
> > On Thu, 6 Sep 2001, Daniel Phillips wrote:
> >
> > > Err, not quite the whole story.  It is *never* right to leave the disk
> > > sitting idle while there are dirty, writable IO buffers.
> >
> > Define "idle" ?
>
> Idle = not doing anything.  IO queue is empty.
>
> > Is idle the time it takes between two readahead requests
> > to be issued, delaying the second request because you
> > just moved the disk arm away ?
>
> Which two readahead requests?  It's idle.

OK, in this case I disagree with you ;)

Disk seek time takes ages, as much as 10 milliseconds.

I really don't think it's good to move the disk arm away
from the data we are reading just to write out this one
disk block.

Going 20 milliseconds out of our way to write out a single
block really can't be worth it in any scenario I can imagine.

OTOH, flushing out 64 or 128 kB at once (or some fraction of
the inactive list, say 5%?) almost certainly is worth it in
many cases.

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

