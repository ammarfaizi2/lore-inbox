Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWJGMGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWJGMGb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 08:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWJGMGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 08:06:31 -0400
Received: from mail.xor.at ([195.49.2.10]:35790 "EHLO mail.xor.at")
	by vger.kernel.org with ESMTP id S1750990AbWJGMGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 08:06:30 -0400
Message-ID: <4527983A.9030002@xor.at>
Date: Sat, 07 Oct 2006 14:06:18 +0200
From: Johannes Resch <jr@xor.at>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.6.18 and SATA DVD-RW Toshiba SH-W163A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get a Toshiba SH-W163A CD/DVD-RW SATA drive working with 
linux.

Both running 2.6.17.7 and 2.6.18 gave me some issues. However, in 
2.6.17.7, the drive was usable for reading CDs/DVDs (logging lots of 
"BUG: warning at drivers/scsi/libata-scsi.c:823/__ata_eh_qc_complete()" 
syslog entries, though).

In 2.6.18 it seems the drive is not working at all, and the boot process
takes ~1 minute longer due to speed probing on the SATA port.

Below is kernel output from both 2.6.17.7 and 2.6.18.
System is Athlon XP on a Via KT600 mainboard (Asus A7V600).

Any suggestions what may be wrong here?
I've verified with another OS that the device itself is working - so it 
should not be a hardware/cabling issue.

regards,
-jr

(Please CC me on replies, I'm not subscribed to lkml)

2.6.17.7:

   libata version 1.20 loaded.
   sata_via 0000:00:0f.0: version 1.1
   -> GSI 20 (level, low) -> IRQ 17
   sata_via 0000:00:0f.0: routed to hard irq line 0
   ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xB802 bmdma 0xA800 irq 17
   ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 17
   ata1: SATA link up 1.5 Gbps (SStatus 113)
   ata1: dev 0 cfg 49:0f00 82:0000 83:4000 84:4000 85:0000 86:0000 
87:4000 88:0407
   ata1: dev 0 ATAPI, max UDMA/33
   ata1(0): applying bridge limits
   ata1: dev 0 configured for UDMA/33
   scsi1 : sata_via
   ata2: SATA link down (SStatus 0)
   scsi2 : sata_via
  Vendor: TSSTcorp  Model: CD/DVDW SH-W163A  Rev: TS01
  Type:   CD-ROM                             ANSI SCSI revision: 05
  sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
  Uniform CD-ROM driver Revision: 3.20
  sr 1:0:0:0: Attached scsi CD-ROM sr0
  sd 0:0:0:0: Attached scsi generic sg0 type 0
  sd 0:0:4:0: Attached scsi generic sg1 type 0
  sr 1:0:0:0: Attached scsi generic sg2 type 5

   ata1: command 0xa0 timeout, stat 0x51 host_stat 0x1
   BUG: warning at drivers/scsi/libata-scsi.c:823/__ata_eh_qc_complete()
<c02cd070> __ata_eh_qc_complete+0xa0/0xb0  <c02cdf1b> 
ata_scsi_error+0x6b/0x160
<c02b1716> scsi_error_handler+0xb6/0x8d0  <c035fe04> schedule+0x2d4/0x650
<c013255b> kthread+0xab/0xf0  <c013256b> kthread+0xbb/0xf0
<c02b1660> scsi_error_handler+0x0/0x8d0  <c01324b0> kthread+0x0/0xf0
<c0101005> kernel_thread_helper+0x5/0x10

untrimmed output available at https://and.xor.at/kernel-2.6.17.7.txt


2.6.18:

  libata version 2.00 loaded.
   sata_via 0000:00:0f.0: version 2.0
   -> GSI 20 (level, low) -> IRQ 17
   sata_via 0000:00:0f.0: routed to hard irq line 0
   ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xB802 bmdma 0xA800 irq 17
   ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 17
   scsi1 : sata_via
   ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
   ata1.00: ATAPI, max UDMA/33
   ata1.00: applying bridge limits
   ata1.00: configured for UDMA/33
   scsi2 : sata_via
   ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
   ATA: abnormal status 0x7F on port 0xB407
  Vendor: TSSTcorp  Model: CD/DVDW SH-W163A  Rev: TS01
  Type:   CD-ROM                             ANSI SCSI revision: 05
  sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
  Uniform CD-ROM driver Revision: 3.20
  sr 1:0:0:0: Attached scsi CD-ROM sr0
  sd 0:0:0:0: Attached scsi generic sg0 type 0
  sd 0:0:4:0: Attached scsi generic sg1 type 0
  sr 1:0:0:0: Attached scsi generic sg2 type 5

   ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xB802 bmdma 0xA800 irq 17
   ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
   ata1.00: ATAPI, max UDMA/33
   ata1.00: applying bridge limits
   ata1.00: configured for UDMA/33
   ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
   ata1.00: (BMDMA stat 0x1)
   ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
   ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
   ata1: soft resetting port
   ata1.00: configured for UDMA/33
   ata1: EH complete
   ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
   ata1.00: (BMDMA stat 0x1)
   ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
   ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
   ata1: soft resetting port
   ata1.00: configured for UDMA/33
   ata1: EH complete
   ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
   ata1.00: (BMDMA stat 0x1)
   ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
   ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
   ata1: soft resetting port
   ata1.00: configured for UDMA/33
   ata1: EH complete
   ata1.00: limiting speed to UDMA/25
   ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
   ata1.00: (BMDMA stat 0x1)
   ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
   ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
   ata1: soft resetting port
   ata1.00: configured for UDMA/25
   sr0: CDROM (ioctl) error, command: <6>cdb[0]=0x43 43 00 00 00 00 00 
00 00 0c 40
   sr: Current [descriptor]: sense key=0xb
       ASC=0x0 ASCQ=0x0
   ata1: EH complete
   ata1.00: limiting speed to UDMA/16
   ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
   ata1.00: (BMDMA stat 0x1)
   ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
   ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
   ata1: soft resetting port
   ata1.00: configured for UDMA/16
   ata1: EH complete
   ata1.00: limiting speed to PIO4
   ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
   ata1.00: (BMDMA stat 0x1)
   ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
   ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
   ata1: soft resetting port
   ata1.00: configured for PIO4
   ata1: EH complete

untrimmed output available at https://and.xor.at/kernel-2.6.18.txt

