Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266831AbUGVRbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUGVRbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 13:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUGVRbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:31:00 -0400
Received: from lakermmtao11.cox.net ([68.230.240.28]:55734 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S266831AbUGVRa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:30:57 -0400
Message-ID: <40FFBC8B.5050407@cox.net>
Date: Thu, 22 Jul 2004 08:09:31 -0500
From: "Will S." <willgs00@cox.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040718)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: monty@xiph.org
Subject: Re: large, spurious[?] TSC skews on AMD 760MPX boards
References: <20040721204050.GA4913@xiph.org>
In-Reply-To: <20040721204050.GA4913@xiph.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monty wrote:

>[Please keep me in the CC: I apologize for the lack of netiquette in
>not subbing to the list but I have enough trouble keeping up with the
>deluge of user support on my own lists ;-]
>
>Hello folks,
>
>short background: 
>
>Ever since getting my first dual Athlon, the system timer was 'not
>quite right' when running at stock speed.  Selects, alarms, etc, had a
>strange way of firing fractions of a second or several seconds 'too
>late'.  I discovered that overclocking by about 10% made the problem
>magically go away.  I've never been entirely comfortable doing that,
>but three dual athlons later (all 760MPX-B2 based boards of different
>makes), it was always the only way to make the problem disappear and I
>didn't think more about it.
>
>Now that I'm on #3, it is not stable at the overclock I need to make
>the system timer problem disappear, so I finally started hunting for
>the cause.  Whenever I run the system stock, I see:
>
>Jul 20 21:48:26 Snotfish kernel: checking TSC synchronization across CPUs: 
>Jul 20 21:48:26 Snotfish kernel: BIOS BUG: CPU#0 improperly initialized, has 6282588 usecs TSC skew! FIXED.
>Jul 20 21:48:26 Snotfish kernel: BIOS BUG: CPU#1 improperly initialized, has -6282588 usecs TSC skew! FIXED.
>
>When the system is running 'properly', that is to say, overclocked:
>
>Jul 21 22:08:01 Snotfish kernel: checking TSC synchronization across CPUs: passed.
>
>This behavior is reproducable on all three of my 760MPX systems (One
>Gigabyte GA-7DPXDW-P, and two MSI K7D Master-L).  The amount of the
>reported skew varies in the stock case, but it's always large.  Note
>that once in a blue moon, the system will come up with no TSC skew at
>stock timings, and the system timer issues seem to disappear.
>
>What is the proper route to go about debugging this problem, as I have
>it bottled up here in a reproducability cage?
>
>I'm attaching the syslog from a 'bad' and a 'good' boot (the good boot
>manufactured from a multiplier/FSB combo that AMD would not approve
>of) as well as /proc/cpu info from this 'good' boot.
>
>(BTW, these are true and correct Athlon MPs; no cheapo XP-modding
>going on here.  Also, all motherboards in question are running most
>recent BIOSes and officially support the CPUs they're using.  The K7Ds
>are using MP2400s, the Gigabyte is running MP2800s)
>
>Thanks,
>Monty
>

I'm seeing a similar problem on some very different hardware. ECS 
P6LX2-A slot 1 motherboard, matched pair of Pentium-II 333s. This ECS 
board has been reported to work perfectly since something like 2.1.38, 
although it has a lazy BIOS that doesn't initialize the second CPU.

2.6 kernels show +-7 usecs TSC skew and exhibit very jumpy timers, while 
2.4 kernels are OK and show matched TSCs. I have no idea where to start, 
as the system is working perfectly otherwise (it's stable with either 
kernel series). Every 10 seconds or so the timers go haywire. 
Overclocking which mysteriously gets rid of your problem doesn't work 
for me, my system doesn't POST at a ~3% speed bump (which is the 
smallest I can do), and my CPUs are multiplier-locked.

Kernel bug? If anyone would like me to trace anything, go ahead and ask, 
it's not a production system by all means (read: toy at home).

-- Will S.
willgs00@cox.net
