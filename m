Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbRAaWNr>; Wed, 31 Jan 2001 17:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129128AbRAaWNh>; Wed, 31 Jan 2001 17:13:37 -0500
Received: from slc548.modem.xmission.com ([166.70.7.40]:63505 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129091AbRAaWNC>; Wed, 31 Jan 2001 17:13:02 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH] vma limited swapin readahead
In-Reply-To: <Pine.LNX.4.21.0101310636530.16408-100000@freak.distro.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 31 Jan 2001 12:40:52 -0700
In-Reply-To: Marcelo Tosatti's message of "Wed, 31 Jan 2001 06:40:18 -0200 (BRST)"
Message-ID: <m18znrcxx7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> On Wed, 31 Jan 2001, Stephen C. Tweedie wrote:
> 
> > Hi,
> > 
> > On Wed, Jan 31, 2001 at 01:05:02AM -0200, Marcelo Tosatti wrote:
> > > 
> > > However, the pages which are contiguous on swap are not necessarily
> > > contiguous in the virtual memory area where the fault happened. That means
> > > the swapin readahead code may read pages which are not related to the
> > > process which suffered a page fault.
> > > 
> > Yes, but reading extra sectors is cheap, and throwing the pages out of
> > memory again if they turn out not to be needed is also cheap.  The
> > on-disk swapped pages are likely to have been swapped out at roughly
> > the same time, which is at least a modest indicator of being of the
> > same age and likely to have been in use at the same time in the past.
> 
> You're throwing away pages from memory to do the readahead. 
> 
> This pages might be more useful than the pages which you're reading from
> swap. 

Possibly.  However the win (lower latency) from getting swapin
readahead is probably even bigger.  And you are throwing out the least
desirable pages in memory.

> > I'd like to see at lest some basic performance numbers on this,
> > though.
> 
> I'm not sure if limiting the readahead the way my patch does is a better
> choice, too.

A better choice is probably to make certain the read and write paths are in
sync so that you can know the readahead is going to do you some good.
This is a little tricky though.  

Unless you can see a big performance win somewhere please don't submit
this to Linus for inclusion.


Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
