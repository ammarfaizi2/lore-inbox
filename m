Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132788AbRDOTBN>; Sun, 15 Apr 2001 15:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132789AbRDOTBF>; Sun, 15 Apr 2001 15:01:05 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:64014 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132788AbRDOTAy> convert rfc822-to-8bit; Sun, 15 Apr 2001 15:00:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
To: linux-kernel@vger.kernel.org
Subject: Ide performance (was RAID0 Performance problems)
Date: Sun, 15 Apr 2001 21:08:04 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041521080401.00510@debian>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've posted about performance problems with my RAID0 setup.
RAID works fine, but it's too slow.
But now it seems not to be a problem with the md code, it's an ide problem.
There are two HDs in my PC: /dev/hda and /dev/hdc. No other devices are 
attached to the ide-bus.
PC is a SMP-System, 2 Celeron 533, Gigabyte 6BXDS with Intel BX-Chipset, 
66MHz FSB.
The hdparm settings: 

bash-2.04# hdparm /dev/hda /dev/hdc
 
/dev/hda:
 multcount    =  0 (off)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  0 (off)
 geometry     = 59556/16/63, sectors = 60032448, start = 0
 
/dev/hdc:
 multcount    =  0 (off)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  0 (off)
 geometry     = 59556/16/63, sectors = 60032448, start = 0

I've tested a lot of variations of this settings (multcount=16, 
unmaskirq=0...) without succes. 
The performance of the RAID doesn't increase :-(
hdparm -tT on a single HD (dev/hda3 is the RAID-partition) reports a very 
good performance:

bash-2.04# hdparm -tT /dev/hda3
 
/dev/hda3:
 Timing buffer-cache reads:   128 MB in  1.42 seconds = 90.14 MB/sec
 Timing buffered disk reads:  64 MB in  2.27 seconds = 28.19 MB/sec

But if I start 2 hdparms simultanous (one on /dev/hda3 the other on 
/dev/hdc3) the performance on the HDs decreases to 1/2 of the original speed:

bash-2.04# hdparm -tT /dev/hda3
 
/dev/hda3:
 Timing buffer-cache reads:   128 MB in  2.27 seconds = 56.39 MB/sec
 Timing buffered disk reads:  64 MB in  4.56 seconds = 14.04 MB/sec

bash-2.04# hdparm -tT /dev/hdc3
 
/dev/hdc3:
 Timing buffer-cache reads:   128 MB in  2.25 seconds = 56.89 MB/sec
 Timing buffered disk reads:  64 MB in  4.49 seconds = 14.25 MB/sec

The performance of the RAID0:

bash-2.04# hdparm -tT /dev/md0
 
/dev/md0:
 Timing buffer-cache reads:   128 MB in  1.35 seconds = 94.81 MB/sec
 Timing buffered disk reads:  64 MB in  3.11 seconds = 20.58 MB/sec

Tests with bonnie or iozone have the same reuslts, RAID is slower then a 
single HD :-(

Does anybody has an idea what's wrong with my setup??

Thx,
Andreas
-- 
Andreas Peter *** ujq7@rz.uni-karlsruhe.de

