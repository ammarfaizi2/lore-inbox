Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131610AbRCSVQZ>; Mon, 19 Mar 2001 16:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131612AbRCSVQP>; Mon, 19 Mar 2001 16:16:15 -0500
Received: from smtp2.sentex.ca ([199.212.134.9]:19466 "EHLO smtp2.sentex.ca")
	by vger.kernel.org with ESMTP id <S131623AbRCSVQB>;
	Mon, 19 Mar 2001 16:16:01 -0500
Message-ID: <3AB67569.B203D75D@coplanar.net>
Date: Mon, 19 Mar 2001 16:08:57 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: root@chaos.analogic.com, Otto Wyss <otto.wyss@bluewin.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
In-Reply-To: <Pine.LNX.3.95.1010319150027.9639A-100000@chaos.analogic.com> <3AB67134.762CFF32@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

> "Richard B. Johnson" wrote:
> >
> > On Mon, 19 Mar 2001, Otto Wyss wrote:
> >
> > > Lately I had an USB failure, leaving me without any access to my system
> > > since I only use an USB-keyboard/-mouse. All I could do in that
> > > situation was switching power off and on after a few minutes of
> > > inactivity. From the impression I got during the following startup, I
> > > assume Linux (2.4.2, EXT2-filesystem) is not very suited to any power
> > > failiure or manually switching it off. Not even if there wasn't any
> > > activity going on.
> > >
> > > Shouldn't a good system allways try to be on the save side? Shouldn't
> > > Linux try to be more fail save? There is currently much work done in
> > > getting high performance during high activity but it seems there is no
> > > work done at all in getting a save system during low/no activity. I
> > > think this is a major drawback and should be addressed as fast as
> > > possible. Bringing a system to save state should allway have a high priority.
> > >
> > > How could this be accomplished:
> > > 1. Flush any dirty cache pages as soon as possible. There may not be any
> > > dirty cache after a certain amount of idle time.
> > > 2. Keep open files in a state where it doesn't matter if they where
> > > improperly closed (if possible).
> > > 3. Swap may not contain anything which can't be discarded. Otherwise
> > > swap has to be treated as ordinary disk space.
> > >
> > > These actions are not filesystem dependant. It might be that certain
> > > filesystem cope better with power failiure than others but still it's
> > > much better not to have errors instead to fix them.
> > >
> > > Don't we tell children never go close to any abyss or doesn't have
> > > alpinist a saying "never go to the limits"? So why is this simple rule
> > > always broken with computers?
> > >
> >
> > Unix and other such variants have what's called a Virtual File System
> > (VFS).  The idea behind this is to keep as much recently-used file stuff
> > in memory so that the system can be as fast as if you used a RAM disk
> > instead of real physical (slow) hard disks. If you can't cope with this,
> > use DOS.
>
> At the very least the disk should be consistent with memory.  If the
> dirty pages aren't written back to the disk (but not necessarily removed
> from memory) after a reasonable idle period, then there is room for
> improvement.

They are.   If you leave your machine one for a minute or so (probably less is ok,
but I don't know) the kernel will flush dirty buffers... fsck will complain, but the
file's
*data* blocks will be on the disk.  There are way more reasons that this is a silly
and annoying thread.  You should read more about things like
asynchronous/synchronous filesystems,
lazy-write cacheing, etc, etc,.  If you know how to write software and/or configure
your system,
you can avoid all of these problems.  Or use a journaling filesystem ext3/xfs, etc.
But I tire of this...

