Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293725AbSCKNYl>; Mon, 11 Mar 2002 08:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293727AbSCKNYc>; Mon, 11 Mar 2002 08:24:32 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:9235 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S293725AbSCKNYO>; Mon, 11 Mar 2002 08:24:14 -0500
Date: Mon, 11 Mar 2002 13:24:02 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: <gibbs@scsiguy.com>
cc: <linux-kernel@vger.kernel.org>
Subject: aic7xxx: Slow negotiation?
Message-ID: <Pine.LNX.4.33.0203111202410.25220-101000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1388574315-1806642964-1015853042=:29700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1388574315-1806642964-1015853042=:29700
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

The new aic7xxx driver (in 2.4.17, 2.5.1-pre1 and 2.5.6, at
least) negotiates only 11.626MB/s transfers from my disks.
The old one can extract 40MB/s transfers (though the disks
themselves can only do a little over 20MB/s each).

My adapter is an on-board one on my dual P3-450:

00:09.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 04)
	Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
	Flags: bus master, medium devsel, latency 64, IRQ 16
	I/O ports at d400 [size=256]
	Memory at efffe000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at effe0000 [disabled] [size=64K]
	Capabilities: <available only to root>

00:09.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 04)
	Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
	Flags: bus master, medium devsel, latency 64, IRQ 16
	I/O ports at d800 [size=256]
	Memory at effff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>


The old driver says:

(scsi0) <Adaptec AIC-7895 Ultra SCSI host adapter> found at PCI 0/9/1
(scsi0) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 383 instructions downloaded
(scsi1) <Adaptec AIC-7895 Ultra SCSI host adapter> found at PCI 0/9/0
(scsi1) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 383 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
       <Adaptec AIC-7895 Ultra SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
       <Adaptec AIC-7895 Ultra SCSI host adapter>
  Vendor: QUANTUM   Model: ATLAS IV 9 WLS    Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: QUANTUM   Model: ATLAS IV 9 WLS    Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: QUANTUM   Model: ATLAS IV 9 WLS    Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
(scsi0:0:1:0) Synchronous at 40.0 Mbyte/sec, offset 8.
SCSI device sdb: 17942584 512-byte hdwr sectors (9187 MB)
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9 >
(scsi0:0:2:0) Synchronous at 40.0 Mbyte/sec, offset 8.
SCSI device sdc: 17942584 512-byte hdwr sectors (9187 MB)
 sdc: sdc1 sdc2 < sdc5 sdc6 >


The new one offers:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel B, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: QUANTUM   Model: ATLAS IV 9 WLS    Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 11.626MB/s transfers (5.813MHz, offset 8, 16bit)
  Vendor: QUANTUM   Model: ATLAS IV 9 WLS    Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:1): 11.626MB/s transfers (5.813MHz, offset 8, 16bit)
  Vendor: QUANTUM   Model: ATLAS IV 9 WLS    Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:2): 11.626MB/s transfers (5.813MHz, offset 8, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
SCSI device sdb: 17942584 512-byte hdwr sectors (9187 MB)
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9 >
SCSI device sdc: 17942584 512-byte hdwr sectors (9187 MB)
 sdc: sdc1 sdc2 < sdc5 sdc6 >


I do have a Tekram card in here as well:

00:10.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. TRM-S1040
	Flags: bus master, medium devsel, latency 64, IRQ 19
	I/O ports at d000 [size=256]
	Memory at efffc000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at effc0000 [disabled] [size=64K]
	Capabilities: <available only to root>

But whether or not I remember to patch in the out-of-tree
driver doesn't seem to affect anything.

I've attached /proc/scsi/aic7xxx/0 from the old driver
(because that's what I happen to have booted at the
moment).  Below is /proc/scsi/scsi.

Am I doing anything wrong or silly here?

Please let me know if there's anything else I can offer.

Cheers,
Matthew.


Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: ATLAS IV 9 WLS   Rev: 0909
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: ATLAS IV 9 WLS   Rev: 0909
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: ATLAS IV 9 WLS   Rev: 0909
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: HP35480A         Rev: 1109
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 04 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0c
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 05 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6401TA Rev: 1009
  Type:   CD-ROM                           ANSI SCSI revision: 02

--1388574315-1806642964-1015853042=:29700
Content-Type: APPLICATION/octet-stream; name="0.old"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203111324020.29700@sphinx.mythic-beasts.com>
Content-Description: 
Content-Disposition: attachment; filename="0.old"


--1388574315-1806642964-1015853042=:29700--
