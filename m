Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269024AbTCAUpM>; Sat, 1 Mar 2003 15:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269025AbTCAUpM>; Sat, 1 Mar 2003 15:45:12 -0500
Received: from demokritos.cytanet.com.cy ([195.14.133.252]:7576 "EHLO
	demokritos.cytanet.com.cy") by vger.kernel.org with ESMTP
	id <S269024AbTCAUpH>; Sat, 1 Mar 2003 15:45:07 -0500
Date: Sat, 1 Mar 2003 15:55:00 -0500
From: wyleus <coyote1@cytanet.com.cy>
To: John Bradford <john@grabjohn.com>, vda@port.imtp.ilyichevsk.odessa.ua
Cc: redelm@ev1.net, linux-kernel@vger.kernel.org
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Message-Id: <20030301155500.0dba31b9.coyote1@cytanet.com.cy>
In-Reply-To: <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>
References: <20030301082126.56c00418.coyote1@cytanet.com.cy>
	<200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Mar 2003 14:55:58 +0000 (GMT)
John Bradford <john@grabjohn.com> wrote:

> As your machine is quite old, you would probably get a noticable speed
> increase from mounting your filesystems with noatime, which is very
> straightforward and shouldn't cause any problems - just edit
> /etc/fstab, and add the option noatime after each disk partition, for

Thanks for the tip.  I applied it, but haven't noticed any
immediately obvious benefits in the short time I've spent so far.  Guess
I won't be able to avoid the dreaded kernel recompile forever. ;-)

> Are you sure there isn't a correct slot that it should be in?  Most
> motherboard manuals specify that the slots should be used in a
> specific order.

Guess I've got one of those unusual mobos - it's an MSI-5169.  Here's an
excerpt from my printed manual (typed manually);

"2.2-3 Memory Population Rules

1. This mainboard supports Table Free memory, so memory can be installed
in DIMM1, DIMM2, or DIMM3 in any order."

> It might have been disconnecting and reconnecting the RAM that
> improved things, not the change of slot.  Try both end slots.

I've been testing it all day, and have collected more data (please see
below)- it's definitely a huge improvement over what I had before,
whatever the underlying reason may be.  Looks like a whole order of
magnitude to me.  Still not perfect though.

Tomorrow, I will try switching to an end slot as you suggest, and see if
that gets me any further improvement.  At this point, I'm thinking of
taking the money and running because I am planning on upgrading my
system in a few months anyway, and think I can tolerate a few crashes
until then - just so long as they're not happening almost daily as they
were before. After all, I'm coming from the world of windows, so I'm not
exactly a virgin in this respect.  ;-)  I will demand perfection from
the new system when I finally get it though.

It may be more productive for me now to spend my time learning and
investigating and tweaking other stuff, as I have a long list of things
(like some performance issues I mentioned before) I would like to work
on to get this installation working to my liking.

When I get my new system this spring, it'll have a spacious 100 gig hard
disk, which I plan to partition with a few different distros -
probably mandrake again, along with debian and gentoo.  I'd like to get
my comfort factor up between now and then, and hope to gain experience
in a lot of different aspects of administration and just plain
understanding how stuff in the linux world works.  Hopefully I'll have
kernel recompile or two under my belt by then, and won't be so clueless
about how the system all fits together.

This experience and your advice and really helped me a lot.  I can't
thank you guys enough for your help, you've been great - not just in
helping me solve my problem, but also in learning a great deal by
walking me through it and taking the time to answer my dumb
questions.

My already high respect for the community has gone up yet another notch.
 I wish the rest of the world could always be this nice.

best regards

wyleus 

....

Here's an updated version of the notes I took;

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
		12:20		254
		23:37		130
		192:47		130
G (128K)	2:46		254
		21:50		130
		30:55		130
		43:59		130
H (256K)	20:12		130
		33:46		130
		24:33		130	
I (512K)	20:06		130
		21:58		130
		21:03		254
J (1024K)	21:57		130
		28:46		130
		=====
Total runtime  ~543 minutes
# of failures	3
ave run/fail	181 minutes
