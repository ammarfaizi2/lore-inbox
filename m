Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967169AbWKYUfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967169AbWKYUfP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967170AbWKYUfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:35:15 -0500
Received: from mx1.aecom.yu.edu ([129.98.1.51]:1486 "EHLO mx1.aecom.yu.edu")
	by vger.kernel.org with ESMTP id S967169AbWKYUfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:35:13 -0500
X-AuditID: 816201a0-accbebb0000059fa-1c-4568a74da3a2 
Mime-Version: 1.0
Message-Id: <a06240400c18e4b03eadf@[129.98.90.227]>
Date: Sat, 25 Nov 2006 15:35:14 -0500
To: support@areca.com.tw
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Pathetic write performance from Areca PCIe cards
Cc: linux-kernel@vger.kernel.org, erich@areca.com.tw
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two systems with a serious I/O subsystem based on Areca PCIe 
cards, but the results I am getting from simple write benchmarks are 
extremely slow.

The details are two 64-bit Opteron systems, one with an Areca PCIe 
1210 and the other a PCIe 1220 and both with Seagate SATA II 750 GB 
drives. The motherboard is a Tyan S2891 (Thunder K8SRE). The 120 
system has 1 GB of PC2700 RAM and the 1220 system has 2GB of PC3200 
RAM. The Areca BIOS on both cards is version 1.17a and the firmware 
is 1.41.
I have tried two different kernels, 2.6.17 from Ubuntu, which had the 
Areca driver added by Ubuntu and 2.6.18 from Gentoo with the Areca 
driver added manually from 2.6.19-rc3.

In the initial tests, both computers had a RAID 5/6 configuration, 
but to confirm the result, I setup a single Seagate as a pass-through 
drive and had the same results. The drive was set to SATA II with NCQ 
and the cache was enabled to write-back.

dd if=/dev/zero of=output oflag=sync bs=100M count=1 gives an 
excellent result, around 188 MB/sec.
dd if=/dev/zero of=output oflag=sync bs=200M count=1 gives an 
excellent result, around 167 MB/sec.
dd if=/dev/zero of=output oflag=sync bs=300M count=1 gives an OK 
result, around 117 MB/sec.
dd if=/dev/zero of=output oflag=sync bs=400M count=1 gives a very 
poor result, around 35 MB/sec.
These very low numbers around 30 MB/sec persist as I increase the bs number.

As I continue to run the tests, the bs that gives a poor results goes 
down to about 200 MB. The results are from the system with the 1220 
card. The system with 1210 gives slightly lower numbers overall.

I have also confirmed these low numbers using a benchmark called dm 
from the network RAID package, drbd.

Reading from the drives (based on hdparm -tT testing) gives excellent results.

When I use the drive directly connected to the SATA on the 
motherboard, all the write tests hover around 56 MB/second regardless 
of bs value.

Since both systems are affected, my guess is there is bug in the 
Areca driver or with the cards themselves.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
