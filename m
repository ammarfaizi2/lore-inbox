Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTK2ROk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTK2ROk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:14:40 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:45784 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S263913AbTK2ROe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:14:34 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: amanda vs 2.6
Date: Sat, 29 Nov 2003 12:14:33 -0500
User-Agent: KMail/1.5.1
Cc: Nick Piggin <piggin@cyberone.com.au>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311270505.50242.gene.heskett@verizon.net> <20031127133929.GX8039@holomorphy.com>
In-Reply-To: <20031127133929.GX8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311291214.33130.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.54.127] at Sat, 29 Nov 2003 11:14:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 08:39, William Lee Irwin III wrote:
>On Thu, Nov 27, 2003 at 05:05:50AM -0500, Gene Heskett wrote:
>> My $0.02, but performance like that would scare a new user right
>> back to winderz.
>> Around here, its thanksgiving day, and we traditionally eat way
>> too much turkey (or something like that :)  And then complain
>> about the weight we've gained of course...
>
>This isn't a performance problem. This is a bug. It vaguely sounds
> like a missed wakeup or missing setting of TIF_NEED_RESCHED, but
> could be a number of other things too.
>
>(The missing setting of TIF_NEED_RESCHED theory is right if it's
>possible to clean up after it by ignoring need_resched() in the
>scheduler and always rescheduling.)
>
>
>-- wli

Another data point about this, still unsolved problem:

The number of times I can do an 'su amanda' then exit, and redo the it 
seem to be somewhat random,  One test I managed to get to the 4th su 
before it hung.  I turned on the linux normal security stuff in the 
.config, rebuilt and rebooted.  It had been off previously because 
this machine is behind a firewall.

That time I only got one free ride, it hung on the next attempt.  So I 
left it hung, and put the ksysguard highlight line on the hung su 
process, then put ksysguard into the tree mode.  The last item in the 
branch was an 'stty', which was reported to be 'stopped'.  I killed 
it.  I got my prompt back, as the user amanda, confirmed by a whoami.

Another data point that might be a clue is that there appears to be no 
such restriction if the 'su amanda -c "command"' syntax is used.  The 
only place that hangs is if I try to do an amcheck after refilling 
the tape robots magazine, under 2.4.22 ti will load the last tape 
slot and resume the search thru the magazine for the right tape.  
Under 2.60-test-whatever, I'm getting a signal 11 from the chg-scsi 
script after a long delay, but it does load from the last loaded 
tapeslot in the magazine.  If I simply up-arrow and repeat, it works 
as the first pass did load the tape just fine.

I think these are really two seperate problems.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

