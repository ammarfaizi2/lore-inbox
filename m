Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUHCUHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUHCUHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUHCUHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:07:36 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:58059 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265148AbUHCUHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:07:22 -0400
In-Reply-To: <06F0F452-E491-11D8-94F5-00039398BB5E@ieee.org>
References: <40926261-E3D3-11D8-B01E-00039398BB5E@ieee.org> <1091397374.6458
	 .9.camel@patibmrh9> <20040802121712.GD15884@logos.cnet> <06F0F452-E491-11D
	8-94F5-00039398BB5E@ieee.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Message-Id: <BBD076AD-E588-11D8-9102-00039398BB5E@ieee.org>
Content-Transfer-Encoding: 7bit
Cc: Mathias Kretschmer <posting@blx4.net>
From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: 2.4.27rc2, DVD-RW support broke DVD-RAM writes
Date: Tue, 3 Aug 2004 14:07:23 -0600
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.618)
X-OriginalArrivalTime: 03 Aug 2004 20:07:19.0963 (UTC) FILETIME=[7B5766B0:01
	C47995]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:19.48023 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what you see in 2.4.27-rc3 when you try:
> sudo blockdev --getro /dev/hd*

Sorry, never mind, I can now reproduce this effect myself, because 
Michael Tilelli kindly lent me a PATAPI DVD-RAM drive.

We must have an asymmetry in 2.4 drivers/ide/ide-cd.c vs. 
drivers/scsi/sr.c.  I see 2.4.26 work, but then 2.4.27-rc3 chokes:

$ uname -msr
Linux 2.4.27-rc4 i686
$
$ sudo rrd scan /dev/hdd
/dev/hdd is MATSHITA DVD-RAM A127 not RRD
$
$ sudo dd if=/dev/hdd bs=32K skip=0 count=1 | hexdump -C
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  
|................|
*
1+0 records in
1+0 records out
00008000
$ sudo dd of=/dev/hdd bs=32K skip=0 count=1 <xae.bin
dd: opening `/dev/hdd': Read-only file system
$ sudo blockdev --getro /dev/hdd
0
$

Pat LaVarre

