Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbSJUV1m>; Mon, 21 Oct 2002 17:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbSJUV1m>; Mon, 21 Oct 2002 17:27:42 -0400
Received: from packet.digeo.com ([12.110.80.53]:41369 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261703AbSJUV1l>;
	Mon, 21 Oct 2002 17:27:41 -0400
Message-ID: <3DB472B6.BC5B8924@digeo.com>
Date: Mon, 21 Oct 2002 14:33:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
References: <3DB46DFA.DFEB2907@digeo.com> <308170000.1035234988@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 21:33:42.0110 (UTC) FILETIME=[86CF47E0:01C27949]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >> My big NUMA box went OOM over the weekend and started killing things
> >> for no good reason (2.5.43-mm2). Probably running some background
> >> updatedb for locate thing, not doing any real work.
> >>
> >> meminfo:
> >>
> >
> > Looks like a plain dentry leak to me.  Very weird.
> >
> > Did the machine recover and run normally?
> 
> Nope, kept OOMing and killing everything .

Something broke.

> > Was it possible to force the dcache to shrink? (a cat /dev/hda1
> > would do that nicely)
> 
> Well, I didn't try that, but even looking at man pages got oom killed,
> so I guess not ... were you looking at the cat /dev/hda1 to fill pagecache
> or something? I have 16Gb of highmem (pretty much all ununsed) so
> presumably that'd fill the highmem first (pagecache?)

Blockdevices only use ZONE_NORMAL for their pagecache.  That cat will
selectively put pressure on the normal zone (and DMA zone, of course).
 
> > Is it reproducible?
> 
> Will try again. Presumably "find /" should do it? ;-)

You must have a lot of files.

Actually, I expect a `find /' will only stat directories,
whereas an `ls -lR /' will stat plain files as well.  Same
thing for dcache, but the ls will push the icache harder.

I don't know if updatedb stats regular files.  Presumably not.
