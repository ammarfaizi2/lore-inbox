Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUEHMvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUEHMvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 08:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUEHMvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 08:51:45 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:17586 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S263831AbUEHMvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 08:51:42 -0400
Date: Sat, 8 May 2004 14:51:39 +0200
From: Marc Lehmann <linux-kernel@plan9.de>
To: linux-kernel@vger.kernel.org
Subject: unexplainable low ide raid performance, slower than a single raid disk
Message-ID: <20040508125138.GA18378@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux version 2.6.5 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a lvm-on-raid-on-ide setup, with 5 IDE disks, all on their own
channel.

However, neither read nor write speed is as high as one would expect.

Every single disk is capable of delivering roughly 50MB/s (measured with
hdparm -tT), except one, which only does 46MB/s (it's only 5400rpm):

   /dev/hdk:
    Timing buffer-cache reads:   812 MB in  2.01 seconds = 404.65 MB/sec
    Timing buffered disk reads:  158 MB in  3.03 seconds =  52.17 MB/sec

When I do dd if=/dev/somedisk of=/dev/null bs=1024x1024 on two disks, I
get ~62MB/s and three disks deliver about 68MB/s, which seems to be the
maximum this (slightly older) system can deliver.

The reconstruction speed I get on an idle system is ~13500kb/s, which,
with five disks, corresponds nicely with the 68MB/s my system is capable
of delivering.

So all this is relatively consistent.

However, the raid device itself is much slower, never ever reaching the
speed of even a _single_ disk:

   /dev/hdk:
    Timing buffer-cache reads:   812 MB in  2.00 seconds = 405.25 MB/sec
    Timing buffered disk reads:  128 MB in  3.02 seconds =  42.32 MB/sec

Wether hdparm or reading/writing with dd, the linera throughput on the
raid device is always much lower, and I have no idea why this is the case,
and I wonder wether this is a problem with my setup and wether it can be
fixed.

Here is some more info about my system that might or might not be
useful:

* Dual-PIII 1Ghz
* kernels 2.6.4 and 2.6.5 consistently show this behaviour.
* one disk is on the secondary via vt82c686 controller,
* all other disks are on promise 20268 devices, all ATA 100 controllers.
* the raid was clean (non-degraded) during all my tests, and I have re-run
  them a few times on an otherwise idle system and got about the same figures.
* 1 x SAMSUNG SV1604N, 4 x SAMSUNG SP1604N drives
* md0 : active raid5 hdk1[3] hdi1[2] hdg1[1] hde1[0] hdc1[4]
        625163264 blocks level 5, 64k chunk, algorithm 2 [5/5] [UUUUU]

Thanks a lot for any insights or ideas on this problem.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
