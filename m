Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314957AbSECSJ2>; Fri, 3 May 2002 14:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314959AbSECSJ1>; Fri, 3 May 2002 14:09:27 -0400
Received: from dsl-213-023-039-070.arcor-ip.net ([213.23.39.70]:52648 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314957AbSECSJ0>;
	Fri, 3 May 2002 14:09:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Date: Fri, 3 May 2002 20:08:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020503103813.K11414@dualathlon.random> <E173g7P-0002J6-00@starship> <20020503185806.A1396@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173hTx-0002u6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 May 2002 18:58, Andrea Arcangeli wrote:
> On Fri, May 03, 2002 at 06:41:15PM +0200, Daniel Phillips wrote:
> > On Friday 03 May 2002 18:20, Andrea Arcangeli wrote:
> > > On Fri, May 03, 2002 at 06:02:18PM +0200, Daniel Phillips wrote:
> > > > and solves 75% of the problem.  It's not just ia32 numa that will benefit
> > > > from it.  For example, MIPS supports 16K pages in software, which will
> > > 
> > > the whole change would be specific to ia32, I don't see the connection
> > > with mips. There would be nothing to share between ia32 2M pages and
> > > mips 16K pages.
> > 
> > The topic here is 'page clustering'.  The idea is to use one struct page for
> > every four 4K page frames on ia32.
> 
> ah ok, I meant physical hardware pages. physical hardware pages should
> be doable without common code changes, a software PAGE_SIZE or the
> PAGE_CACHE_SIZE raises non trivial problems instead.

Yes, it's not too bad though.  In the swap-in path, the locking would be against
mem_map + (pfn >> 2).  The four pages don't have to be read in and valid all at
the same time - it's ok to take multiple faults on the cluster, not recommended,
but ok.  In the swap-out path, all four page frames have to be swapped out and
invalidated at the same time.

-- 
Daniel
