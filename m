Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262077AbSJDX3k>; Fri, 4 Oct 2002 19:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262079AbSJDX3k>; Fri, 4 Oct 2002 19:29:40 -0400
Received: from packet.digeo.com ([12.110.80.53]:49382 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262077AbSJDX3j>;
	Fri, 4 Oct 2002 19:29:39 -0400
Message-ID: <3D9E25A7.B3E13D8@digeo.com>
Date: Fri, 04 Oct 2002 16:35:03 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Janet Morgan <janetmor@us.ibm.com>
CC: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] direct-IO API change
References: <3D9E1847.F6DDA3AE@digeo.com> <Pine.LNX.4.44.0210041621170.2526-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2002 23:35:03.0604 (UTC) FILETIME=[A9E55740:01C26BFE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 4 Oct 2002, Andrew Morton wrote:
> >
> > Because the file handle which we have is for /dev/raw/raw0,
> > not for /dev/hda1.
> >
> > The raw driver binds to major/minor, not a file*.  I considered
> > changing that (change userspace to pass the open fd).  But didn't.
> 
> Ok. I'd really rather have a cleaner internal API and break the raw driver
> for a while, than have a silly API just because the raw driver uses it.

OK - bust it.

> Especially since I thought that O_DIRECT on the regular file (or block
> device) performed about as well as raw does anyway these days? Or is that
> just one of my LSD-induced flashbacks?
> 

Now we're not holding i_sem for O_DIRECT writes to blockdevs,
I don't think the raw driver offers any advantages at all.  It's
a compatibility thing to save people from having to add "|O_DIRECT" to
their source and then typing `ln -s /dev/hda1 /dev/raw/raw0'.

I think we can probably delete the raw driver.  But I've Cc'ed Janet
and Badari to find out why that's wrong.
