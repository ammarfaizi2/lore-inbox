Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291801AbSBHUlA>; Fri, 8 Feb 2002 15:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291802AbSBHUkq>; Fri, 8 Feb 2002 15:40:46 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:9485 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S291801AbSBHUjc>;
	Fri, 8 Feb 2002 15:39:32 -0500
Date: Fri, 8 Feb 2002 13:38:51 -0700
From: yodaiken@fsmlabs.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: nigel@nrg.org, Christoph Hellwig <hch@ns.caldera.de>,
        Ingo Molnar <mingo@elte.hu>, yodaiken <yodaiken@fsmlabs.com>,
        Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@zip.com.au>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020208133851.B11590@hq.fsmlabs.com>
In-Reply-To: <200202081231.g18CV7e31341@ns.caldera.de> <Pine.LNX.4.40.0202080838230.3883-100000@cosmic.nrg.org> <5.1.0.14.2.20020208174632.00b0dad0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <5.1.0.14.2.20020208174632.00b0dad0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Fri, Feb 08, 2002 at 08:14:32PM +0000
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 08:14:32PM +0000, Anton Altaparmakov wrote:
> At 16:51 08/02/02, Nigel Gamble wrote:
> >Read-write semaphores should never be used.  As others have pointed out,
> >they cause really intractable priority inversion problems (because a
...
> 
> Read-write semaphores have their use and the current Linux implementation 

Here's the context: the preemption patch puts pressure on Linux to move
from BKL to semaphores and then it will be seen that semaphores need
to have dynamic priority inherit to sort-of-work, and then it will be seen
that read/write lock is a problem! 


> The value of allowing multiple cpus to read the same data simultaneously by 
> far offsets the priority problems IMVHO. At least the way I am using rw 
> semaphores in ntfs it is. Readlocks are grabbed loads and loads of times to 
> serialize meta data access in the page cache while writelocks are a minute 
> number in comparison and because the data required to be accessed may not 

this is absolutely correct. However, once the decision has been made or
fallen into to go to a priority inherit scheme, Linux will find itself
in the same bind as Solaris.

> be cached in memory (page cache page is not read in, is swapped out, 
> whatever) a disk access may be required which means a rw spin lock is no 
> good. In fact ntfs would be the perfect candidate for automatic rw combi 
> locks where the locking switches from spinning to sleeping if the code path 
> reaches a disk access. I can't use a manually controlled lock as the page 

Seem like the lock is simply grabbed way to far up. 


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

