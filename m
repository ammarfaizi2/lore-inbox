Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTKAKSu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 05:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbTKAKSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 05:18:50 -0500
Received: from [62.38.238.190] ([62.38.238.190]:30366 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S263745AbTKAKSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 05:18:48 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Mike Houston <mikeserv@bmts.com>
Subject: Re: 2.6.0-test9 breaks cdrecord w. ide-scsi device
Date: Sat, 1 Nov 2003 12:19:21 +0200
User-Agent: KMail/1.5.3
References: <200310310012.47580.p_christ@hol.gr> <20031030171432.03dcaa76.mikeserv@bmts.com>
In-Reply-To: <20031030171432.03dcaa76.mikeserv@bmts.com>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311011219.21890.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello
>
> ...
>  
> There is now ide-cd writing support, and cdrecord 2 supports it. I build
> that stuff modular, so I just load the ide-cd and isofs modules (modprobe
> takes care of the rest). I achieve the fastest writing speeds I've ever
> had, using this driver. Far better than ide-scsi or even Sleazy CD Creator
> in Windows.
>
>...

Tried it. Now used /dev/hdd there..
This time it worked a few times and some other times it failed. 
It now seems that I got a buffer underrun, although I do have 'realtime 
priority' for the process.
Note that I'm not using 'burnfree'. That's why I have linux anyway :) .

Can anybody examine why is the buffer of cdrecord less than 100% with 
RR-scheduling? That would never happen in 2.4, cdrecord 1.10 ..


Track 10:   25 of   32 MB written (fifo  25%) [buf  94%]  15.8x.cdrecord: 
Success. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 02 3C 76 00 00 1B 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: F1 00 05 00 32 35 73 0E 00 00 00 00 21 02 00 00
Sense Key: 0x5 Illegal Request, deferred error, Segment 0
Sense Code: 0x21 Qual 0x02 (invalid address for write) Fru 0x0
Sense flags: Blk 3290483 (valid)
resid: 63504
cmd finished after 0.006s timeout 200s

write track data: error after 27179712 bytes
cdrecord: The current problem looks like a buffer underrun.
cdrecord: Try to use 'driveropts=burnfree'.
cdrecord: Make sure that you are root, enable DMA and check your HW/OS set up.
cdrecord: Success. test unit ready: scsi sendcmd: no error
CDB:  00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0E 00 00 00 00 30 00 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x30 Qual 0x00 (incompatible medium installed) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.005s timeout 200s
Writing  time:  139.113s
Average write speed  32.0x.
Min drive buffer fill was 80%
Fixating...
WARNING: Some drives don't like fixation in dummy mode.
cdrecord: Success. flush cache: scsi sendcmd: no error
CDB:  35 00 00 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0E 00 00 00 00 30 00 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x30 Qual 0x00 (incompatible medium installed) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.005s timeout 200s
Trouble flushing the cache
cdrecord: Success. test unit ready: scsi sendcmd: no error
CDB:  00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0E 00 00 00 00 30 00 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x30 Qual 0x00 (incompatible medium installed) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.006s timeout 200s
Fixating time:   26.117s


hdparm:
IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  1 (on)

