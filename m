Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTAFMIO>; Mon, 6 Jan 2003 07:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbTAFMIO>; Mon, 6 Jan 2003 07:08:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:32704 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265008AbTAFMIM>;
	Mon, 6 Jan 2003 07:08:12 -0500
Message-ID: <3E19739F.84C57EFC@digeo.com>
Date: Mon, 06 Jan 2003 04:16:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Joe Korty <joe.korty@ccur.com>, Andreas Dilger <adilger@clusterfs.com>,
       rusty@rustcorp.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, hch@sgi.com
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
References: <3E16C171.BFEA45AE@digeo.com> <1041855042.2690.2.camel@sisko.scot.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2003 12:16:32.0491 (UTC) FILETIME=[7302FBB0:01C2B57D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Sat, 2003-01-04 at 11:11, Andrew Morton wrote:
> 
> > This is because of differences in how sync() is handled between 2.4.20's
> > ext3 and 2.4.21-pre2's.
> >
> > 2.4.21-pre2:
> >
> >   sync() will start the commit, and will wait on it.  So you know that
> >   when it returns, everything which was dirty is now tight on disk.
> >
> > So yes, running a looping sync while someone else is writing stuff
> > will take much longer in 2.4.21-pre2, because that kernel actually
> > waits on the writeout.
> 
> Actually, I'm wondering if we should back that particular bit out.  For
> a user with a hundred mounted filesystems, syncing each one in order,
> sequentially, is going to suck (and we don't currently have a simple way
> in 2.4 to detect which syncs are on separate spindles and so can be
> parallelised.)
> 

Well personally I prefer slow-and-safe.  But we could make 2.4
do what 2.5 is doing - one pass through the superblocks to start
the syncs and a second pass to wait on them all.

This is fragile stuff though....
