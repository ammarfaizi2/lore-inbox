Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTDFTMA (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 15:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTDFTMA (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 15:12:00 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:57984 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263053AbTDFTL7 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 15:11:59 -0400
Date: Sun, 6 Apr 2003 15:21:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: hdparm -tT reports "suspicious results" ???
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304061523_MC3-1-3348-4760@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:


>does "PII ODP" mean a PII in an adapter that fits into a P6 socket?


It is a factory Intel PII/333 with an HSF that fits in Socket 8.
With its 512K full-speed cache it makes a PPro into a half-decent machine.
Too bad they're so rare...


>> /dev/hde:
>>  Timing buffer-cache reads:   128 MB in  2.62 seconds = 48.85 MB/sec
>
> hmm, slower dram and/or FSB.


No, same exact machine in _every_ way, just a different kernel.  It is
slow ECC EDO memory, though.


>> /dev/hde:
>>  Timing buffer-cache reads:   128 MB in  2.66 seconds = 48.14 MB/sec
>>  Timing buffered disk reads:  64 MB in  3.90 seconds = 16.41 MB/sec.>
>
> dram is still slow, but disk appears slower yet, so not obviously
> contaminating the measurement.

..and that's 2.5 which measures much lower but doesn't seem to be that

slow (still not tested, I'm testing RAID1 patches on 2.4 now.)


> 53073H4, ecs k7s6a-pro, athlon/"1800", DDR:
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.48 seconds =266.67 MB/sec
>  Timing buffered disk reads:  64 MB in  2.04 seconds = 31.37 MB/sec


3 x 33073H3, RAID1, Abit KT7A-RAID, Tbird 1333, PC133 SDRAM:


Personalities : [raid0] [raid1] 
read_ahead 24 sectors
md2 : active raid1 hdg9[0] hde8[2] hda8[1]
      2409600 blocks [3/3] [UUU]

2.4.21-pre6:
/dev/md2:
 Timing buffer-cache reads:   128 MB in  0.58 seconds =220.69 MB/sec
 Timing buffered disk reads:  64 MB in  2.71 seconds = 23.62 MB/sec

2.4.20aa1ce1(unreleased):
/dev/md2:
 Timing buffer-cache reads:   128 MB in  0.59 seconds =216.95 MB/sec
 Timing buffered disk reads:  64 MB in  1.67 seconds = 38.32 MB/sec


I have RAID1 patches that give 55% sequential IO improvements on K7 but
they're not showing the same gains on the PPro (<20% so far.)  Kernel,
chipset, CPU and disk controller are all different, though I expected
to get proportional gains on any hardware.

AFAICT hdparm says "suspicious results" when the disk speed is greater
than one-half the buffer speed.  I just got 51.20 and 26.34 on the PPro
with my patches and the message came out again.

--
 Chuck
 I am not a number!
