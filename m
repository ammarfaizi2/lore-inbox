Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282775AbRK0Drw>; Mon, 26 Nov 2001 22:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282776AbRK0Dre>; Mon, 26 Nov 2001 22:47:34 -0500
Received: from host213-123-15-79.btinternet.com ([213.123.15.79]:7555 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S282775AbRK0DrP>; Mon, 26 Nov 2001 22:47:15 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200111270339.DAA06920@mauve.demon.co.uk>
Subject: Re: Journaling pointless with today's hard disks?
To: landley@trommello.org
Date: Tue, 27 Nov 2001 03:39:05 +0000 (GMT)
Cc: root@mauve.demon.co.uk (Ian Stirling), andre@linux-ide.org (Andre Hedrick),
        cw@f00f.org (Chris Wedgwood), linux-kernel@vger.kernel.org
In-Reply-To: <0111261800340R.02001@localhost.localdomain> from "Rob Landley" at Nov 26, 2001 06:00:34 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Monday 26 November 2001 20:23, Ian Stirling wrote:
> 
> > > Now a cache large enough to hold 2 full tracks could also hold dozens of
> > > individual sectors scattered around the disk, which could take a full
> > > second to write off and power down.  This is a "doctor, it hurts when I
> > > do this" question.  DON'T DO THAT.
> >
> > Or, to seek to a journal track, and write the cache to it.
> 
> Except that at most you have one seek to write out all the pending cache data 
> anyway, so what exactly does seeking to a journal track buy you?

The ability to possibly dramatically improve performance by allowing 
more than one or two tracks to be write cached at once.
Yes, in theory, the system should be able to elevator all seeks, but
it may not know that track 400 has really been remapped to 200, the
drive does.

With write-caching on, the system doesn't know where the head is, 
the drive does.
And, it's nearly free (an extra meg of space) 
<snip>
> Possibly.  I still don't see what it gets you if you only have one track 
> other than the one you're over to write to.  (is the journal track near the 
> area the head parks in?  That could be a power saving method, I suppose.  But 
> it's also wasting disk space that would probably otherwise be used for 
> storage or a block remapping, and how do you remap a bad sector out of the 
> journal track if that happens?)

You simply pick another track for the journal, the same as you would
if an ordinary track goes bad.
(it's tested on boot)
The waste of disk space is utterly trivial.
A meg in drives where the entry level is 40G?
