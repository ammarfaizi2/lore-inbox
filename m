Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbSIRM1G>; Wed, 18 Sep 2002 08:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266418AbSIRM1G>; Wed, 18 Sep 2002 08:27:06 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:42793 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262687AbSIRM1F>;
	Wed, 18 Sep 2002 08:27:05 -0400
Date: Wed, 18 Sep 2002 14:32:06 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918123206.GA14595@win.tue.nl>
References: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 01:06:11AM +0200, Ingo Molnar wrote:

> the underlying problem is very hard - since get_pid() not only has to take
> PIDs into account, but TGIDs, session IDs and process groups as well.
> 
> Ie. even in the most hopeless situation, if there are 999,999 PIDs
> allocated already, it takes less than 10 usecs to find and allocate the
> remaining one PID. The common fastpath is a couple of instructions only.  
> The overhead of skipping over continuous regions of allocated PIDs scales
> gracefully with the number of bits to be skipped, from 0 to 10 usecs.
> 
> memory footprint of the new PID allocator scales dynamically with
> /proc/sys/kernel/pid_max: the default 32K PIDs cause a 4K allocation, a
> pid_max of 1 million causes a 128K footprint. The current absolute limit
> for pid_max is 4 million PIDs - this does not cause any allocation in the
> kernel, the bitmaps are demand-allocated runtime. The pidmap table takes
> up 512 bytes.

I still don't understand the current obsession with this stuff.
It is easy to have pid_max 2^30 and a fast algorithm that does not
take any more kernel space.

It seems to me you are first creating an unrealistic and unfavorable
situation (put pid_max at some artificially low value, starting a
lot of tasks and saying: look! the algorithm is quadratic!) and
then solve the problem that you thus invented yourself.

Please leave pid_max large.

Andries
