Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132127AbRBRA4c>; Sat, 17 Feb 2001 19:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132351AbRBRA4X>; Sat, 17 Feb 2001 19:56:23 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:30416 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132127AbRBRA4M>; Sat, 17 Feb 2001 19:56:12 -0500
Message-ID: <3A8F1EF0.EC1CEEE5@uow.edu.au>
Date: Sun, 18 Feb 2001 12:01:36 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Widmann <thomas.widmann@icn.siemens.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP: bind process to cpu
In-Reply-To: <3A8E8C8F.A2A9E69E@uow.edu.au> <BGEDIODHBENLENEMBEPAIEDFCAAA.thomas.widmann@icn.siemens.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Widmann wrote:
> ...
> * Andrew Morton wrote:
> 
> >       http://www.uow.edu.au/~andrewm/linux/#cpus_allowed
> >
> > You just write a bitmask into it.
> 
> Thanks for this information. I patched my the kernel with it.
> After rebooting with the new kernel i can see the bitmask
> for every process running on my server.
> 
> #cat /proc/1310/cpus_allowed
> ffffffff
> 
> Now, if i want to run this process on only one cpu, i which way
> do i have to set the bitmask ?
> Let's say, i want to run it on cpu0. how look's the bitmask ?

Each bit corresponds to a logical CPU on which the task
is permitted to run.  So 1->CPU0, 2->CPU1, 5->CPU0+CPU2, etc.

But it does seem there are problems with the scheduler
which occur when cpus_allowed it not all-ones.  I didn't
observe any problems in the 1-2 hours testing which I
needed that patch for, so it should be OK for experimentation
purposes..

-
