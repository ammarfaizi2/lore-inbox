Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264874AbRGJJrt>; Tue, 10 Jul 2001 05:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbRGJJrj>; Tue, 10 Jul 2001 05:47:39 -0400
Received: from picard.csihq.com ([204.17.222.1]:47506 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S264874AbRGJJr3>;
	Tue, 10 Jul 2001 05:47:29 -0400
Message-ID: <02ae01c10925$4b791170$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: 2.4.6 and ext3-2.4-0.9.1-246
Date: Tue, 10 Jul 2001 05:47:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started testing 2.4.6 with ext3-2.4-0.9.1-246 yesterday morning and
immediately hit a wall.

Testing on a an SMP kernel -- dual IDE RAID1 set the system temporarily
locked up (telnet window stops until disk I/O is complete).
I'm using tiobench tiobench-0.3.2 and do have unmaskirq turned on so it
shouldn't be irq contention.
/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
/dev/hdc:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)

Investigating this some I noticed that kswapd was taking a LOT of CPU time
(althought there was only 10Meg in swap).  The swap files are located on the
RAID1 IDE set.
So...I moved the swapfiles to my SCSI subsystem (also EXT3 at this point)
and tested again.
Smoother although there was a quite a bit of jerkiness on the telnet window
still.
So...swap on IDE/RAID1/EXT3 was bad idea...I'd say 80% better when swap was
moved off of the IDE system to SCSI.

Here's my RAID1/IDE benchmark with EXT3
..ooops...spoke too soon.
The tiobench.pl locked up on 8 threads (after doing 1,2, & 4).  Had to do a
ALT-SYSRQ-B as all windows were dead although I could get a login prompt.

It really looks like tiobench is a good stress tester for ext3.
________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

