Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVIXUUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVIXUUF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 16:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVIXUUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 16:20:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:41943 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750715AbVIXUUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 16:20:04 -0400
X-Authenticated: #20450766
Date: Sat, 24 Sep 2005 21:32:31 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
cc: Jens Axboe <axboe@suse.de>
Subject: [2.6.13] pktcdvd: IO-errors
Message-ID: <Pine.LNX.4.60.0509242057001.4899@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Just tried pktcdvd on 2.6.13.1. The setup went fine:

20:33:13: pktcdvd: writer pktcdvd0 mapped to hdc
20:33:21: pktcdvd: inserted media is CD-RW
20:33:21: pktcdvd: Fixed packets, 32 blocks, Mode-2 disc
20:33:21: pktcdvd: Max. media speed: 10
20:33:21: pktcdvd: write speed 10x
20:33:21: pktcdvd: 590528kB available on disc
20:33:23: UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2005/09/24 20:18 (1078)

But, as I tried to copy some files to the CD-RW, it first went ok, but 
then produced the following:

20:41:01: ide-cd: cmd 0x2a timed out
		      ^^^^	---------> write10
20:41:01: hdc: DMA timeout retry
20:41:01: hdc: timeout waiting for DMA
20:41:01: hdc: status timeout: status=0xd0 { Busy }
20:41:01: ide: failed opcode was: unknown
20:41:01: hdc: drive not ready for command
20:41:31: hdc: ATAPI reset timed-out, status=0x80
20:42:06: ide1: reset timed-out, status=0x80
20:42:06: hdc: status timeout: status=0x80 { Busy }
20:42:06: ide: failed opcode was: unknown
20:42:06: hdc: drive not ready for command
20:42:36: hdc: ATAPI reset timed-out, status=0x80
20:43:07: : I/O error, dev hdc, sector 136672
20:43:07: end_request: I/O error, dev hdc, sector 136680
20:43:07: end_request: I/O error, dev hdc, sector 136688
20:43:07: end_request: I/O error, dev hdc, sector 136696
20:43:07: end_request: I/O error, dev hdc, sector 137216
20:43:07: end_request: I/O error, dev hdc, sector 137224
20:43:07: end_request: I/O error, dev hdc, sector 137232
20:43:07: end_request: I/O error, dev hdc, sector 137240
... <thousands of the above>
20:43:11: end_request: I/O error, dev hdc, sector 344440
20:43:11: end_request: I/O error, dev hdc, sector 344444
20:43:11: pktcdvd: bb 00 06 ea 06 ea 00 00 00 00 00 00 - sense 00.e0.0e (No sense)
20:43:11: end_request: I/O error, dev hdc, sector 363008
20:43:11: end_request: I/O error, dev hdc, sector 363016
... <more of them>
20:43:11: printk: 79693 messages suppressed.
20:43:11: Buffer I/O error on device pktcdvd0, logical block 90752
20:43:11: lost page write due to I/O error on pktcdvd0
20:43:11: end_request: I/O error, dev hdc, sector 362880
20:43:11: end_request: I/O error, dev hdc, sector 362884
...

the "cp" finished earlier, I did a sync, and it also finished. The good 
parts - no Oops, no process stuck in "D", tha bad parts - it didn't 
work:-), the IDE LED stays on and I cannot eject the CD. The CD-R is a 
BenQ 52x32x52 Seamless Link alone on ide1, the disk does indeed say 
4x-10x. The cd-writer works mostly... if I am gentle to it - I usually 
burn at 32x even if the media says 52x... Is it just a hw-failure or a 
driver bug?

Thanks
Guennadi
---
Guennadi Liakhovetski
