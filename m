Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbTAFMHl>; Mon, 6 Jan 2003 07:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTAFMHl>; Mon, 6 Jan 2003 07:07:41 -0500
Received: from [81.2.122.30] ([81.2.122.30]:62468 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S263837AbTAFMHk>;
	Mon, 6 Jan 2003 07:07:40 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301061215.h06CFheY001499@darkstar.example.net>
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
To: sct@redhat.com (Stephen C. Tweedie)
Date: Mon, 6 Jan 2003 12:15:42 +0000 (GMT)
Cc: akpm@digeo.com, joe.korty@ccur.com, adilger@clusterfs.com,
       rusty@rustcorp.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, hch@sgi.com
In-Reply-To: <1041855042.2690.2.camel@sisko.scot.redhat.com> from "Stephen C. Tweedie" at Jan 06, 2003 12:10:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

What!?  I'm suprised that no userspace applications were broken by
sync returning before the data is safely on oxide, even though it
doesn't violate the POSIX spec.

What about userspace media-changers, (if such a thing exists)?
Presumably they would assume that they can eject the media after a sync.

I think sync should definitely wait until it's completed before it
returns.

John.
