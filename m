Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314201AbSEBBAg>; Wed, 1 May 2002 21:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314204AbSEBBAf>; Wed, 1 May 2002 21:00:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26944 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314201AbSEBBAf>; Wed, 1 May 2002 21:00:35 -0400
Date: Thu, 2 May 2002 03:01:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502030113.Q11414@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 10:20:11AM +1000, Anton Blanchard wrote:
>  
> > so ia64 is one of those archs with a ram layout with huge holes in the
> > middle of the ram of the nodes? I'd be curious to know what's the
> > hardware advantage of designing the ram layout in such a way, compared
> > to all other numa archs that I deal with. Also if you know other archs
> > with huge holes in the middle of the ram of the nodes I'd be curious to
> > know about them too. thanks for the interesting info!
> 
> >From arch/ppc64/kernel/iSeries_setup.c:
> 
>  * The iSeries may have very large memories ( > 128 GB ) and a partition
>  * may get memory in "chunks" that may be anywhere in the 2**52 real
>  * address space.  The chunks are 256K in size.
> 
> Also check out CONFIG_MSCHUNKS code and see why I'd love to see a generic
> solution to this problem.

is this machine a numa machine? If not then discontigmem will work just
fine. also it's a matter of administration, even if it's a numa machine
you can use it just optimally with discontigmem+numa. Regardless of what
we do if the partitioning is bad the kernel will do bad. If you create
zillon discontigous nodes of 256K each, you'd need waste memory to
handle them regardless of nonlinear or discontigmem (with discontigmem
you will waste more memory than nonlinear yes, exactly because it's more
powerful, but I think a machine with an huge lot of non contigous 256K
chunks is misconfigured, it's like if you pretend to install linux on a
machine after you partitioned the HD with thousand of logical volumes
large 256K each [for the sake of this example let's assume there are
more than 256LV available in LVM], a sane partitioning requires you to
have at least a partition for /usr large 1 giga, depends what you're
doing of course, but requiring sane partitioning it's an admin problem
not a kernel problem IMHO).

Andrea
