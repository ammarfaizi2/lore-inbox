Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289182AbSAQPq3>; Thu, 17 Jan 2002 10:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSAQPqT>; Thu, 17 Jan 2002 10:46:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25898 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289185AbSAQPqD>; Thu, 17 Jan 2002 10:46:03 -0500
Date: Thu, 17 Jan 2002 16:45:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020117164515.N4847@athlon.random>
In-Reply-To: <m3u1tll6pb.fsf@linux.local> <Pine.LNX.4.21.0201171206350.1051-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201171206350.1051-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Jan 17, 2002 at 12:14:13PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 12:14:13PM +0000, Hugh Dickins wrote:
> On Thu, 17 Jan 2002, Christoph Rohland wrote:
> > On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> > > They were running out of pagetables, mapping 1G per-task (shm for
> > > example) will overflow the lowmem zone with PAE with some houndred
> > > tasks in the system. They were pointing the finger at the VM but the
> > > VM was just doing the very right thing to do.
> > 
> > This lets me think about putting the swap vector of shmem into highmem
> > also. These can get big on highend servers and exactly these servers
> > tend to use a lot of shared mem.
> 
> Yes, good idea.
> 
> But people should realize that moving page tables and other such
> structures into not-always-mapped highmem will make them harder to
> access with kernel debuggers - I think those will want some changes.

the debugging prospective is probably the one I care less (you can
always drop a __GFP_HIGHMEM into the right alloc_pages to get the memory
direct mapped) that's most of the time a one liner in just one place.

Here I'd care more about the fact if it's really needed in real life or
not, if kmaps would be zero cost it would be probably ok anyways (modulo
increase of code complexity), but kmaps are lightweight but not zero
cost :).

Andrea
