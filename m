Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbSJGS2K>; Mon, 7 Oct 2002 14:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262565AbSJGS2K>; Mon, 7 Oct 2002 14:28:10 -0400
Received: from packet.digeo.com ([12.110.80.53]:11186 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262517AbSJGS0M>;
	Mon, 7 Oct 2002 14:26:12 -0400
Message-ID: <3DA1D30E.B3255E7D@digeo.com>
Date: Mon, 07 Oct 2002 11:31:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Oliver Neukum <oliver@neukum.name>,
       Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - 
 (NUMA))
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2002 18:31:42.0026 (UTC) FILETIME=[C82632A0:01C26E2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Sunday 06 October 2002 17:19, Martin J. Bligh wrote:
> > > Then there's the issue of application startup. There's not enough
> > > read ahead. This is especially sad, as the order of page faults is
> > > at least partially predictable.
> >
> > Is the problem really, fundamentally a lack of readahead in the
> > kernel? Or is it that your application is huge bloated pig?
> 
> Readahead isn't the only problem, but it is a huge problem.  The current
> readahead model is per-inode, which is very little help with lots of small
> files, especially if they are fragmented or out of order.  There are various
> ways to fix this; they are all difficult[1].  Fortunately, we can call this
> "tuning work" so it can be done during the stable series.
> 
> [1] We could teach each filesystem how to read ahead across directories, or
> we could teach the vfs how to do physical readahead.  Choose your poison.

Devices do physical readahead, and it works nicely.

Go into ext2_new_inode, replace the call to find_group_dir with
find_group_other.  Then untar a kernel tree, unmount the fs,
remount it and see how long it takes to do a

	`find . -type f  xargs cat > /dev/null'

on that tree.  If your disk is like my disk, you will achieve
full disk bandwidth.
