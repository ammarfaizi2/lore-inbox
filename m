Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTK0KF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 05:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTK0KF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 05:05:56 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:51358 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264467AbTK0KFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 05:05:52 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Nick Piggin <piggin@cyberone.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: amanda vs 2.6
Date: Thu, 27 Nov 2003 05:05:50 -0500
User-Agent: KMail/1.5.1
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <Pine.LNX.4.58.0311261202050.1524@home.osdl.org> <3FC5B8B2.7000702@cyberone.com.au>
In-Reply-To: <3FC5B8B2.7000702@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311270505.50242.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.54.127] at Thu, 27 Nov 2003 04:05:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 03:41, Nick Piggin wrote:
>Linus Torvalds wrote:
>>On Wed, 26 Nov 2003, William Lee Irwin III wrote:
>>>On Wed, Nov 26, 2003 at 02:43:43PM -0500, Gene Heskett wrote:
>>>>No, it just hangs forever on the su command, never coming back.
>>>>everything else I tried, which wasn't much, seemed to keep on
>>>> working as I sent that message with that hung su process in
>>>> another shell on another window.  I'm an idiot, normally running
>>>> as root... I've rebooted, not knowing if an echo 0 to that
>>>> variable would fix it or not, I see after the reboot the default
>>>> value is 0 now.
>>>
>>>Okay, then we need to figure out what the hung process was doing.
>>>Can you find its pid and check /proc/$PID/wchan?
>>
>>I've seen this before, and I'll bet you 5c (yeah, I'm cheap) that
>> it's trying to log to syslogd.
>>
>>And syslogd is stopped for some reason - either a bug, a mistaken
>> SIGSTOP, or simply because the console has been stopped with a
>> simple ^S.
>>
>>That won't stop "su" working immediately - programs can still log
>> to syslogd until the logging socket buffer fills up. Which can be
>> _damn_ frsutrating to find (I haven't seen this behaviour lately,
>> but I remember being perplexed like hell a long time ago).
>
>Same problem here. Been seeing them now and again for quite a while
>I have syslogd and klogd sleeping in do_syslog. cron and login are
>sleeping in schedule_timeout. A sysrq+T gets things going again but
>unfortunately the interesting state probably wasn't captured. I have
>the /proc/*/wchan and sysrq+t trace if anyone is interested.
>
>I'll try any suggestions of what I should look at when I hit it
> again.

User experience report Nick.

Around midnight last night, haveing left 
/proc/sys/vm/overcommit_memory=1, I tried to build 2.6.0-test11.
The machine got plumb spastic, taking nearly 10 minutes to unpack the 
tarball and copy the configs etc, and another 5 just to run the last 
command in my script, 'make xconfig'.  Thats my buildit26 script, 
which normally runs in maybe 2 minutes plus whatever browsing time I 
waste in that xconfig.  I'm talking mouse locked up for several 
seconds at a time.  Using the anticipatory scheduler.

cd'ing into linux-2.6, and editing 1 character in my makeit script 
took another 2 minutes, then running the script, about a 12 minute 
job as it oversees the fully installed kernel, took about 17 minutes.
With it running, it was quite sluggish vim'ing /boot/grub/grub.conf to 
add the new kernel and save it.

I got rebooted with about 2 minutes to spare before amanda was due to 
run.  The machine is now normal again since the reboot set that back 
to 0.  I've tried to set it back to zero by hand, but once the 
machine turns into an arthritic dog because its set to 1, then a 
reboot seems to be the only recovery.

To me, setting this "overcommit_memory" bit to non-zero seems to 
trigger something other than what it was designed to do.

The kde utils kpm and ksysguard also do not show enough cpu usage in 
the process list, with the sum totals of both usage columns often 
being below 25%.  The graphical displays however seem to be ok.  Both 
of those were of course built while running a 2.4 kernel so I'd 
expect to see some miss-match when they are interrogating a 2.6 
kernel.

My $0.02, but performance like that would scare a new user right back 
to winderz.

Around here, its thanksgiving day, and we traditionally eat way too 
much turkey (or something like that :)  And then complain about the 
weight we've gained of course...

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

