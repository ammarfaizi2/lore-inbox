Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269908AbRHJESt>; Fri, 10 Aug 2001 00:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269905AbRHJESk>; Fri, 10 Aug 2001 00:18:40 -0400
Received: from gear.torque.net ([204.138.244.1]:4371 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S269906AbRHJESg>;
	Fri, 10 Aug 2001 00:18:36 -0400
Message-ID: <3B735FCF.E197DD5B@torque.net>
Date: Fri, 10 Aug 2001 00:15:11 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        devfs-announce-list@mobilix.ras.ucalgary.ca
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs, scsi_debug
In-Reply-To: <200108020642.f726g0L15715@mobilix.ras.ucalgary.ca>
Content-Type: multipart/mixed;
 boundary="------------91092E9BFA3DE7B2A2E95C38"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------91092E9BFA3DE7B2A2E95C38
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Richard Gooch wrote:
> 
>   Hi, all. Below is my second cut of a patch that adds support for
> large numbers of SCSI discs (approximately 2144). I'd like people to
> try this out. I've fixed a couple of "minor" typos that happened to
> disable sd detection. I've also tested this patch: it works fine on my
> 3 drive system. In addition, I've switched to using vmalloc() for key
> data structures, so the kmalloc() limitations shouldn't hit us. I've
> added an in_interrupt() test to sd_init() just in case.
> 
> There are now 2 cases I'd like to have tested:
> - people with 17 to 128 SCSI discs
> - people with >128 SCSI discs
> 
> because each of these exercises a slightly different setup path.
> Please send success or failure reports to me.

For people who are interested in Richard's patch and
don't have a large number of SCSI devices lying
around this may help:
Attached is a version of the scsi_debug adapter driver
that fakes 294 disks across 42 fake controllers. The
number it fakes can be tweaked in the top of scsi_debug.c
[I'll let Richard try 2144 disks :-)]

Each disk has 3 partitions and shares the same 8 MB of
RAM. These disks can't be repartitioned with fdisk but
can be mkfs-ed, mounted and used.

My kernel is lk 2.4.7 with Richard's patch described above.
I have set: CONFIG_SD_EXTRA_DEVS=300
so that I can load scsi_debug as a module.

Here is a list of target 0 on the last host:

$ ls -l /devfs/scsi/host46/bus0/target0/lun0/*
brw-------    1 root     root     114,  16 Dec 31  1969
                        /devfs/scsi/host46/bus0/target0/lun0/disc
brw-------    1 root     root     114,  17 Dec 31  1969
                        /devfs/scsi/host46/bus0/target0/lun0/part1
brw-------    1 root     root     114,  18 Dec 31  1969
                        /devfs/scsi/host46/bus0/target0/lun0/part2
brw-------    1 root     root     114,  19 Dec 31  1969
                        /devfs/scsi/host46/bus0/target0/lun0/part3

Note the large major device number that devfs is pulling
from the unused pool. Devfs makes some noise when
'rmmod scsi_debug' is executed but otherwise things looked
ok.

Doug Gilbert
--------------91092E9BFA3DE7B2A2E95C38
Content-Type: application/octet-stream;
 name="scsi_debug_many_disks.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="scsi_debug_many_disks.tgz"

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
/gGqBbNYAHgAAA==
--------------91092E9BFA3DE7B2A2E95C38--

