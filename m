Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314620AbSECQZK>; Fri, 3 May 2002 12:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314651AbSECQZJ>; Fri, 3 May 2002 12:25:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11032 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314620AbSECQZJ>; Fri, 3 May 2002 12:25:09 -0400
Date: Fri, 3 May 2002 18:25:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <20020503182550.D14505@dualathlon.random>
In-Reply-To: <20020503175819.A14505@dualathlon.random> <4058482389.1020417045@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 09:10:46AM -0700, Martin J. Bligh wrote:
> > Another interesting problem is that 'struct page *' will be as best a
> > cookie, not a valid pointer anymore, not sure what's the best way to
> > handle that. Working with pfn would be cleaner rather than working with
> > a cookie (somebody could dereference the cookie by mistake thinking it's
> > a page structure old style), but if __alloc_pages returns a pfn a whole
> > lot of kernel code will break.
> 
> Yup, a physical address pfn would probably be best.
> 
> (such as tlb size, which is something stupid like 4 pages, IIRC)

you recall correcty the mean :), it's 8 for data and 2 for instructions.
But I don't think the tlb is the problem, potentially it's a big win for
the big apps like database, more ram addressed via tlb and faster
pagetable lookups, it's the I/O granularity for the pageins that is
probably the most annoying part. Even if you've a fast disk, 2M instead
of kbytes is going to make difference, as well as the fact a 4M per page
and the bh on the pagecache would waste quite lots of ram with small
files.

> > it has 8 pages for data and 2 for instructions, that's 16M data and 4M
> > of instructions with PAE
> 
> What is "it", a P4? I think the sizes are dependant on which chip you're

I didn't read if P4 changes that, nor I checked the athlon yet, I read
it in the usual and a bit old system programmin manual 3.

> using. The x440 has the P4 chips, but the NUMA-Q is is P2 or P3 (even
> PPro for the oldest ones, but those don't work at the moment with Linux
> on multiquad).

that's the P6 family, so the PPro P2 P3 all included (only P5 excluded).

Andrea
