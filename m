Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319534AbSH2XCS>; Thu, 29 Aug 2002 19:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319536AbSH2XCK>; Thu, 29 Aug 2002 19:02:10 -0400
Received: from holomorphy.com ([66.224.33.161]:45445 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319534AbSH2XCC>;
	Thu, 29 Aug 2002 19:02:02 -0400
Date: Thu, 29 Aug 2002 16:06:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] low-latency zap_page_range()
Message-ID: <20020829230622.GJ888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <3D6E844C.4E756D10@zip.com.au> <1030653602.939.2677.camel@phantasy> <3D6E8B25.425263D5@zip.com.au> <20020829213830.GG888@holomorphy.com> <akm7me$3s1$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <akm7me$3s1$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 10:37:02PM +0000, Linus Torvalds wrote:
> You will NOT.
> The page_table_lock protects against page stealing of the VM and
> concurrent page-faults, nothing else.  There is no way you can get
> contention on it under any reasonable load that doesn't involve heavy
> out-of-memory behaviour, simply because
>  - the lock is per-mm
>  - all "regular" paths that care about this also get the mmap semaphore
> In short, that spinlock has _zero_ scalability impact.  You can
> theoretically get contention on it without memory pressure only by
> having hundreds of threads page-faulting at the same time (getting a
> read-lock on the mmap semaphore), but by then your performance has
> nothing to do with the spinlock, and everything to do with the page
> faults themselves. 
> (In fact, I can almost guarantee that most of the long hold-times are
> for exit(), not for munmap().  And in that case the spinlock cannot get
> any non-pagestealer contention at all, since nobody else is using the
> MM)

All I have to go on is a report this has happened and a low-priority
task to investigate it at some point in the future. I'll send you data
either demonstrating it or exonerating it when I eventually get to it.


Cheers,
Bill
