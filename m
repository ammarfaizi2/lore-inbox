Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947171AbWKKIwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947171AbWKKIwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 03:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947172AbWKKIwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 03:52:24 -0500
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:36873 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S1947171AbWKKIwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 03:52:23 -0500
Date: Sat, 11 Nov 2006 09:52:00 +0100
From: jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: wanted: more informative message if root device can't be found/mounted
Message-ID: <20061111085200.GA4167@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experimenting with turning off the PATA drivers and use SATA only,
since all my devices are now found by the SATA drivers in
2.6.19-rc5-mm1.

There is one area in which the kernel could, I think, do better. When
booting, there's no way for me to know where /dev/hda is going to end
up.

When the kernel mentions it can't mount the root device, all information
about the 12 harddisks in this system has long scrolled off the screen.

It would be really nice to see something like this:

kernel panic - unable to mount root device 09:02
Possible devices:

scsi 0:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
 sda: sda1
scsi 1:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
 sdb: sdb1
scsi 2:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
 sdc: sdc1
scsi 3:0:0:0: Direct-Access     ATA      ST3250823AS      3.02 PQ: 0 ANSI: 5
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
 sdd: sdd1
scsi 4:0:0:0: Direct-Access     ATA      ST3300622AS      3.AA PQ: 0 ANSI: 5
SCSI device sde: 586072368 512-byte hdwr sectors (300069 MB)
 sde: sde1 sde2
scsi 5:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
 sdf: sdf1
scsi 6:0:0:0: Direct-Access     ATA      ST3300622AS      3.AA PQ: 0 ANSI: 5
SCSI device sdg: 586072368 512-byte hdwr sectors (300069 MB)
 sdg: sdg1 sdg2
scsi 7:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
 sdh: sdh1
scsi 8:0:0:0: Direct-Access     ATA      WDC WD2000JB-32E 15.0 PQ: 0 ANSI: 5
SCSI device sdi: 390721968 512-byte hdwr sectors (200050 MB)
 sdi: sdi1 sdi2 < sdi5 sdi6 sdi7 sdi8 sdi9 >
scsi 9:0:0:0: Direct-Access     ATA      WDC WD2000JB-00F 15.0 PQ: 0 ANSI: 5
SCSI device sdj: 390721968 512-byte hdwr sectors (200050 MB)
 sdj: sdj1 sdj2 < sdj5 sdj6 sdj7 sdj8 sdj9 >
scsi 10:0:0:0: Direct-Access     ATA      WDC WD2500JB-00F 15.0 PQ: 0 ANSI: 5
SCSI device sdk: 488397168 512-byte hdwr sectors (250059 MB)
 sdk: sdk1
scsi 12:0:0:0: Direct-Access     ATA      ST3300831A       3.01 PQ: 0 ANSI: 5
SCSI device sdl: 586072368 512-byte hdwr sectors (300069 MB)
 sdl: sdl1

Or, even shorter:

kernel panic - unable to mount root device 09:02
Available devices/partitions:
scsi 0:0:0:0 ST3250823AS 3.03 (2500059 MB) sda: 1
scsi 1:0:0:0 ST3250823AS 3.03 (2500059 MB) sdb: 1
scsi 2:0:0:0 ST3250823AS 3.03 (2500059 MB) sdc: 1
scsi 3:0:0:0 ST3250823AS 3.02 (2500059 MB) sdd: 1
scsi 4:0:0:0 ST3300622AS 3.AA (3000069 MB) sde: 1 2
scsi 5:0:0:0 ST3250823AS 3.03 (2500059 MB) sdf: 1
scsi 6:0:0:0 ST3300622AS 3.AA (3000069 MB) sdg: 1 2
scsi 7:0:0:0 ST3250823AS 3.03 (2500059 MB) sdh: 1
scsi 8:0:0:0 WDC WD2000JB-32E 15.0 (200050 MB) sdi: 1 2 <5 6 7 8 9>
scsi 9:0:0:0 WDC WD2000JB-00F 15.0 (200050 MB) sdj: 1 2 <5 6 7 8 9>
scsi 10:0:0:0 WDC WD2500JB-00F 15.0 (250059 MB) sdk: 1
scsi 12:0:0:0 ST3300831A 3.01 (300069 MB) sdl: 1

which at least gives some information on what harddisk has gone where. I
know there's more possibilities, like udev, netconsole, etc., but this
seems rather straight-forward. Even on a 80x25 screen, I'd say most
peoples devices should fit.

I'd appreciate hints or pseudo-code on how to walk through the various
lists need to get this information on the screen!

Kind regards,
Jurriaan
-- 
Corrupt, corrupt from the bottom to the top
And you tell me it's the law
        The Levellers
Debian (Unstable) GNU/Linux 2.6.18-mm3 2x4826 bogomips load 0.24
