Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTCANLp>; Sat, 1 Mar 2003 08:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268481AbTCANLp>; Sat, 1 Mar 2003 08:11:45 -0500
Received: from mail-out2.cytanet.com.cy ([195.14.133.169]:50068 "EHLO
	mail-out2.cytanet.com.cy") by vger.kernel.org with ESMTP
	id <S266810AbTCANLn>; Sat, 1 Mar 2003 08:11:43 -0500
Date: Sat, 1 Mar 2003 08:21:26 -0500
From: wyleus <coyote1@cytanet.com.cy>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: redelm@ev1.net, john@grabjohn.com, linux-kernel@vger.kernel.org
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Message-Id: <20030301082126.56c00418.coyote1@cytanet.com.cy>
In-Reply-To: <200302280645.h1S6ims00404@Port.imtp.ilyichevsk.odessa.ua>
References: <20030226041214.71e1ddc7.coyote1@cytanet.com.cy>
	<200302261151.h1QBp2s23777@Port.imtp.ilyichevsk.odessa.ua>
	<20030227082312.1a56684b.coyote1@cytanet.com.cy>
	<200302280645.h1S6ims00404@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I start, I just want to thank all three of you (Dennis, John, and  Robert) for your patience and very helpful comments.  I'm learning a lot from you guys.  I'm CC'ing you all on this reply, please let me know if you'd rather not have me do that.

On Fri, 28 Feb 2003 08:41:41 +0200
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

> Wow. Do you really use ALL this stuff or it's Mandrake install
> default?

It's the mandrake default AFAIK.  I don't know what all that stuff is, 
so I don't mess with it.  My installation does "feel" bloated (very
unscientific opinion): it "feels" much less responsive in the GUI
(currently icewm - KDE was like molasses, but very nice IMHO) than win98, especially certain apps such as galeon.  But that's another problem, and I'll move on to that problem after the stability issue is resolved.  I suppose one day, after getting more comfortable with linux, I'll move from this newbie distro to something like debian or gentoo - but I'm far from ready for that at this point in time - right now I need mandrake to hold my hand.  :-|

On Fri, 28 Feb 2003 07:47:00 -0600
Robert Redelmeier <redelm@ev1.net> wrote:

> What has happened is that burnMMX has provoked a memory error
> and quit.  This is not surprising.  Many K6s were not capable of
> 100 MHz bus operation, and even more motherboards could not run at
> 100 stably.  Not to mention the slews of expensive sub-spec RAM
> of the era and small AT power supplies.

On Fri, 28 Feb 2003 14:13:01 +0000 (GMT)
John Bradford <john@grabjohn.com> wrote:

> Also, try re-seating your RAM chips, and make sure that the CPU fan
> and heatsink are free of dust and properly attached to the CPU.

Yesterday I ran burnMMX repeatedly and recorded the results in a text file.  Today, I took everything apart and cleaned up any dust and then moved the single RAM stick into the next slot over (I have 3 slots in total).  Initially I was elated as I ran three tests for about 20 minutes each with no errors.  But my bubble popped on the 4th run.  Changing slots does look like it improved things judging from the results, but still not as it should be - at least that's the way it looks to me.  I'm still running tests as I write this, but will copy the results so far below and let you judge;

Robert - thanks for this cpuburn program of yours, it's very helpful, and for a scared newbie like me, it sure is simpler than facing a kernel compile :-) It's small, simple, and effective.  I guess other people find it useful too, since someone took the time to RPM package it on the mandrake contrib mirrors.

I'm not sure why cpuburn uncovered errors, while memtest86 didn't - in retrospect this may be my own doing because I ran memtest86 without fully reading the docs and just let it run with whatever the default options were without really understanding what it was doing - so I may have got what I deserved. :-(

Thanks again, here are my notes on what I've done so far;

Friday, Feb 28 2003
Results of burnMMX tests

command: burnMMX x;  echo $?

where x represents memory size parameter passed to burnMMX as follows;

<small excerpt from cpuburn readme>
burnBX and burnMMX are essentially very intense RAM testers.  They can
also take an optional parameter indicating the RAM size to be tested:

  A =  2 kB   E =  32 kB   I = 512 kB   M =  8 MB
  B =  4      F =  64      J =   1 MB   N = 16
  C =  8      G = 128      K =   2      O = 32
  D = 16      H = 256      L =   4      P = 64

the default memsize used when none is specified is F=64k

exit codes for burnMMX are as follows;
130 = process killed manually using ctl-c
254 = integer/memory error
255 = FP/MMX error

mem		runtime		exit
size    	(minutes) 	code

A (2K)		26:00		130
		28:15		130
F (64K)		2:00		254
		11:00		130
		6:00		130
		21:42		130
G (128K)	6:00		130
H (256K)	3:25		254	
		2:40		254	
		0:45		254	1 these
		1:35		254	1 are
		0:40		254	1 consecutive
		3:45		254	1 runs
		33:00		130	1 
		7:00		254	1 
		7:00		254	1
		5:16		254	1
		17:19		254	1
I (512K)	6:00		254
		1:48		254
		5:34		254

Sat, March 1, 2003

Switched the RAM stick from the first slot (closest
to CPU), to the middle slot;

command: time burnMMX x; echo $?

(using the time command, manual exits using
ctl-c provide exit code 2, but I still list it 
here as 130 in the table for consistency)

mem		runtime		exit
size    	(minutes) 	code

G (128K)	2:46		254
		21:50		130	
H (256K)	20:12		130
		33:46		130	
I (512K)	20:06		130
		21:58		130
J (1024K)	21:57		130

Only one error so far after 7 runs, which seems much better than before, but still unnacceptable I guess...

Where should I go from here?  Try another slot?  Buy new RAM?  More testing?

wyleus
