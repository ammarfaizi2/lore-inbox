Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971040-15588>; Thu, 23 Jul 1998 18:50:06 -0400
Received: from [207.181.251.162] ([207.181.251.162]:25035 "EHLO bitmover.com" ident: "root") by vger.rutgers.edu with ESMTP id <971089-15588>; Thu, 23 Jul 1998 18:44:30 -0400
Message-Id: <199807240020.RAA13043@bitmover.com>
To: linux-kernel@vger.rutgers.edu
Cc: torvalds@transmeta.com
Subject: more perf results
From: lm@bitmover.com (Larry McVoy)
Date: Thu, 23 Jul 1998 17:20:47 -0600
Sender: owner-linux-kernel@vger.rutgers.edu

I mentioned a while back that I had a little bit of Linux vs Irix
performance testing.  I have expanded numbers which include Sun, Linux
2.0 and Linux 2.1.110, as well as Irix.  I'm happy to say that 2.1 isn't
worse, but it isn't a lot better either, maybe a few percent but that
is probably not statistically significant.

The test is a 1700 line shell script which is a regression test for my
source mgmt system.  Think of it as the checker-inner, checker-outer
script and you're close.

The Sun is a 167Mhz Ultra1, pretty old machine I think.  The regression
stats are:

Sun Ultra1@167: 
	tmpfs	9.22secs user, 8.80secs sys, and 23secs elapsed
	ufs	8.70secs user, 9.68secs sys, and 61secs elapsed (!!)
SGI R10K@175:	1.8u 8.6s 0:12
AMD K6@300:	
	2.0.34	4.25user 3.59system 0:07.98elapsed 
	2.1.110	4.19user 3.47system 0:07.70elapsed

The interesting thing is the ratio of user to system time.  We would
expect that the user times are all pretty much similar, when normalized
for processor performance.  So this gives us a pretty good look at how
the system is eating up CPU cycles.  In the table below, the numbers are
user/system and bigger is better - it implies that the system cost less,
relatively speaking.

	Sun	tmpfs	1.04
		ufs	0.89
	AMD	ext2fs	1.21
	SGI	xfs	0.21

Sun's doing pretty well in tmpfs but that is cheating.  They are still
doing more than 4x better than Irix in UFS, but remember that they take
5x as long wall clock wise.  Linux, as usual, rocks :-)  I can't wait
to see Stephen's journaling changes, I think at that point, Linux will
be the hands down winner in all dimensions, both performance and safety.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
