Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSDVWvC>; Mon, 22 Apr 2002 18:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314887AbSDVWvC>; Mon, 22 Apr 2002 18:51:02 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:38667 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S314885AbSDVWu7>; Mon, 22 Apr 2002 18:50:59 -0400
Message-ID: <3CC493B1.E9877DB4@zip.com.au>
Date: Mon, 22 Apr 2002 15:50:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: locking in sync_old_buffers
In-Reply-To: <3CC48D51.3050506@us.ibm.com> <Pine.LNX.4.44.0204221525190.1235-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> >  >http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8/everything.patch.gz
> > Absolutely.  What else does it contain that I should watch out for?
> 
> Don't use it on a production machine, but since this is in the 2.5.x
> future, I'd love to hear about not just lock contention but also about
> whether you can see any problems under heavy load.
> 

It may choke under metadata-intensive workloads on really
large memory machines.  It works fine with 2.5 gigabyte x86,
but 16 gigs may cause problems.

This is because the dirty-memory balancing code doesn't know
that blockdev mappings are restricted to ZONE_NORMAL.  The
correct fix for that is, of course, to allow blockdev mappings
to use highmem.  That will require methodical picking away at
all the filesystems, and will take some time.

ext2 should be OK because much of its metadata (directories)
are in highmem at present.

-
