Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSJHTf4>; Tue, 8 Oct 2002 15:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSJHTeq>; Tue, 8 Oct 2002 15:34:46 -0400
Received: from packet.digeo.com ([12.110.80.53]:27880 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263429AbSJHTd3>;
	Tue, 8 Oct 2002 15:33:29 -0400
Message-ID: <3DA33455.4065101E@digeo.com>
Date: Tue, 08 Oct 2002 12:39:01 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 
 -  (NUMA))
References: <E17ydRY-0003uQ-00@starship> <Pine.LNX.4.33.0210071229080.10168-100000@penguin.transmeta.com> <20021008003903.GA473@think.thunk.org> <3DA24A0E.D2AC3E1B@digeo.com> <20021008161555.GA2913@think.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 19:39:01.0451 (UTC) FILETIME=[5A3F49B0:01C26F02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> 
> On Mon, Oct 07, 2002 at 07:59:26PM -0700, Andrew Morton wrote:
> > In the testing which I did, based on Keith Smith's traces, the
> > current code really isn't very effective.
> >
> > What I did was to run his aging workload an increasing number of
> > times.  Then measured the fragmentation of the files which it
> > left behind.  I measured the fragmentation simply by timing
> > how long it took to read all the files, and compared that to
> > how long it took to read the same files when they had been laid
> > down on a fresh fs.
> 
> What access pattern did you use when you read the files?  Did you
> sweep through filesystem directory by directory, or did you use some
> other pattern (perhaps random)?

Well this is all rather dim in my memory, so the confidence level
is drooping.  I am sure that the timing was a single find | xargs cat
thing.  I also know that I investigated whether the increased time
was due to the metadata access or the data access.  I _think_ it was
mainly metadata.

But it all needs to be redone, really.

> ...
> > Maybe a mount option?  But I think the current algorithm should
> > default to "off".
> 
> How about a mount option with the possible values: "fast", "slow",
> "hinted", and "auto", with the default being "auto" or "hinted"?
> (Where hinted utilizes user-space hints, and "auto" utilizes
> user-space hints if present, plus some of the so-called ugly
> hueristics which you had discussed?)
> 

Well the current Orlov patch will spread top-level directories,
so as long as /home is a mountpoint, we're fine.

For more generalality, yes, I think a new chattr flag on the
parent directory which says "spread my subdirectories out"
would be a good solution.
