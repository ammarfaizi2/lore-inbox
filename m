Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265107AbSJROqB>; Fri, 18 Oct 2002 10:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265113AbSJROqA>; Fri, 18 Oct 2002 10:46:00 -0400
Received: from [195.223.140.120] ([195.223.140.120]:29458 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265107AbSJROp7>; Fri, 18 Oct 2002 10:45:59 -0400
Date: Fri, 18 Oct 2002 16:52:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1
Message-ID: <20021018145204.GG23930@dualathlon.random>
References: <15355.1034859667@ocs3.intra.ocs.com.au> <200210180126.37013.harisri@bigpond.com> <20021017182739.J20761@oldwotan.suse.de> <200210190014.19357.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210190014.19357.harisri@bigpond.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 12:14:19AM +1000, Srihari Vijayaraghavan wrote:
> Oct 18 23:40:42 localhost kernel: Process modprobe (pid: 957, 

modprobe was running at 234042, now in the log I see:

20021018 234001 start /sbin/modprobe -s -k -- char-major-14 safemode=1
20021018 234001 probe ended
20021018 234004 start /sbin/modprobe -s -k -- char-major-10-134 safemode=1
20021018 234004 probe ended
20021018 234014 start /sbin/modprobe -s -k -- char-major-10-134 safemode=1
20021018 234014 probe ended
20021018 234021 start /sbin/modprobe -s -k -- char-major-14 safemode=1
20021018 234021 probe ended
20021018 234022 start /sbin/modprobe -s -k -- ide-cd safemode=1
20021018 234022 probe ended
20021018 234022 start /sbin/modprobe -s -k -- ide-cd safemode=1
20021018 234022 probe ended
20021018 234040 start /sbin/modprobe -s -k -- char-major-14 safemode=1
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
20021018 234040 probe ended
20021018 234051 start /sbin/modprobe -s -k -- binfmt-ffff safemode=1
20021018 234051 probe ended
20021018 234051 start /sbin/modprobe -s -k -- binfmt-ffff safemode=1
20021018 234051 probe ended

I don't see any modprobe in the logs at 234042 and the one at 234040 is
writing "probe ended" at 234040. maybe it was another modprobe that
crashed before it could write into the logs? or maybe it was the
underlined one that crashed after writing "probe ended"? But anyways it
looks like modprobe is innocent if it didn't write into the log any new
module loaded. Do you agree Keith?

if you still have the .config used to build the kernel please send it
too, thanks!

I've no idea why radeon or agpgart could generate corruption in my tree
and not in mainline and I can't reproduce. the best would be if you
could do a binary search on all the patches applied (first applying all
the [012]* and see if you can rerproduce, and so on)

Andrea
