Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbTKZUkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTKZUkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:40:42 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:36578 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S264335AbTKZUkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:40:31 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: amanda vs 2.6
Date: Wed, 26 Nov 2003 15:40:30 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <20031126195049.GT8039@holomorphy.com> <Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311261540.30261.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.54.127] at Wed, 26 Nov 2003 14:40:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 November 2003 15:04, Linus Torvalds wrote:
>On Wed, 26 Nov 2003, William Lee Irwin III wrote:
>> On Wed, Nov 26, 2003 at 02:43:43PM -0500, Gene Heskett wrote:
>> > No, it just hangs forever on the su command, never coming back.
>> > everything else I tried, which wasn't much, seemed to keep on
>> > working as I sent that message with that hung su process in
>> > another shell on another window.  I'm an idiot, normally running
>> > as root... I've rebooted, not knowing if an echo 0 to that
>> > variable would fix it or not, I see after the reboot the default
>> > value is 0 now.
>>
>> Okay, then we need to figure out what the hung process was doing.
>> Can you find its pid and check /proc/$PID/wchan?
>
>I've seen this before, and I'll bet you 5c (yeah, I'm cheap) that
> it's trying to log to syslogd.
>
>And syslogd is stopped for some reason - either a bug, a mistaken
> SIGSTOP, or simply because the console has been stopped with a
> simple ^S.
>
>That won't stop "su" working immediately - programs can still log to
>syslogd until the logging socket buffer fills up. Which can be
> _damn_ frsutrating to find (I haven't seen this behaviour lately,
> but I remember being perplexed like hell a long time ago).
>
>			Linus

Ok, then, this is not what I'm seeing.  The last su amanda was done on 
an almost virgin shell, having only executed that echo 1 to the 
overcommit_memory var in /proc.

I tried it from other shells too, no difference, su is locked, cannot 
even respond to a ctrl-c or ctrl-d.  But the close button will close 
the shell window just fine.

Also, echoing a 0 to that variable doesn't fix it.only a reboot fixes 
it.  Right now:
[root@coyote root]# ps -ea |grep syslogd
  406 ?        00:00:00 syslogd
[root@coyote root]# echo 1 > /proc/sys/vm/overcommit_memory

which didn't kill syslogd:
[root@coyote root]# ps -ea |grep syslogd
  406 ?        00:00:00 syslogd

Ok, I'll play this game, as long as I know the rules, I have now done 
an "su amanda" in two different shells, without any problems, and a 
"cat /proc/sys/vm/overcommit_memory" returns this:
[amanda@coyote root]$ cat /proc/sys/vm/overcommit_memory
1
[amanda@coyote root]$

The two previous boots to the same kernel, 2.6.0-test10 using the 
default scheduler, hung the su command and failed at exactly this 
same point.

I think I need a new rulebook...



-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

