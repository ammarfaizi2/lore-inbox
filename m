Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262976AbTDBMMY>; Wed, 2 Apr 2003 07:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262980AbTDBMMY>; Wed, 2 Apr 2003 07:12:24 -0500
Received: from ext-nj2gw-1.online-age.net ([216.35.73.163]:27837 "EHLO
	ext-nj2gw-1.online-age.net") by vger.kernel.org with ESMTP
	id <S262976AbTDBMMW>; Wed, 2 Apr 2003 07:12:22 -0500
From: "Kiniger, Karl (MED)" <karl.kiniger@med.ge.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 2 Apr 2003 14:23:24 +0200
Subject: how to interpret ide error messages (2.4)
Message-ID: <20030402122324.GA23847@ki_pc2.kretz.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

pls help to interpret the following error log: (kernel 2.4.18-5, redhat 7.3)

Mar 31 21:22:56:
kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: dma_intr: error=0x01 { AddrMarkNotFound }, LBAsect=20300322, sector=1263288
kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=20803307, sector=1766272
kernel: end_request: I/O error, dev 16:04 (hdc), sector 1766272
kernel: raid1: Disk failure on hdc4, disabling device.
kernel: ^IOperation continuing on 1 devices
kernel: raid1: hdc4: rescheduling block 1766272
kernel: md: updating md3 RAID superblock on device
kernel: md: (skipping faulty hdc4 )

Q1: does that mean that the first error (LBAsect=20300322, sector=1263288) was
    a soft one and the second error a hard error which resulted in the I/O error?

Q2: 19037025 (start of hdc4) + 1766272 = 20803297 and not 20803307 so what
    is the arithmetic magic here? I hope LBAsectors are counted from 0 up?

The affected sectors dont generate any error messages if I read them today...

Since this error happened ClearCase moans about a corrupted 
replica packet so I suspect that the errors somehow affected user space
as well - it is very well possible that stuff is unrelated but replica
corruptions did not happen during the whole 110 days of uptime with
lots of replica traffic.

BTW, it would be nice if 'dev 16:04' was more explicit about being hex
and not decimal. 

explanations are welcome.

Greetings,
Karl


Disk /dev/hdc: 14946 cylinders, 255 heads, 63 sectors/track
Units = sectors of 512 bytes, counting from 0

   Device Boot    Start       End  #sectors  Id  System
/dev/hdc1            63    144584    144522  fd  Linux raid autodetect
/dev/hdc2        144585   2249099   2104515  fd  Linux raid autodetect
/dev/hdc3       2249100  19037024  16787925  fd  Linux raid autodetect
/dev/hdc4      19037025 240107489 221070465  fd  Linux raid autodetect

-- 
Karl Kiniger        karl.kiniger@med.ge.com
GE Medical Kretztechnik
Tiefenbach 15
A-4871 Zipf         Tel: (++43) 7682-3800-710  Fax (++43) 7682-3800-47
