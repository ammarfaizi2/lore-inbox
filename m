Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310504AbSCXViG>; Sun, 24 Mar 2002 16:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311786AbSCXVh5>; Sun, 24 Mar 2002 16:37:57 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:56324 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S310504AbSCXVht>; Sun, 24 Mar 2002 16:37:49 -0500
Message-ID: <3C9E46BD.D0BEEB2A@zip.com.au>
Date: Sun, 24 Mar 2002 13:35:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Linus Torvalds <torvalds@transmeta.com>, yodaiken@fsmlabs.com,
        Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com>
	 from Linus Torvalds at "Mar 16, 2002 12:14:06 pm" <200203242112.WAA09406@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> ...
> So we have a "PAGE_SIZE" define all around the kernel. Keep that the
> same (for compatibility), but make a "REAL_PAGE_SIZE" that governs the
> loop that actually sets the page table (or tlb) entries.... Note that
> a first implementation may actually effectivly reduce the size of the
> TLB on machines with a software loaded TLB....
> 
> Why would I want this? Well, suppose I have a machine that unavoidably
> has to swap on some of its workload. In practise you will almost
> double the disk troughput by increasing the page size by a factor of
> two.

swapin and swapout already perform multipage clustering - you'd get
the same benefits from increasing SWAP_CLUSTER_MAX and page_cluster.

Which is a three-line patch.

Frankly, all the discussion I've seen about altering page sizes
threatens to add considerable complexity for very dubious gains.
The only place where I've seen a solid justification is for
scientific applications which have a huge working set, and need
large pages to save on TLB thrashing.

For everything else, I believe we can get the efficiencies
which we need by writing efficient code; no need to go playing
with page sizes.

If someone can point at a real-world workload and say "we suck",
and we can't fix that suckage without altering the page size then
would that person please come forth.
 
-
