Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTAEUrz>; Sun, 5 Jan 2003 15:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTAEUrz>; Sun, 5 Jan 2003 15:47:55 -0500
Received: from f231.law8.hotmail.com ([216.33.241.231]:19471 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265168AbTAEUrx>;
	Sun, 5 Jan 2003 15:47:53 -0500
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 ide-scsi and cdrecord
Date: Sun, 05 Jan 2003 15:56:23 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F231ZI5ID1EMwU6yuim00006fea@hotmail.com>
X-OriginalArrivalTime: 05 Jan 2003 20:56:24.0057 (UTC) FILETIME=[E8387E90:01C2B4FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That did It!

[root@amd1900 root]# cdrecord -scanbus -dev=/dev/hdc
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
scsibus0:
        0,0,0     0) 'SONY    ' 'CD-RW  CRX195E1 ' 'ZYS5' Removable CD-ROM
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

But look what happens if I use ATAPI:x,y,z ( tried all the combinations - 
same result):

[root@amd1900 root]# cdrecord -scanbus -dev=ATAPI:1,0,0
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
scsidev: 'ATAPI:1,0,0'
devname: 'ATAPI'
scsibus: 1 target: 0 lun: 0
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.7'
scsibus0:
        0,0,0     0) 'ADAPTEC ' 'ACB-5500        ' 'FAKE' NON CCS Disk
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *


FWIW, this is what the new xcdroast shows. Just never knew I had an Adaptec 
cdrw!!


BTW, is there a patch to fix ide-scsi yet?

thanks






>From: Jens Axboe <axboe@suse.de>
>To: sean darcy <seandarcy@hotmail.com>, linux-kernel@vger.kernel.org
>Subject: Re: 2.5.54 ide-scsi and cdrecord
>Date: Sun, 5 Jan 2003 16:37:28 +0100
>
>On Sat, Jan 04 2003, sean darcy wrote:
> > What am I missing? I thought we didn't need the scsi layer anymore.
>
>cdrecord -dev=/dev/hdX
>
>--
>Jens Axboe


_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

