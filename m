Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSHJS6G>; Sat, 10 Aug 2002 14:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSHJS6G>; Sat, 10 Aug 2002 14:58:06 -0400
Received: from dsl-213-023-020-194.arcor-ip.net ([213.23.20.194]:17048 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317251AbSHJS6F>;
	Sat, 10 Aug 2002 14:58:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: ebiederm@xmission.com (Eric W. Biederman), Andrew Morton <akpm@zip.com.au>
Subject: Re: large page patch (fwd) (fwd)
Date: Sat, 10 Aug 2002 20:59:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, frankeh@watson.ibm.com,
       davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
References: <E17dBZN-0001Ng-00@starship> <3D543645.8EBD2C36@zip.com.au> <m1ofcar2y1.fsf@frodo.biederman.org>
In-Reply-To: <m1ofcar2y1.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dbSa-0001aB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 August 2002 20:20, Eric W. Biederman wrote:
> Andrew Morton <akpm@zip.com.au> writes:
> > The other worry is the ZONE_NORMAL space consumption of pte_chains.
> > We've halved that, but it will still make high sharing levels
> > unfeasible on the big ia32 machines.  We are dependant upon large
> > pages to solve that problem.  (Resurrection of pte_highmem is in
> > progress, but it doesn't work yet).
> 
> There is a second method to address this.  Pages can be swapped out
> of the page tables and still remain in the page cache, the virtual
> scan does this all of the time.  This should allow for arbitrary
> amounts of sharing.  There is some overhead, in faulting the pages
> back in but it is much better than cases that do not work.  A simple
> implementation would have a maximum pte_chain length.

Oh gosh, nice point.  We could put together a lovely cooked benchmark where 
copy_page_range just fails to copy all the mmap pages, which are most of them 
in the bash test.

-- 
Daniel
