Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264735AbSJ3STt>; Wed, 30 Oct 2002 13:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264754AbSJ3STt>; Wed, 30 Oct 2002 13:19:49 -0500
Received: from imail.ricis.com ([64.244.234.16]:19470 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S264735AbSJ3STs>;
	Wed, 30 Oct 2002 13:19:48 -0500
Date: Wed, 30 Oct 2002 12:26:07 -0600
From: Lee Leahu <lee@ricis.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Message-Id: <20021030122607.08ea2e68.lee@ricis.com>
In-Reply-To: <3DA1D30E.B3255E7D@digeo.com>
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE>
	<1281002684.1033892373@[10.10.2.3]>
	<E17ybuZ-0003tz-00@starship>
	<3DA1D30E.B3255E7D@digeo.com>
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pardon my ignorance,

How does Readahead relate to journaling filesystems such as ReiserFS, or XFS?

Do they have the same or similar problems that I've been reading about with ext2/3?

Andrew Morton <akpm@digeo.com> scribbled something about Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA)):

> Daniel Phillips wrote:
> > 
> > On Sunday 06 October 2002 17:19, Martin J. Bligh wrote:
> > > > Then there's the issue of application startup. There's not enough
> > > > read ahead. This is especially sad, as the order of page faults is
> > > > at least partially predictable.
> > >
> > > Is the problem really, fundamentally a lack of readahead in the
> > > kernel? Or is it that your application is huge bloated pig?
> > 
> > Readahead isn't the only problem, but it is a huge problem.  The current
> > readahead model is per-inode, which is very little help with lots of small
> > files, especially if they are fragmented or out of order.  There are various
> > ways to fix this; they are all difficult[1].  Fortunately, we can call this
> > "tuning work" so it can be done during the stable series.
> > 
> > [1] We could teach each filesystem how to read ahead across directories, or
> > we could teach the vfs how to do physical readahead.  Choose your poison.
> 
> Devices do physical readahead, and it works nicely.
> 
> Go into ext2_new_inode, replace the call to find_group_dir with
> find_group_other.  Then untar a kernel tree, unmount the fs,
> remount it and see how long it takes to do a
> 
> 	`find . -type f  xargs cat > /dev/null'
> 
> on that tree.  If your disk is like my disk, you will achieve
> full disk bandwidth.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|		-- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
