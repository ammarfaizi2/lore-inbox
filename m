Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVCZDEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVCZDEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVCZDEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:04:13 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:14805 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261925AbVCZDD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:03:57 -0500
Message-ID: <4244D169.6070504@comcast.net>
Date: Fri, 25 Mar 2005 22:05:13 -0500
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.11.5 doesn't recognize Plextor 712 SATA DVD burner
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everybody,

I have a stock 2.6.11.5 kernel configured for SATA (libata), which sees
my SATA hard drive but not my SATA DVD burner.  My system is a dual
Opteron 244 running an SMP kernel.  The motherboard is MSI K8T Master2 FAR.

I have only been successful in getting the SATA DVD burner to work if I
enable *both* libata and the deprecated/conflicting support for SATA in
the kernel configuration GUI, but the result does not work reliably.
The SATA DVD burner becomes unaccessible after a while, requiring a reboot.

In my most recent attempt to make this work, I disabled the deprecated
SATA support, enabled libata, and put in #define ATA_ENABLE_ATAPI
(removed the corresponding #undef) in libata.h prior to recompiling the
kernel.  This didn't allow me to see the SATA DVD either.  I read a post
somewhere on the Internet which suggested that this had worked for someone.

I am at a loss as to how to proceed to make the SATA DVD burner
function, and I'm hoping that someone will be able to help.

Here is some (hopefully) useful information.  Please let me know if you
need more info, and I'd be happy to provide it.  I'm also willing to
experiment with kernel patches if necessary.

Please reply directly to me as I do not subscribe to the list.

>From /proc/scsi/scsi:

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MAXTOR   Model: ATLAS10K5_73WLS  Rev: JNX0
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-M1401 Rev: 1009
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: Seagate  Model: STT20000N        Rev: 7A61
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6B200S0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05

>From dmesg:

libata version 1.10 loaded.
sata_via version 1.1
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 11 (level, low) -> IRQ 11
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 11
ata2: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 11
ata1: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:0007
ata1: dev 0 ATAPI, max UDMA/33
ata1: dev 0 configured for UDMA/33
scsi1 : sata_via
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043
88:407f
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi2 : sata_via
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x1
  Vendor: ATA       Model: Maxtor 6B200S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0

>From lspci:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP]
Host Bridge (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800 South]
0000:00:07.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
0000:00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705
Gigabit Ethernet (rev 03)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA
RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
RV200 QW [Radeon 7500]

Thanks in advance for your help.

Andy

-- 
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

