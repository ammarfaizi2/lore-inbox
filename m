Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263982AbTE0RaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTE0RaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:30:19 -0400
Received: from mta3-svc.business.ntl.com ([62.253.164.43]:32187 "EHLO
	mta3-svc.business.ntl.com") by vger.kernel.org with ESMTP
	id S263982AbTE0RaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:30:13 -0400
Date: Tue, 27 May 2003 18:34:32 +0100 (BST)
From: William Gallafent <william.gallafent@virgin.net>
X-X-Sender: williamg@flatlounge.oldvicarage
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 AMD 74xx IDE cable detection problem
Message-ID: <Pine.LNX.4.44.0305271808560.1589-100000@flatlounge.oldvicarage>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've found mention of similar problems (80w cables being incorrectly
detected as 40w under various circumstances) in the list archives, but
not of exactly this. I'm using stock SuSE 8.2 kernel 2.4.20-64GB-SMP
at the moment.

M/B: Tyan S2460 Tiger MP, with AMD 760MP chipset.

Each IDE channel has an ATA-133 capable HDD as master, and an ATA-33
capable CD/DVD drive as slave. Both channels have 80 wire cables.

If I only connect the master devices to each IDE channel, the cable
detect works fine, detecting an 80 wire cable on each channel, and
enabling ATA-100 for both drives. If I connect the slave on either
channel, though, the detection reports a 40w cable, and therefore
limits all drives on that channel to ATA-33.

Here's the contents of /proc/ide/amd74xx with all the drives
connected, and the cable detection wrong:

----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.10
South Bridge:                       Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE
Revision:                           IDE 0x1
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xf000
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA      UDMA      UDMA
Address Setup:       30ns      30ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      30ns
Cycle Time:          60ns      60ns      60ns      60ns
Transfer Rate:   33.3MB/s  33.3MB/s  33.3MB/s  33.3MB/s

If I disconnect the slave device from channel 1, though, the cable on
that channel is correctly detected, so that drive runs at ATA-100. The
same is true for the other channel:

----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.10
South Bridge:                       Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE
Revision:                           IDE 0x1
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xf000
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA      UDMA
Address Setup:       30ns      90ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     180ns      90ns      90ns
Data Recovery:       30ns     450ns      30ns      30ns
Cycle Time:          20ns     630ns      60ns      60ns
Transfer Rate:   99.9MB/s   3.1MB/s  33.3MB/s  33.3MB/s

Can anyone tell me what's wrong here, and where I should look to fix
it?

-- 
Bill Gallafent.

