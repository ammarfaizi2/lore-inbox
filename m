Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275639AbRJAWMz>; Mon, 1 Oct 2001 18:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275641AbRJAWMp>; Mon, 1 Oct 2001 18:12:45 -0400
Received: from logger.gamma.ru ([194.186.254.23]:23565 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S275639AbRJAWMh>;
	Mon, 1 Oct 2001 18:12:37 -0400
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: 2.4.10 - sequential reading of SCSI CDROM - I/O error
Date: 2 Oct 2001 01:43:25 +0400
Organization: Average
Message-ID: <9pao1t$fr$1@pccross.average.org>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.4.10 (x86 SMP, same behavior if booted as "nosmp noapic")
it is impossible to read ISO image of SCSI CDROM.  First 196 Kb
are read and then there is an "Input/output error".  CD is good,
it can be mounted and all data is accessible; also, image can
be read successfully under 2.4.9.

$ ls -lL /dev/cdrom 
brw-r-----    1 root     users     11,   0 Jul 18  1994 /dev/cdrom

$ cat /dev/cdrom >scherbak.iso
cat: /dev/cdrom: Input/output error

$ ls -l
total 196
-rw-r--r--    1 crosser  group      200704 Oct  1 09:46 scherbak.iso

$ dmesg
[...]
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 6, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
VFS: Disk change detected on device sr(11,0)
scsi1 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 1 channel 0.
sym53c8xx_reset: pid=0 reset_flags=1 serial_number=0 serial_number_at_timeout=0
scsi1: device driver called scsi_done() for a synchronous reset.
sym53c1010-33-1: restart (scsi reset).
sym53c1010-33-1: handling phase mismatch from SCRIPTS.
sym53c1010-33-1: Downloading SCSI SCRIPTS.
scsi1 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 1 channel 0.
sym53c8xx_reset: pid=0 reset_flags=1 serial_number=0 serial_number_at_timeout=0
scsi1: device driver called scsi_done() for a synchronous reset.
sym53c1010-33-1: restart (scsi reset).
sym53c1010-33-1: handling phase mismatch from SCRIPTS.
sym53c1010-33-1: Downloading SCSI SCRIPTS.
SCSI cdrom error : host 1 channel 0 id 6 lun 0 return code = 27070000
 I/O error: dev 0b:00, sector 392
scsi1 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 1 channel 0.
sym53c8xx_reset: pid=0 reset_flags=1 serial_number=0 serial_number_at_timeout=0
scsi1: device driver called scsi_done() for a synchronous reset.
sym53c1010-33-1: restart (scsi reset).
sym53c1010-33-1: handling phase mismatch from SCRIPTS.
sym53c1010-33-1: Downloading SCSI SCRIPTS.
SCSI cdrom error : host 1 channel 0 id 6 lun 0 return code = 27070000
 I/O error: dev 0b:00, sector 394
sym53c1010-33-1-<6,*>: FAST-10 SCSI 10.0 MB/s (100.0 ns, offset 15)
Device not ready.  Make sure there is a disc in the drive.
scsi1 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 1 channel 0.
sym53c8xx_reset: pid=0 reset_flags=1 serial_number=0 serial_number_at_timeout=0
scsi1: device driver called scsi_done() for a synchronous reset.
sym53c1010-33-1: restart (scsi reset).
sym53c1010-33-1: handling phase mismatch from SCRIPTS.
sym53c1010-33-1: Downloading SCSI SCRIPTS.
scsi1 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 1 channel 0.
sym53c8xx_reset: pid=0 reset_flags=1 serial_number=0 serial_number_at_timeout=0
scsi1: device driver called scsi_done() for a synchronous reset.
sym53c1010-33-1: restart (scsi reset).
sym53c1010-33-1: handling phase mismatch from SCRIPTS.
sym53c1010-33-1: Downloading SCSI SCRIPTS.
SCSI cdrom error : host 1 channel 0 id 6 lun 0 return code = 27070000
 I/O error: dev 0b:00, sector 392
scsi1 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 1 channel 0.
sym53c8xx_reset: pid=0 reset_flags=1 serial_number=0 serial_number_at_timeout=0
scsi1: device driver called scsi_done() for a synchronous reset.
sym53c1010-33-1: restart (scsi reset).
sym53c1010-33-1: handling phase mismatch from SCRIPTS.
sym53c1010-33-1: Downloading SCSI SCRIPTS.
SCSI cdrom error : host 1 channel 0 id 6 lun 0 return code = 27070000
 I/O error: dev 0b:00, sector 394
sym53c1010-33-1-<6,*>: FAST-10 SCSI 10.0 MB/s (100.0 ns, offset 15)
Device not ready.  Make sure there is a disc in the drive.
Uniform CD-ROM driver unloaded
