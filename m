Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315567AbSECG2J>; Fri, 3 May 2002 02:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315568AbSECG2I>; Fri, 3 May 2002 02:28:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29986 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315567AbSECG2H>; Fri, 3 May 2002 02:28:07 -0400
Date: Fri, 3 May 2002 08:28:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503082849.V11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com> <E173MEW-00027y-00@starship> <20020502193847.GM32767@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 12:38:47PM -0700, William Lee Irwin III wrote:
> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> >>> Dropping the loop when discontigmem is enabled is much more interesting
> >>> optimization of course.
> 
> On Thursday 02 May 2002 21:19, William Lee Irwin III wrote:
> >> Absolutely; I'd be very supportive of improvements for this case as well.
> >> Many of the systems with the need for discontiguous memory support will
> >> also benefit from parallelizations or other methods of avoiding references
> >> to remote nodes/zones or iterations over all nodes/zones.
> 
> On Thu, May 02, 2002 at 09:27:00PM +0200, Daniel Phillips wrote:
> > Which loop in which function are we talking about?
> 
> I believe it's just for_each_zone() and for_each_pgdat(), and their
> usage in general. I brewed them up to keep things clean (and by and
> large they produced largely equivalent code to what preceded it), but
> there's no harm in conditionally defining them. I think it's even
> beneficial, since things can use them without concerning themselves
> about "will this be inefficient for the common case of UP single-node
> x86?" and might also have the potential to remove some other #ifdefs.
> 
> In the more general case, avoiding an O(fragments) (or sometimes even
> O(mem)) iteration in favor of, say, O(lg(fragments)) or O(cpus)
> iteration when fragments is very large would be an excellent optimization.
> 
> Andrea, if the definitions of these helpers start getting large, I think
> it would help to move them to a separate header. akpm has already done so

sure for 2.5. However for 2.4 still I'm not very excited about those
optimizations getting in now, at least until some of the other more
important pending patches are included. I don't care if those
optimizations are obvious or not, it's just more work for Marcelo and I
prefer him to spend all his cpu time on things that matters, not on
unnecessary cleanups (at least until there will be pending things that
matters, if there aren't it's fine to work on
microoptimizations/cleanups), and nevertheless it would generate rejects
and more work for me too but I have ways that reduces my overhead,
so my reject solving work would be really my last concern.

> with page->flags manipulations in 2.5, and it seems like it wouldn't
> do any harm to do something similar in 2.4 either. Does that sound good?
> 
> Cheers,
> Bill


Andrea
