Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265672AbSJXUwG>; Thu, 24 Oct 2002 16:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265673AbSJXUwG>; Thu, 24 Oct 2002 16:52:06 -0400
Received: from [195.223.140.120] ([195.223.140.120]:28234 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265672AbSJXUwF>; Thu, 24 Oct 2002 16:52:05 -0400
Date: Thu, 24 Oct 2002 22:41:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: chrisl@vmware.com
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021024204108.GU3354@dualathlon.random>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024191531.GD1398@vmware.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 12:15:32PM -0700, chrisl@vmware.com wrote:
> Yes, but even now days it will able to lockup machine by doing that.
> 
> Try the test bigmm program I attach to this mail. It will simulate vmware's
> memory mapping. It can easily lockup the machine even though there is
> enough disk space.
> 
> See the comment at the source for parameter. basically, if you want
> 3 virtual machine, each have 2 process, using 1 G ram each you can do:
> 
> bigmm -i 3 -t 2 -c 1024
> 
> I run it on two 4G and 8G smp machine. Both can dead lock if I mmap
> enough memory.

I run the above command on my laptop with 256M of ram and 1G of swap
with kde running (though idle) and the task was correctly killed:

Oct 24 22:29:32 x30 kernel: VM: killing process bigmm

the machine never deadlocked. Probably it's one of the oom deadlocks
that I fixed in my 2.4 -aa tree and that the oom killer heuristic in
mainline cannot figure out. Please try to reproduce with 2.4.20pre11aa1.
thanks.

> Prepare to reset the machine if you try that, you have been warned :-)

If you're running an oom deadlock prone kernel.

> > to discard those pages and invaliding those posted writes. At least
> > until a true solution will be available you should change vmware to
> > preallocate the file, then it will work fine because you will catch the
> > ENOSPC error during the preallocation. If you work on shmfs that will be
> > very quick indeed.
> 
> Yes, shmfs seems to be the only choice so far.

Agreed.

Andrea
