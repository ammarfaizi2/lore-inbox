Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbTK0R4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264572AbTK0R4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 12:56:03 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:47862 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S264571AbTK0Rz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 12:55:59 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: gene.heskett@verizon.net, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: amanda vs 2.6
Date: Thu, 27 Nov 2003 12:55:57 -0500
User-Agent: KMail/1.5.1
Cc: Nick Piggin <piggin@cyberone.com.au>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <20031127133929.GX8039@holomorphy.com> <200311271216.40829.gene.heskett@verizon.net>
In-Reply-To: <200311271216.40829.gene.heskett@verizon.net>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311271255.57857.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.54.127] at Thu, 27 Nov 2003 11:55:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 12:16, Gene Heskett wrote:
>On Thursday 27 November 2003 08:39, William Lee Irwin III wrote:
>>On Thu, Nov 27, 2003 at 05:05:50AM -0500, Gene Heskett wrote:
>>> My $0.02, but performance like that would scare a new user right
>>> back to winderz.
>>> Around here, its thanksgiving day, and we traditionally eat way
>>> too much turkey (or something like that :)  And then complain
>>> about the weight we've gained of course...
>>
>>This isn't a performance problem. This is a bug. It vaguely sounds
>> like a missed wakeup or missing setting of TIF_NEED_RESCHED, but
>> could be a number of other things too.
>>
>>(The missing setting of TIF_NEED_RESCHED theory is right if it's
>>possible to clean up after it by ignoring need_resched() in the
>>scheduler and always rescheduling.)
>
>Well, running 2.6.0-test11, I just discovered I'm back to being
> unable to 'su amanda' again.  It worked the first time, but I got
> rejected frorm unpacking the lastest amanda-2.4.4p1-20031126.tar.gz
> due to a lack of permissions, so I exited, chowned the archive to
> what it was supposed to be, but cannot now do another su amanda in
> order to start the install of this latest snapshot.
>
>The process just hangs, never comeing back to a prompt.  I never had
>any troubles with that useing test9, so I guess its reboot time
>again.
>
>However, IMO this is a major problem, and needs fixed before 2.6.0.

Rebooted to 2.6.0-test10, deadline scheduler now, and have managed to 
do an 'su amanda' at least twice without any hangs.

Three times now, no problems.  4 times, exited the last one with a 
ctrl-d instead of an exit string, and now the 5th time is hung.  Is 
ctrl-d no longer a valid shell exit option?  Finding the su PID, and 
catting /proc/PID/wchan returns this just as it did yesterday:

[root@coyote root]# ps -ea |grep su
26658 pts/1    00:00:00 su
[root@coyote root]# cat /proc/26658/wchan
sys_wait4[root@coyote root]#

Comment on schedulers, deadline seems to leave me with the snappiest 
machine response, with cfq a close second.  The default anticipatory 
just doesn't have the right 'feel' to it.

Also, setiathome only did 3 units yesterday, and it normally does 4 to 
5.  With the overcommit_memory non-zeroed, the machine was an 
arthritic, stuttering as it barked, spastic dog.

Or, any cat could have caught that mouse...

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

