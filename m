Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVHaRhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVHaRhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVHaRhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:37:33 -0400
Received: from lucidpixels.com ([66.45.37.187]:4224 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S964902AbVHaRhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:37:32 -0400
Date: Wed, 31 Aug 2005 13:37:31 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org, akpm@osdl.org, support@promise.com
cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Linux Kernel 2.6.13-rc7 (WORKS) (2.6.13, DRQ/System CRASH)
Message-ID: <Pine.LNX.4.63.0508311328230.1945@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I am trying to get everyone together on this to hopefully solve a serious 
bug that I have seen on multiple machines with:

a) A Promise ATA/133 controller (ATA/100 works OK)
b) Kernel 2.6.12 or 2.6.13 (2.6.13-rc7 appears to be OK)

The drive is a Seagate 7200.8 400GB 7200RPM 8MB cache disk.
hde: ST3400832A, ATA DISK drive

With older kernels, if I *DO NOT ENABLE DMA* it does not crash.
If I *ENABLE DMA* then proceed to do anything with the disk, it will 
FREEZE the box, no oops, etc, *FREEZE*.

hdparm -t /dev/hde
mkfs.xfs -f /dev/hde1

Will freeze the box.

-------

Linux Kernel 2.6.13 final experiences the same problems as 2.6.12.5.

I have e-mailed the list quite a few times with this issue, I am surprised 
very few people run into it.

Here is the error in the logs:

Aug 31 11:30:25 p34 kernel: hde: dma_timer_expiry: dma status == 0x20
Aug 31 11:30:25 p34 kernel: hde: DMA timeout retry
Aug 31 11:30:25 p34 kernel: PDC202XX: Primary channel reset.
Aug 31 11:30:25 p34 kernel: hde: timeout waiting for DMA
Aug 31 11:30:25 p34 kernel: hde: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Aug 31 11:30:25 p34 kernel: hde: drive not ready for command
Aug 31 11:30:25 p34 kernel: hde: status timeout: status=0xd0 { Busy }
Aug 31 11:30:25 p34 kernel: PDC202XX: Primary channel reset.
Aug 31 11:30:25 p34 kernel: hde: no DRQ after issuing MULTWRITE_EXT
Aug 31 11:30:25 p34 kernel: ide2: reset: success

After this, the machine locks up with 2.6.13.

With 2.6.13-rc7, I have not seen this once.

Can anyone offer any insight to why this is happening? I have a few 
machines with the ATA/133 controller and 400GB drives; therefore, I'd 
prefer to fix the problem rather than hooking up older, ATA/100 drives, 
just so I can run newer kernels...

Thanks.


