Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261355AbSJHREG>; Tue, 8 Oct 2002 13:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbSJHREG>; Tue, 8 Oct 2002 13:04:06 -0400
Received: from packet.digeo.com ([12.110.80.53]:39392 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261355AbSJHREF>;
	Tue, 8 Oct 2002 13:04:05 -0400
Message-ID: <3DA31152.FD9A819E@digeo.com>
Date: Tue, 08 Oct 2002 10:09:38 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jlnance@intrex.net
CC: linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 
 -  (NUMA))
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com> <3DA1D969.8050005@nortelnetworks.com> <3DA1E250.1C5F7220@digeo.com> <20021008023654.GA29076@netnation.com> <3DA247F3.B1150369@digeo.com> <20021008124948.GA1572@tricia.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 17:09:39.0347 (UTC) FILETIME=[7C6ABE30:01C26EED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@intrex.net wrote:
> 
> On Mon, Oct 07, 2002 at 07:50:27PM -0700, Andrew Morton wrote:
> 
> > I have the core code for ext3.  It's at
> > http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre10/ext3-reloc-page.patch
> > I never tested it, but that's a formality ;)
> >
> > It offers a simple ioctl to reloate a single page's worth of blocks.
> > It's fully journalled and recoverable, pagecache coherent, etc.
> > But the userspace application which calls that ioctl hasn't been
> > written.
> 
> Hi Andrew,
>     I decided not to let the fact that I have never written any FS code
> stand in the way of making suggestions :-) :-)
>     Do you think it would be better to make the defragmentation part of
> the normal operation of the FS rather than a seperate application.  For
> example, if you did a fragmentation check/fix on the last close of a file
> you would know that coherency issues were not going to be important.  It
> might also give you some way to determine which files were important to
> keep close together.
> 

Well the initial approach was to put the minimum functionality
in-kernel and drive it all from userspace.  I that proved to
be inadequate then the kernel-side might need to be grown.

I'd expect that a defrag would be a batch process which is done
during quiet times.  Although one _could_ have a `defragd' which
ticks along all the time I suppose.

A defragmentation algorithm probably would not be a "per file" thing;
it would need to gather a fair amount of state about the fs, or
at least an individual block group before starting to shuffle things.
