Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbRIDUtD>; Tue, 4 Sep 2001 16:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRIDUsy>; Tue, 4 Sep 2001 16:48:54 -0400
Received: from [24.93.67.53] ([24.93.67.53]:57860 "EHLO Mail6.nc.rr.com")
	by vger.kernel.org with ESMTP id <S268997AbRIDUst>;
	Tue, 4 Sep 2001 16:48:49 -0400
Subject: cdrecord with LSI53C1010 and Yamaha CRW2100S
From: "C. Linus Hicks" <lhicks@nc.rr.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 04 Sep 2001 16:48:40 -0400
Message-Id: <999636520.5244.146.camel@lh2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been unsuccessful trying to burn a CD-R since upgrading my
computer and I'm not sure where to go with this. I decided to try here.
I suspect a problem with the SYM53C8xx driver, and I think there may
also be additional problems elsewhere. My old system worked. It was:

RedHat 7.0 with 2.2.19 kernel
ASUS P2B-DS (440BX chipset) with 2 600MHz Intel processors
On-board Adaptec AIC-7890 with the new aic7xxx driver
Add-on Adaptec 2940 PCI adapter (narrow devices attached here)
Yamaha CRW6416S CD writer

My new system:

RedHat 7.1 with 2.4.8-ac11 kernel
Tyan Thunder HEsl S2567 (ServerWorks chipset) with 2 1000MHz Intel
processors
On-board LSI 53C1010-66 (running at 33MHz) dual channel SCSI
Add-on LSI21003 with 53C1010-33 (narrow devices here)
SYM53C8xx driver
Yamaha CRW2100S CD writer

I looked for problem reports with the 2100S and didn't see any, rather
several reports that it worked okay. I updated the firmware to the
latest - 1.0N and it didn't help.

I have tried several versions of cdrecord including the latest 1.11a05
with associated tools to no avail.

When I try burning a CD, sometimes I get errors and sometimes it appears
to work. When I try to mount a CD-R that burned successfully in a
Toshiba DVD-ROM drive, I get errors like this:

[root@lh2 /root]# mount /mnt/cdrom
mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
       or too many mounted file systems
[root@lh2 /root]#

And in /var/log/messages:

Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1:4: ERROR (0:18) (1-21-0)
(10/30) @ (script 8e8:110007c1).
Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: script cmd = 88080000
Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: regdump: da 10 c0 30 47 10
04 0e 80 01 84 21 80 01 01 00 00 b0 d6 37 08 00 00 00.
Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: ctest4/sist original
0x8/0x18  mod: 0x18/0x0
Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: restart (scsi reset).
Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: handling phase mismatch
from SCRIPTS.
Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: Downloading SCSI SCRIPTS.
Sep  4 16:31:20 LH2 kernel: sym53c1010-33-1-<4,*>: FAST-20 SCSI 20.0
MB/s (50.0 ns, offset 16)
Sep  4 16:31:20 LH2 kernel:  I/O error: dev 0b:00, sector 68
Sep  4 16:31:20 LH2 kernel: isofs_read_super: bread failed, dev=0b:00,
iso_blknum=17, block=17

I tried replacing the LSI21003 with a 2940 and burned a CD-R. The
process went smoothly with no errors reported. I mounted the burned CD
in the Toshiba successfully and listed the contents. I did not think to
verify the CD with the mastered file. I then switched back to the
LSI21003 and tried to mount the burned CD-R. I got:

[root@lh2 /root]# mount /mnt/cdrom
mount: Not a directory
[root@lh2 /root]#

And in /var/log/messages:

Sep  4 15:15:47 LH2 kernel: scsi : aborting command due to timeout : pid
0, scsi1, channel 0, id 4, lun 0 Read (10) 00 00 00 00 1c 00 00 01 00
Sep  4 15:15:47 LH2 kernel: sym53c8xx_abort: pid=0 serial_number=149685
serial_number_at_timeout=149685
Sep  4 15:15:48 LH2 kernel: SCSI host 1 abort (pid 0) timed out -
resetting
Sep  4 15:15:48 LH2 kernel: SCSI bus is being reset for host 1 channel
0.
Sep  4 15:15:48 LH2 kernel: sym53c8xx_reset: pid=0 reset_flags=2
serial_number=149685 serial_number_at_timeout=149685
Sep  4 15:15:48 LH2 kernel: sym53c1010-33-1: restart (scsi reset).
Sep  4 15:15:48 LH2 kernel: sym53c1010-33-1: handling phase mismatch
from SCRIPTS.
Sep  4 15:15:48 LH2 kernel: sym53c1010-33-1: Downloading SCSI SCRIPTS.
Sep  4 15:15:48 LH2 kernel: sym53c1010-33-1-<4,*>: FAST-20 SCSI 20.0
MB/s (50.0 ns, offset 16)
Sep  4 15:15:48 LH2 kernel: Device 0b:00 not ready.
Sep  4 15:15:48 LH2 kernel:  I/O error: dev 0b:00, sector 112
Sep  4 15:15:49 LH2 kernel: ISOFS: unable to read i-node block
Sep  4 15:15:49 LH2 kernel: Device 0b:00 not ready.
Sep  4 15:15:49 LH2 kernel:  I/O error: dev 0b:00, sector 128
Sep  4 15:15:49 LH2 kernel: ISOFS: unable to read i-node block

Any help would be appreciated, and if anyone needs additional
information I will be glad to do what I can.

Linus


