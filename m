Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTBJH73>; Mon, 10 Feb 2003 02:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTBJH73>; Mon, 10 Feb 2003 02:59:29 -0500
Received: from [195.223.140.107] ([195.223.140.107]:51841 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264654AbTBJH71>;
	Mon, 10 Feb 2003 02:59:27 -0500
Date: Mon, 10 Feb 2003 09:08:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Jakob Oestergaard <jakob@unthought.net>, Andrew Morton <akpm@digeo.com>,
       David Lang <david.lang@digitalinsight.com>, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210080858.GM31401@dualathlon.random>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com> <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E47579A.4000700@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 06:41:14PM +1100, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >On Mon, Feb 10, 2003 at 03:58:26PM +1100, Nick Piggin wrote:
> >
> >>Jakob Oestergaard wrote:
> >>
> >>
> >>>On Sun, Feb 09, 2003 at 08:33:43PM -0800, Andrew Morton wrote:
> >>>
> >>>
> >>>>David Lang <david.lang@digitalinsight.com> wrote:
> >>>>
> >>>>
> >>>>>note that issuing a fsync should change all pending writes to 
> >>>>>'syncronous'
> >>>>>as should writes to any partition mounted with the sync option, or 
> >>>>>writes
> >>>>>to a directory with the S flag set.
> >>>>>
> >>>>>
> >>>>We know, at I/O submission time, whether a write is to be waited upon. 
> >>>>That's in writeback_control.sync_mode.
> >>>>
> >>>>That, combined with an assumption that "all reads are synchronous" would
> >>>>allow the outgoing BIOs to be appropriately tagged.
> >>>>
> >>>>
> >>>This may be a terribly stupid question, if so pls. just tell me  :)
> >>>
> >>>I assume read-ahead requests go elsewhere?  Or do we assume that someone
> >>>is waiting for them as well?
> >>>
> >>>If we assume they are synchronous, that would be rather unfair
> >>>especially on multi-user systems - and the 90% accuracy that Rik
> >>>suggested would seem exaggerated to say the least (accuracy would be
> >>>more like 10% on a good day).
> >>>
> >>>
> >>Remember that readahead gets scaled down quickly if it isn't
> >>getting hits. It is also likely to be sequential and in the
> >>track buffer, so it is a small cost.
> >>
> >>Huge readahead is a problem however anticipatory scheduling
> >>will hopefully allow good throughput for multiple read streams
> >>without requiring much readahead.
> >>
> >
> >the main purpose of readahead is to generate 512k scsi commands when you
> >read a file with a 4k user buffer, anticipatory scheduling isn't very
> >related to readahead.
> >
> You seem to be forgetting things like seek time.

I didn't say it's the only purpose. Of course there's no hope for
merging in the metadata dependent reads of the fs where anticipatory
scheduling does its best, and infact they don't even attempt to do any
readhaead.  BTW, one thing that should definitely do readhaead and it's
not doing that (at least in 2.4) is the readdir path, again to generate
big commands, no matter the seeks.  It was lost with the directory in
pagecache.

Andrea
