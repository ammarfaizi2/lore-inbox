Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSHDAFK>; Sat, 3 Aug 2002 20:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSHDAFK>; Sat, 3 Aug 2002 20:05:10 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:28356 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S317253AbSHDAFJ>; Sat, 3 Aug 2002 20:05:09 -0400
Message-Id: <200208040017.g740HF5K000181@pool-141-150-241-241.delv.east.verizon.net>
Date: Sat, 3 Aug 2002 20:17:14 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 LILO FreeBSD partition problems
References: <200208032300.g73N0Pix000183@pool-141-150-241-241.delv.east.verizon.net> <20020803233035.GA29008@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020803233035.GA29008@win.tue.nl>; from aebr@win.tue.nl on Sun, Aug 04, 2002 at 01:30:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Sat, Aug 03, 2002 at 07:00:21PM -0400, Skip Ford wrote:
> 
> > While running 2.5.30 I receive this error when running LILO with a
> > FreeBSD partition in lilo.conf
> > 
> >   Device 0x0300: Invalid partition table, 3rd entry
> >     3D address:     1/0/530 (534240)
> >     Linear address: 1/14/8446 (8514450)
> > 
> > I removed the fbsd entry and LILO had no problems.  I then booted
> > to 2.4 and readded the fbsd partition and it installed fine.
> 
> Which LILO version is this?

21.4-3

> What do cfdisk -Ps /dev/hda 

Partition Table for /dev/hda

            First    Last
 # Type     Sector   Sector   Offset  Length   Filesystem Type (ID)   Flags
-- ------- -------- --------- ------ --------- ---------------------- ---------
 1 Primary        0  8193149      63  8193150  Win95 FAT32 (0B)       Boot (80)
 2 Primary  8193150  8514449       0   321300  Linux native (83)      None (00)
 3 Primary  8514450 26957069       0 18442620  BSD/386 (A5)           None (00)
 4 Primary 26957070 39873329       0 12916260  Extended (05)          None (00)
 5 Logical 26957070 35150219      63  8193150  Linux native (83)      None (00)
 6 Logical 35150220 35471519      63   321300  Linux native (83)      None (00)
 7 Logical 35471520 35567909      63    96390  Linux swap (82)        None (00)
 8 Logical 35567910 39873329      63  4305420  Linux native (83)      None (00)


> and cfdisk -Pt /dev/hda say?

Partition Table for /dev/hda

         ---Starting---      ----Ending----    Start Number of
 # Flags Head Sect Cyl   ID  Head Sect Cyl    Sector  Sectors
-- ----- ---- ---- ---- ---- ---- ---- ---- -------- ---------
 1  0x80    1    1    0 0x0B  254   63  509       63   8193087
 2  0x00    0    1  510 0x83  254   63  529  8193150    321300
 3  0x00    0    1  530 0xA5  254   63 1023  8514450  18442620
 4  0x00  254   63 1023 0x05  254   63 1023 26957070  12916260
 5  0x00  254   63 1023 0x83  254   63 1023       63   8193087
 6  0x00  254   63 1023 0x83  254   63 1023       63    321237
 7  0x00  254   63 1023 0x82  254   63 1023       63     96327
 8  0x00  254   63 1023 0x83  254   63 1023       63   4305357


> What are the kernel boot messages for this disk
> (dmesg | grep hda), both for 2.5.29

hda: Maxtor 2B020H1, DISK drive
 hda: 39876480 sectors w/2048KiB Cache, CHS=39560/16/63, UDMA(33)
 hda: [PTBL] [2482/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
 hda0: <bsd: hda9 hda10 hda11 hda12 hda13 hda14 >

> and 2.5.30?

hda: Maxtor 2B020H1, DISK drive
 hda: 39876480 sectors w/2048KiB Cache, CHS=39560/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
 hda3: <bsd: hda9 hda10 hda11 hda12 hda13 hda14 >

> Probably some LILO option like "ignore-table" or "linear" or "lba32"
> would help. But it is interesting to see where this 1/0/530 comes from.]

lba32 and linear each didn't work.  I didn't try ignore-table.  I see
the difference above between .29 and .30 with [PTBL] but I don't know
what it means.

-- 
Skip
