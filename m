Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278584AbRJ1RFX>; Sun, 28 Oct 2001 12:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278587AbRJ1RFE>; Sun, 28 Oct 2001 12:05:04 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:33695 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S278584AbRJ1RE6>; Sun, 28 Oct 2001 12:04:58 -0500
Date: Sun, 28 Oct 2001 12:07:21 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM test on 2.4.14pre3aa2 (compared to 2.4.14pre3aa1)
Message-ID: <20011028120721.A286@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:	2.4.14pre3aa2 gave oom errors not seen in 2.4.14pre3aa1.

Test:	Usual scripts to execute mtest01 and mmap001.  
	Listen to long mp3 with mp3blaster.

mtest01 -p 80 -w
================

2.4.14pre3aa1

Averages for 10 mtest01 runs
bytes allocated:                    1246232576
User time (seconds):                2.105
System time (seconds):              2.773
Elapsed (wall clock) time:          59.503
Percent of CPU this job got:        7.80
Major (requiring I/O) page faults:  132.8
Minor (reclaiming a frame) faults:  305043.1

2.4.14pre3aa2

Averages for 10 mtest01 runs
bytes allocated:                    1254201753
User time (seconds):                2.211
System time (seconds):              2.794
Elapsed (wall clock) time:          65.176
Percent of CPU this job got:        7.20
Major (requiring I/O) page faults:  129.7
Minor (reclaiming a frame) faults:  306988.9


mmap001 -m 500000
=================

This test worked on 2.4.14pre3aa1, but on 2.4.14pre3aa2, each
iteration was terminated by signal 9.  Also an irc client I
had running was killed.  

/var/log/kern.log had these messages:

Oct 28 11:50:24 rushmore kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Oct 28 11:50:24 rushmore kernel: VM: killing process mmap001
Oct 28 11:51:07 rushmore kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Oct 28 11:51:07 rushmore kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Oct 28 11:51:08 rushmore last message repeated 3 times
Oct 28 11:51:08 rushmore kernel: VM: killing process bx
Oct 28 11:51:09 rushmore kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Oct 28 11:51:12 rushmore kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Oct 28 11:51:13 rushmore last message repeated 2 times
Oct 28 11:51:13 rushmore kernel: VM: killing process mmap001
Oct 28 11:51:47 rushmore kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Oct 28 11:51:47 rushmore kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Oct 28 11:51:47 rushmore kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Oct 28 11:51:47 rushmore kernel: VM: killing process mmap001


Hardware:
AMD Athlon 1333
512 MB RAM
1024 MB swap.

-- 
Randy Hron

