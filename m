Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268559AbTBWUG0>; Sun, 23 Feb 2003 15:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268564AbTBWUG0>; Sun, 23 Feb 2003 15:06:26 -0500
Received: from franka.aracnet.com ([216.99.193.44]:40387 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268559AbTBWUGX>; Sun, 23 Feb 2003 15:06:23 -0500
Date: Sun, 23 Feb 2003 12:16:26 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: object-based rmap and pte-highmem
Message-ID: <9540000.1046031384@[10.10.2.4]>
In-Reply-To: <b3b6u4$bt2$1@penguin.transmeta.com>
References: <96700000.1045871294@w-hlinder>
 <20030222192424.6ba7e859.akpm@digeo.com> <11090000.1046016895@[10.10.2.4]>
 <b3b6u4$bt2$1@penguin.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have a plan for that (UKVA) ... we reserve a per-process area with 
>> kernel type protections (either at the top of user space, changing
>> permissions appropriately, or inside kernel space, changing per-process
>> vs global appropriately). 
> 
> Nobody ever seems to have solved the threading impact of UKVA's. I told
> Andrea about it almost a year ago, and his reaction was "oh, duh!" and
> couldn't come up with a solution either.
> 
> The thing is, you _cannot_ have a per-thread area, since all threads
> share the same TLB.  And if it isn't per-thread, you still need all the
> locking and all the scalability stuff that the _current_ pte_highmem
> code needs, since there are people with thousands of threads in the same
> process. 
> 
> Until somebody _addresses_ this issue with UKVA, I consider UKVA to be a
> pipe-dream of people who haven't thought it through.

I don't see why that's an issue - the pagetables are per-process, not
per-thread.

Yes, that was a stalling point for sticking kmap in there, which was
amongst my original plotting for it, but the stuff that's per-process
still works. 

I'm not suggesting kmapping them dynamically (though it's rather like
permanent kmap), I'm suggesting making enough space so we have them all
there for each process all the time. None of this tiny little window
shifting around stuff ...

M.

