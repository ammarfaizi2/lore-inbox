Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSEBVkN>; Thu, 2 May 2002 17:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315441AbSEBVkM>; Thu, 2 May 2002 17:40:12 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21901 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315439AbSEBVkL>;
	Thu, 2 May 2002 17:40:11 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 2 May 2002 23:40:08 +0200 (MEST)
Message-Id: <UTC200205022140.g42Le8N14139.aeb@smtp.cwi.nl>
To: akpm@zip.com.au, daniel@rimspace.net
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 2.5.12, serious ext3 filesystem corrupting behavior

I have had problems with 2.5.10 (first few blocks of the root
filesystem overwritten) and then went back to 2.5.8 that I had
used for a while already, but then also noticed corruption there.
Back at 2.4.17 today..

In my case the problem was almost certainly the IDE code.
More in particular, the 2.5.8 corruption happened on four
different occasions, on two different disks, hanging off
an HPT366 that is without problems on 2.4*. Three of the
four times there were messages like

Apr 29 15:26:00 kernel: hde: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
Apr 29 15:26:00 kernel: hde: task_out_intr: error=0x04 { DriveStatusError }

May  2 01:21:23 kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
May  2 01:21:23 kernel: hdf: no DRQ after issuing WRITE
May  2 01:21:37 kernel: hdf: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
May  2 01:21:37 kernel: hdf: task_out_intr: error=0x04 { DriveStatusError }

Each time some data was written at a wrong address on disk.
Now these are ext2 filesystems, so I noticed.
Elsewhere I have ext3 and reiserfs, but journalling does not
protect against IDE drivers that write stuff to the wrong disk block.

Andries
