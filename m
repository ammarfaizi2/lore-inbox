Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289173AbSAQPaT>; Thu, 17 Jan 2002 10:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289170AbSAQPaD>; Thu, 17 Jan 2002 10:30:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20008 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289139AbSAQP3p>; Thu, 17 Jan 2002 10:29:45 -0500
Date: Thu, 17 Jan 2002 16:30:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020117163021.L4847@athlon.random>
In-Reply-To: <20020116185814.I22791@athlon.random> <m3u1tll6pb.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <m3u1tll6pb.fsf@linux.local>; from cr@sap.com on Thu, Jan 17, 2002 at 09:31:12AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 09:31:12AM +0100, Christoph Rohland wrote:
> Hi Andrea,
> 
> On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> > They were running out of pagetables, mapping 1G per-task (shm for
> > example) will overflow the lowmem zone with PAE with some houndred
> > tasks in the system. They were pointing the finger at the VM but the
> > VM was just doing the very right thing to do.
> 
> This lets me think about putting the swap vector of shmem into highmem
> also. These can get big on highend servers and exactly these servers
> tend to use a lot of shared mem.
> 
> What do you think?

How much allocated shm do you need to fill 800mbyte of normal zone with
the shm swap vector?

(btw, I suspect allocating one page at offset 4G in every shmfs file
could make the overhead per page of shm to increase)

But in real life I really don't expect problems here, one left page of
the vector holds 1024 swap entries, so the overhead is of the order of
1/1000. On the top of my head (without any precise calculation) 64G of
shm would generate stuff of the order of some houndred mbytes of ram
(please correct me if I'm wrong of course).  The malicious case of all
files with one page mapped at the very end, doesn't sounds realistic
scenario either. Comments?

Andrea
