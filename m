Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291630AbSBAJSe>; Fri, 1 Feb 2002 04:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291624AbSBAJR6>; Fri, 1 Feb 2002 04:17:58 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:9947 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S291634AbSBAJRr>; Fri, 1 Feb 2002 04:17:47 -0500
Date: Fri, 1 Feb 2002 03:17:44 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Continuing /dev/random problems with 2.4
Message-ID: <20020201031744.A32127@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I've switched to using 2.4 in situations where /dev/random is
heavily used, I've been seeing more and more of the running issue with
/dev/random.

After a few days of occasional use from sshd and our own cryptographic
purposes, we're seeing entropy_avail go to 0 and requests to /dev/random
block.  The processes that block remain killable, but entropy no longer
appears until a reboot is performed.

Robert Love did some /dev/random maintenance a while back, and his
netdev patches are essential for low disk-activity systems.  While his
patches have helped the situation greatly, it appears that there is
something in the random code that can cause extraction of entropy to
permanently exhaust the pool.  Some kind of issue when entropy is near
zero at the time of a read?

In any case, this is becoming a major pain throughout the many systems
and distibution mechanisms that we're running and at this point I think
it really should be looked at.

I will try to take a look at the code at some point, but I'd really
appreciate it if someone with some previous knowledge of this area of
the kernel could take a look.

This problem has occurred on many many different SMP configurations
(varying procs, motherboards, SCSI, IDE, RAM, etc) for all of the 2.4
series, although Robert's much appreciated fixes a few revs ago helped
quite a bit.  Haven't been able to test on UP, since we're exclusively
SMP.

/dev/urandom is indeed an option for _some_ situations, but I'd rather
fix the problem for the good of everyone else, and I'd like to reap the
benefits of /dev/random vs. /dev/urandom.

Thanks much,
-- 
Ken.
brownfld@irridia.com

