Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbTBLOkN>; Wed, 12 Feb 2003 09:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbTBLOkM>; Wed, 12 Feb 2003 09:40:12 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:35592 "HELO k2.dsa-ac.de")
	by vger.kernel.org with SMTP id <S267418AbTBLOkL>;
	Wed, 12 Feb 2003 09:40:11 -0500
Date: Wed, 12 Feb 2003 15:49:56 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 "Badness in kobject_register at lib/kobject.c:152"
In-Reply-To: <1044969981.12906.21.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0302121509481.1173-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Known problem. Its probably fixed in the 2.4 changes I made to the
> probe and flash bits yesterday. Its two bugs together. The vanishing
> disk is definitely fixed, the oops from drive->id = NULL should be
> sorted too (and the general noprobe, cdrom cases)

Yep! Works! Thanks! There are still errors coming:
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 31488 sectors (16 MB) w/1KiB Cache, CHS=246/4/32, BUG <=============
Then same for hdb, then
Partition chack:
 hda:hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x04 { DriveStatusError }
repeated 4 times, then
hda: DMA disabled
hdb: DMA disabled
ide0: reset: success
 hda1
 hdb: hdb1

then, on mounting root again
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!
/dev/hda1: clean...
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!
VFS: busy inodes on changed media.
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!

And then these errors appear again on some disk-opoerations, e.g. when
running lilo, doing dd if=/dev/hda, and some others (raw access?). Can
this errors be disk-specific? (it's a SiliconTech disk, reported as
Hitachi) I can try some others, e.g. SunDisk.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

