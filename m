Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRIECPy>; Tue, 4 Sep 2001 22:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRIECPo>; Tue, 4 Sep 2001 22:15:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50102 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270134AbRIECPc>;
	Tue, 4 Sep 2001 22:15:32 -0400
Date: Tue, 4 Sep 2001 22:15:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Bryan Henderson <hbryan@us.ibm.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <OF40F28F05.61359C2E-ON87256ABD.006684BD@boulder.ibm.com>
Message-ID: <Pine.GSO.4.21.0109042208420.29803-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Bryan Henderson wrote:

> >Uh-oh...  How about shared mappings?
> 
> It's always shared mappings, isn't it?  :-)
> 
> Virtual memory access to the file is even easier, though.  A write in
> progress is an individual store to virtual memory.  The only way you could
> even see it is if a page fault is in progress.  So the most you would need
> to wait for in going into the hard "read only" state I defined is for any
> page I/O to complete.  And for the "no new writes" state, you just write
> protect all the pages (and any new ones that fault in too).

It's not that simple.  At the very least you need an equivalent of msync()
on each of these mappings before you can do anything of that kind.  In
effect, you are describing something very similar to revoke(2).  Which might
make sense, but I really doubt that it's a work for do_remount().

BTW, for real fun think of the situation when you have one of the swap
components in a regular file on your filesystem.  Do you seriously want
do_remount() to do automagical swapoff(2) on relevant swap components?

IMO it's a userland job.

