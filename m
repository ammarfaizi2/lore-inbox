Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269117AbTCBLEf>; Sun, 2 Mar 2003 06:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269124AbTCBLEf>; Sun, 2 Mar 2003 06:04:35 -0500
Received: from demokritos.cytanet.com.cy ([195.14.133.252]:35526 "EHLO
	demokritos.cytanet.com.cy") by vger.kernel.org with ESMTP
	id <S269117AbTCBLEa>; Sun, 2 Mar 2003 06:04:30 -0500
Date: Sun, 2 Mar 2003 06:14:44 -0500
From: wyleus <coyote1@cytanet.com.cy>
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Message-Id: <20030302061444.36755e4d.coyote1@cytanet.com.cy>
In-Reply-To: <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>
References: <20030301082126.56c00418.coyote1@cytanet.com.cy>
	<200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Mar 2003 08:54:41 +0000 (GMT)
John Bradford <john@grabjohn.com> wrote:

> It's interesting to note that these will be running mainly in cache
> memory, and they have worked much more reliably than the ones below,
> which use main memory more heavily.

I also had this in mind from the first few times I ran the program. 
Which is why I chose to run several time-limited runs across different
memory sizes that straddled the L2 cache size (128k), instead of letting
each one run 'till it died.

My thinking was/is that this probably says that the problem lies beyond
the cache, and probably points to the RAM chip itself, or at least
something in the logical path after the cache but before reaching the
RAM.  (I'm no expert, so I don't know what those other possibilities
could include).

John, I think I may have been premature in my celebrations.  After I
wrote that message, I continued testing late into the night, and I
later started getting rapid consecutive failures.

This got me the cynical thought "what, does it depend on the time of day
now?".  But I suppose that's really a possibility, isn't it?  It could
even be affected by my local electricity - voltage variations, or
whatever?  Just taking stabs in the dark here.  I'm a foreigner living
on a small island (Cyprus) and I suppose it could be possible that they
may not be up to the more reliable generation standards in other
countries. Certainly, my local ISP seems to go down more often than I do
(they're running windows).  We have a LUG here, maybe I should ask the
local linfolk if they are experiencing any instability.  I do remember
making a comment to my wife that ever since arriving here a few years
ago, my windows partition (where I've spent most of my time) seems to
crash more often than it used to.

Some other observations about the crashes I've been getting (it's
been a few days since the last one) - they tend to clump together.  That
is, I could go several days without incident, but then have 3 or 4
crashes in one night.  I'll have to untar my logs and concatenate them
to verify this numerically, but that's what I remember.  Also, they may
happen more at night than they do in the day time, also IIRC.  I shut
off by box overnight.

Another observation I'll mention, but I don't know if it's of any
significance, is that when I got the hard freezes, my computer wouldn't
respond to ctl-alt-del nor to the capslock key.  But recently I learned
about the Magic SysRq feature, and for the last couple of crashes I've
verified that the kernel DOES respond to those.  Does this say anything
helpful?

Man, do I feel confused compared to yesterday.

Here's an updated version of my notes.  Guess I should start recording
the time/date of each run from now on.  I've been doing this manually so
far, I should probably automate it into a script that loops the test
and appends the output into a text file.  (Got to read some man pages to
figure out how to do that)

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
		=====
Total runtime  ~197 minutes
# of failures	14
ave run/fail	14 minutes

Sat, March 1, 2003

Switched the RAM stick from the first slot (closest
to CPU), to the middle slot;

command: time burnMMX x; echo $?

(using the time command, manual exits using
ctl-c provide exit code 2, but I still list it 
as 130 in the table for consistency)

mem		runtime		exit
size    	(minutes) 	code

F (64K)		22:42		130
		12:20		254 *
		23:37		130
		192:47		130
G (128K)	2:46		254 *
		21:50		130
		30:55		130
		43:13		254 *
H (256K)	20:12		130
		33:46		130
		24:33		130
		18:59		254 *
I (512K)	20:06		130
		21:58		130
		21:03		254 *
		26:50		254 *
J (1024K)	21:57		130
		28:46		130
		1:38		254 *
		2.10		254 *
		12.50		254 *
		4.47		254 *
		3.39		254 *
		=====
Total runtime  ~604 minutes
# of failures	11
ave run/fail	55 minutes
