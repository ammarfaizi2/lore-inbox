Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319759AbSILRWE>; Thu, 12 Sep 2002 13:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319760AbSILRWD>; Thu, 12 Sep 2002 13:22:03 -0400
Received: from achenar.cyan.com ([216.64.128.131]:54721 "EHLO cyan.com")
	by vger.kernel.org with ESMTP id <S319759AbSILRWC>;
	Thu, 12 Sep 2002 13:22:02 -0400
From: "Rob Emanuele" <rje@cyan.com>
To: <linux-kernel@vger.kernel.org>
Subject: SCSI TimeOuts and Resets on Sym53c875
Date: Thu, 12 Sep 2002 10:26:52 -0700
Message-ID: <OAEILKBAEOODHMLHNAFFGEOLEPAA.rje@cyan.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running the 2.4 kernel for about a year on several
computers.   On this one computer the scsi bus on a sym53c875J
resets at an alarming frequency.  More so if the bus is being
used.  This never happened with the 2.2 kernel so I keep
wondering if I need a new configuration parameter for the driver.
The device that seems to be causing the reset is a basic NEC SCSI
cd-rom drive.  The drive works fine: reads any disk I put in it.
I've also tried numerous settings in the scsi bios such as
turning queue tags on/off, R/W timeout length, device speed, etc.

Other people have also experienced this problem with the
sym53c875J chip and the sym53c8xx drive on the mailing list early
in the 2.4 release but no one seems to respond or know an answer.

Thanks for any help!

--Rob


>From "/var/log/messages":

Sep 11 10:13:43 pulsar kernel: scsi : aborting command due to
timeout : pid 428547, scsi0, channel 0, id 4, lun 0 Read TOC 00
00 00 00 00 00 00 0c 00
Sep 11 10:13:43 pulsar kernel: sym53c8xx_abort: pid=428547
serial_number=428547 serial_number_at_timeout=428547
Sep 11 10:13:46 pulsar kernel: SCSI host 0 abort (pid 428547)
timed out - resetting
Sep 11 10:13:46 pulsar kernel: SCSI bus is being reset for host 0
channel 0.
Sep 11 10:13:46 pulsar kernel: sym53c8xx_reset: pid=428547
reset_flags=2 serial_number=428547
serial_number_at_timeout=428547
Sep 11 10:13:46 pulsar kernel: sym53c875J-0: restart (scsi
reset).
Sep 11 10:13:46 pulsar kernel: sym53c875J-0: Downloading SCSI
SCRIPTS.
Sep 11 10:13:46 pulsar kernel: sym53c875J-0-<4,*>: FAST-10 SCSI
8.0 MB/s (125.0 ns, offset 15)
Sep 11 10:13:46 pulsar kernel: sym53c875J-0-<0,*>: FAST-10 WIDE
SCSI 20.0 MB/s (100.0 ns, offset 15)

>From "/proc/scsi/scsi":

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST15230W SUN4.2G Rev: 0738
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:461 Rev: 2.3d
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: HP       Model: C1130A           Rev: 3540
  Type:   Processor                        ANSI SCSI revision: 02

>From "/proc/scsi/sym53c8xx/0":

General information:
  Chip sym53c875J, device id 0x8f, revision id 0x4
  On PCI bus 0, device 11, function 0, IRQ 9
  Synchronous period factor 12, max commands per lun 32

>From "/var/log/dmesg":

SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno
= 2
PCI: Found IRQ 9 for device 00:0b.0
sym53c8xx: at PCI bus 0, device 11, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875J detected with Symbios NVRAM
sym53c875J-0: rev 0x4 on pci bus 0 device 11 function 0 irq 9
sym53c875J-0: Symbios format NVRAM, ID 7, Fast-20, Parity
Checking
sym53c875J-0: on-chip RAM at 0xef000000
sym53c875J-0: restart (scsi reset).
sym53c875J-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
blk: queue c7f54618, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision:
02
blk: queue c7f54818, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: NEC       Model: CD-ROM DRIVE:461  Rev: 2.3d
  Type:   CD-ROM                             ANSI SCSI revision:
02
blk: queue c7b55018, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: HP        Model: C1130A            Rev: 3540
  Type:   Processor                          ANSI SCSI revision:
02
blk: queue c7b55218, I/O limit 4095Mb (mask 0xffffffff)
sym53c875J-0-<0,0>: tagged command queue depth set to 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sym53c875J-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100.0 ns, offset
15)
SCSI device sda: 8386733 512-byte hdwr sectors (4294 MB)
Partition check:
 sda: sda1 sda2 sda3

