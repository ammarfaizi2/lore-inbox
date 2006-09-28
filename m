Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWI1OTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWI1OTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWI1OTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:19:33 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:29705 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S1161143AbWI1OTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:19:32 -0400
Date: Thu, 28 Sep 2006 16:19:23 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: dell poweredge 2400 harddisks going into offline mode when heavy I/O
	occurs
Message-ID: <20060928141923.GH9348@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Thu Sep 28 10:10:30 CEST 2006
X-Message-Flag: www.vanheusden.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Dell Poweredge 2400 with 6 scsi harddisks in (hw-) raid 5.
512MB ram, 2x P3.
When heavy disk i/o occurs, the system puts the harddisks into offline
mode causing the filesystems to be put in readonly. The current kernel
is 2.6.8, with 2.4.27 this did not occure. Googling did not help. The
disks all have green lights (there's a special led for each to indicate
errors - that one is off).

dmesg:
-----
SCSI subsystem initialized
ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 30 (level, low) -> IRQ 193
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

Using anticipatory io scheduler
(scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: NEC       Model: CD-ROM DRIVE:466  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
Red Hat/Adaptec aacraid driver (1.1.2-lk2 Sep  7 2006)
ACPI: PCI interrupt 0000:00:02.1[A] -> GSI 31 (level, low) -> IRQ 177
AAC0: kernel 2.5.4 build 2991
AAC0: monitor 2.5.4 build 2991
AAC0: bios 2.5.0 build 2991
AAC0: serial 7b0c10d0fafaf001
scsi1 : percraid
  Vendor: DELL      Model: PERCRAID RAID5    Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 5, lun 0,  type 5
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
SCSI device sda: 88855680 512-byte hdwr sectors (45494 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
SCSI device sda: drive cache: write through
 /dev/scsi/host1/bus0/target0/lun0: p1 p2
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0

errors:
------
Sep 28 16:05:12 kasparov kernel: aacraid: Host adapter reset request. SCSI hang ?
Sep 28 16:06:12 kasparov kernel: aacraid: SCSI bus appears hung
Sep 28 16:06:12 kasparov kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
Sep 28 16:06:12 kasparov last message repeated 99 times
Sep 28 16:06:12 kasparov kernel: SCSI error : <1 0 0 0> return code = 0x6000000
Sep 28 16:06:12 kasparov kernel: end_request: I/O error, dev sda, sector 8827879
Sep 28 16:06:12 kasparov kernel: Buffer I/O error on device dm-2, logical block 677445
Sep 28 16:06:12 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:12 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 16:06:12 kasparov kernel: Buffer I/O error on device dm-2, logical block 677446
Sep 28 16:06:12 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:12 kasparov kernel: Buffer I/O error on device dm-2, logical block 677447
Sep 28 16:06:12 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:12 kasparov kernel: Buffer I/O error on device dm-2, logical block 677448
Sep 28 16:06:12 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:12 kasparov kernel: Buffer I/O error on device dm-2, logical block 677449
Sep 28 16:06:12 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:12 kasparov kernel: Buffer I/O error on device dm-2, logical block 677450
Sep 28 16:06:12 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:12 kasparov kernel: Buffer I/O error on device dm-2, logical block 677451
Sep 28 16:06:12 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:12 kasparov kernel: Buffer I/O error on device dm-2, logical block 677452
Sep 28 16:06:12 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:12 kasparov kernel: Buffer I/O error on device dm-2, logical block 677453
Sep 28 16:06:13 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:13 kasparov kernel: Buffer I/O error on device dm-2, logical block 677454
Sep 28 16:06:13 kasparov kernel: lost page write due to I/O error on dm-2
Sep 28 16:06:13 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 16:06:13 kasparov last message repeated 88 times
Sep 28 16:06:13 kasparov syslogd: /var/log/syslog: Read-only file system
Sep 28 16:06:13 kasparov syslogd: /var/log/kern.log: Read-only file system
Sep 28 16:06:13 kasparov syslogd: /var/log/messages: Read-only file system
Sep 28 16:06:13 kasparov kernel: SCSI error : <1 0 0 0> return code = 0x6000000
Sep 28 16:06:13 kasparov kernel: end_request: I/O error, dev sda, sector 8828007
Sep 28 16:06:13 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
...
Sep 28 16:06:13 kasparov kernel: SCSI error : <1 0 0 0> return code = 0x6000000
Sep 28 16:06:13 kasparov kernel: end_request: I/O error, dev sda, sector 8830951
Sep 28 16:06:13 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 16:06:13 kasparov last message repeated 2 times
Sep 28 16:06:13 kasparov kernel: Aborting journal on device dm-4.
Sep 28 16:06:13 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 16:06:13 kasparov last message repeated 3 times
Sep 28 16:06:13 kasparov kernel: Aborting journal on device dm-1.
Sep 28 16:06:13 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 16:06:13 kasparov last message repeated 31 times
Sep 28 16:06:13 kasparov kernel: ext3_abort called.
Sep 28 16:06:13 kasparov kernel: EXT3-fs abort (device dm-4): ext3_journal_start: Detected aborted journal
Sep 28 16:06:13 kasparov kernel: Remounting filesystem read-only
Sep 28 16:06:13 kasparov kernel: EXT3-fs error (device dm-4) in start_transaction: Journal has aborted
Sep 28 16:06:13 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 16:06:13 kasparov last message repeated 2 times
Sep 28 16:06:13 kasparov kernel: EXT3-fs error (device dm-4) in start_transaction: Journal has aborted
Sep 28 16:06:13 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 16:06:13 kasparov kernel: EXT3-fs error (device dm-4) in start_transaction: Journal has aborted
Sep 28 16:06:13 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 16:06:13 kasparov last message repeated 8 times
Sep 28 16:06:13 kasparov kernel: SCSI error : <1 0 0 0> return code = 0x6000000
Sep 28 16:06:13 kasparov kernel: end_request: I/O error, dev sda, sector 8831079
Sep 28 16:06:13 kasparov kernel: scsi1 (0:0): rejecting I/O to offline device
...
Sep 28 16:06:14 kasparov kernel: SCSI error : <1 0 0 0> return code = 0x6000000
Sep 28 16:06:14 kasparov kernel: end_request: I/O error, dev sda, sector 11177631
Sep 28 16:06:14 kasparov kernel: ext3_abort called.
Sep 28 16:06:14 kasparov kernel: EXT3-fs abort (device dm-1): ext3_journal_start: Detected aborted journal
Sep 28 16:06:14 kasparov kernel: Remounting filesystem read-only

proc:
----
kasparov:/home/folkert# cat /proc/interrupts
           CPU0       CPU1
  0:     159442     182242    IO-APIC-edge  timer
  1:          0          9    IO-APIC-edge  i8042
  7:          2          0    IO-APIC-edge  parport0
  8:          3          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 10:          0          0   IO-APIC-level  ohci_hcd
177:       3314       3540   IO-APIC-level  aacraid
185:      33638        839   IO-APIC-level  eth0
193:         53         53   IO-APIC-level  aic7xxx
NMI:          0          0
LOC:     341531     341530
ERR:          0
MIS:          0

kasparov:/home/folkert# cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 6.2.36
Adaptec aic7880 Ultra SCSI adapter
aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs
Allocated SCBs: 4, SG List Length: 128

Serial EEPROM:
0xc358 0xc358 0xc358 0xc358 0xc358 0xc358 0xc358 0xc358
0xc378 0xc378 0xc378 0xc378 0xc378 0xc378 0xc378 0xc378
0x58e6 0x5c5e 0x2807 0x0008 0xffff 0xffff 0xffff 0xffff
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0250 0x1619

Target 0 Negotiation Settings
        User: 20.000MB/s transfers (20.000MHz, offset 127)
Target 1 Negotiation Settings
        User: 20.000MB/s transfers (20.000MHz, offset 127)
Target 2 Negotiation Settings
        User: 20.000MB/s transfers (20.000MHz, offset 127)
Target 3 Negotiation Settings
        User: 20.000MB/s transfers (20.000MHz, offset 127)
Target 4 Negotiation Settings
        User: 20.000MB/s transfers (20.000MHz, offset 127)
Target 5 Negotiation Settings
        User: 20.000MB/s transfers (20.000MHz, offset 127)
        Goal: 20.000MB/s transfers (20.000MHz, offset 15)
        Curr: 20.000MB/s transfers (20.000MHz, offset 15)
        Channel A Target 5 Lun 0 Settings
                Commands Queued 8
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Target 6 Negotiation Settings
        User: 20.000MB/s transfers (20.000MHz, offset 127)
Target 7 Negotiation Settings
        User: 20.000MB/s transfers (20.000MHz, offset 127)

kasparov:/home/folkert# cat /proc/scsi/aacraid/1
percraid


Folkert van Heusden

-- 
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
