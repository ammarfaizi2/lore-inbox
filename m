Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbREXRYp>; Thu, 24 May 2001 13:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbREXRYf>; Thu, 24 May 2001 13:24:35 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:41489 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261489AbREXRYQ>; Thu, 24 May 2001 13:24:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Edgar Toernig <froese@gmx.de>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Thu, 24 May 2001 19:25:23 +0200
X-Mailer: KMail [version 1.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105231550390K.06233@starship> <3B0C547F.DE9E9214@gmx.de>
In-Reply-To: <3B0C547F.DE9E9214@gmx.de>
MIME-Version: 1.0
Message-Id: <0105241925230N.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 May 2001 02:23, Edgar Toernig wrote:
> Daniel Phillips wrote:
> > > > It's going to be marked 'd', it's a directory, not a file.
> > >
> > > Aha.  So you lose the S_ISCHR/BLK attribute.
> >
> > Readdir fills in a directory type, so ls sees it as a directory and
> > does the right thing.  On the other hand, we know we're on a device
> > filesystem so we will next open the name as a regular file, and
> > find ISCHR or ISBLK: good.
>
> ??? The kernel may know it, but the app?  Or do you really want to
> give different stat data on stat(2) and fstat(2)?  These flags are
> currently used by archive/backup prgs.  It's a hint that these files
> are not regular files and shouldn't be opened for reading.
> Having a 'd' would mean that they would really try to enter the
> directory and save it's contents.  Don't know what happens in this
> case to your "special" files ;-)

I guess that's much like the question 'what happens in proc?'.

Recursively entering the device directory is ok as long as everything
inside it is ok.  I tried zipping /proc/bus -r and what I got is what I'd
expect if I'd cat'ed every non-directory entry.  This is what I
expected.  Maybe it's not right - zipping /proc/kcore is kind of
interesting.  Regardless, we are no worse than proc here.  In fact,
since we don't anticipate putting an elephant like kcore in as a
device property, we're a little nicer to get along with.

Correct me if I'm wrong, but what we learn from the proc example
is that tarring your whole source tree starting at / is not something
you want to do.  Just extend that idea to /dev - however, if you do
it, it will produce pretty reasonable results.

What *won't* happen is, you won't get side effects from opening
your serial ports (you'd have to open them without O_DIRECTORY
to get that) so that seems like a little step forward.

I'm still thinking about some of your other comments.

--
Daniel

--
Daniel
