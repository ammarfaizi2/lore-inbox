Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSLFXY6>; Fri, 6 Dec 2002 18:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbSLFXY6>; Fri, 6 Dec 2002 18:24:58 -0500
Received: from [195.223.140.107] ([195.223.140.107]:21122 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265177AbSLFXY6>;
	Fri, 6 Dec 2002 18:24:58 -0500
Date: Sat, 7 Dec 2002 00:32:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206233243.GP4335@dualathlon.random>
References: <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <3DF034BB.D5F863B5@digeo.com> <20021206054804.GK1567@dualathlon.random> <3DF049F9.6F83D13@digeo.com> <20021206145718.GL1567@dualathlon.random> <20021206151220.GD11023@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206151220.GD11023@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 07:12:20AM -0800, William Lee Irwin III wrote:
> On Fri, Dec 06, 2002 at 03:57:19PM +0100, Andrea Arcangeli wrote:
> > The only alternate fix is to be able to migrate pagetables (1st level
> > only, pte) and all the other highmem capable allocations at runtime
> > (pagecache, shared memory etc..). Which is clearly not possible in 2.5
> > and 2.4.
> 
> Actually it should not be difficult for 2.5, though it's not done now.

"difficult" is a relative word, nothing is difficult but everything is
difficult, depends the way you feel about it.

but note that even with rmap you don't know the pmd that points to the
pte that you want to relocate and for the anon pages you miss
information about mm and virtual address where those pages are
allocated, so basically rmap is useless for doing it, you need to do the
pagetable walking ala swap_out, in turn it's not easier at all in 2.5
than it could been in 2.4 (but of course this is a 2.5 thing only, I
just want to say that if it's not difficult in 2.5 it wasn't difficult
in 2.4 either).

Andrea
