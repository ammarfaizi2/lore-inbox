Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSK0T2z>; Wed, 27 Nov 2002 14:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSK0T2z>; Wed, 27 Nov 2002 14:28:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:45239 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264706AbSK0T2y>;
	Wed, 27 Nov 2002 14:28:54 -0500
Message-ID: <3DE51EA7.5C971354@digeo.com>
Date: Wed, 27 Nov 2002 11:36:07 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page walker bugfix (was: 2.5.49-mm2)
References: <3DE48C4A.98979F0C@digeo.com> <20021127171017.H5263@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2002 19:36:07.0218 (UTC) FILETIME=[3B0CF120:01C2964C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> Hi Andrew,
> hi list readers,
> 
> On Wed, Nov 27, 2002 at 01:11:38AM -0800, Andrew Morton wrote:
> > .. Some code from Ingo Oeser to start using the expanded and cleaned up
> >   user pagetable walker code.  This affects the st and sg drivers; I'm
> >   not sure of the testing status of this?
> 
> The testing status is: None, but it compiles.
> 
> The sg-driver maintainer has already said he does some testing
> and the author of the previous code in st.c was positive about
> using these features. That's why I've choosen these as my "victims".

Yes, Doug Gilbert will help us out here.

> I also found a locking bug in walk_user_pages() in case of OOM or
> SIGBUS. Fixed by the attached patch.
> 

Thanks.

We'll need to be concentrating on the shared pagetable code for
a while, and your patch overlaps with that.  So I've swapped the
applying order (you come second) and I'll probably break your
stuff out separately for a while so Dave can generate clean patches.

When mm3 emerges could you please check mm/mmap.c around here:

        vma = NULL; /* needed for out-label */

I may have misplaced that one...
