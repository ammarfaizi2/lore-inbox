Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314503AbSECQDm>; Fri, 3 May 2002 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314511AbSECQDl>; Fri, 3 May 2002 12:03:41 -0400
Received: from dsl-213-023-039-070.arcor-ip.net ([213.23.39.70]:31655 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314503AbSECQDk>;
	Fri, 3 May 2002 12:03:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Date: Fri, 3 May 2002 18:02:18 +0200
X-Mailer: KMail [version 1.3.2]
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020503103813.K11414@dualathlon.random> <4055279713.1020413842@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173fVi-0002Ic-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 May 2002 17:17, Martin J. Bligh wrote:
> Andrea apparently wrote:
> > Ah, and of course you could also use 2M pagetables by default to make it
> > more usable but still you would run in some huge ram wastage in certain
> > usages with small files, huge pageins and reads swapout and swapins,
> > plus it wouldn't be guaranteed to be transparent to the userspace
> > binaries (for istance mmap offset fields would break backwards
> > compatibility on the required alignment, that's probably the last
> > problem though). Despite its also significant drawbacks and the
> > complexity of the change, probably the 4M pagetables would be the saner
> > approch to manage more efficiently 64G with only a 800M kernel window.
> 
> Though that'd reduce the size of some of the structures, I'd still
> have other concerns (such as tlb size, which is something stupid
> like 4 pages, IIRC), and the space wastage you mentioned. Page 
> clustering is probably a more useful technique - letting the existing
> control structures control groups of pages. For example, one struct
> page could control aligned groups of 4 4K pages, giving us an 
> effective page size of 16K from the management overhead point of
> view (swap in and out in 4 page chunks, etc).

IMHO, this will be a much easier change than storing mem_map in highmem,
and solves 75% of the problem.  It's not just ia32 numa that will benefit
from it.  For example, MIPS supports 16K pages in software, which will
take a lot of load off the tlb.  According to Ralf, there are benefits
re virtual aliasing as well.

-- 
Daniel
