Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSEVUay>; Wed, 22 May 2002 16:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSEVUax>; Wed, 22 May 2002 16:30:53 -0400
Received: from holomorphy.com ([66.224.33.161]:7061 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S312254AbSEVUaw>;
	Wed, 22 May 2002 16:30:52 -0400
Date: Wed, 22 May 2002 13:30:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <20020522203024.GZ2035@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	"M. Edward Borasky" <znmeb@aracnet.com>,
	linux-kernel@vger.kernel.org, andrea@suse.de, riel@surriel.com,
	akpm@zip.com.au
In-Reply-To: <E17AaR0-0002QM-00@the-village.bc.nu> <Pine.LNX.4.33.0205221048570.23621-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 11:08:27AM -0700, Linus Torvalds wrote:
> The solution really is a "don't do it then" kind of thing. If you have 
> 5000 processes that all want to map a big shared memory area, and you 
> don't want to upgrade your CPU's, it's a _whole_ lot easier to just have a 
> magic "map_large_page()" system call, and start using the 2MB page support 
> of the x86.

map_large_page() sounds decent, though I don't really know how easy
it'll be to get apps to cooperate. I suspect it's easier when the
answer is "the app crashed" as opposed to "the kernel crashed".

Okay, someone told me "upgrade my cpu", and even though it was you,
here it is:

It still requires the cooperation of userspace to prevent the system from
being taken down. At the very least resource accounting and prevention
of the deadlock based on it are additionally required. Furthermore,
64-bit address spaces do not reduce the sizes of pagetables, and they
face the same memory exhaustion issues as 32-bit machines in the presence
of shared mappings performed by large numbers of tasks. A larger pagesize
just increases the number of processes and/or the size of the mapping
required to trigger this, where the size of the mapping is likely the
compensator on 64-bit machines. Last, but not least, "upgrade your cpu"
is a very strange (and perplexing) answer to a software problem, and
one with several well-known techniques for solving it, and it's
certainly not solved by upgrading the cpu. mmap a 16TB space in 4MB
pages with 8-byte pte's in 4K tasks on a 64GB 64-bit machine, with your
favorite number of cpu's (the cpu count is irrelevant; assume 1 cpu per
task if you wish, I certainly can't afford that), and it happens again.
As far as I can tell, it's only worse on 64-bit machines, and that has
motivated many of the 64-bit cpu vendors to use either pagetables which
are not radix trees or software-fill TLB's.


Cheers,
Bill
