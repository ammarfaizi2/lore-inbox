Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSKGUVZ>; Thu, 7 Nov 2002 15:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSKGUVZ>; Thu, 7 Nov 2002 15:21:25 -0500
Received: from mail.orcon.net.nz ([210.55.12.3]:30093 "EHLO mail.orcon.net.nz")
	by vger.kernel.org with ESMTP id <S261572AbSKGUVY>;
	Thu, 7 Nov 2002 15:21:24 -0500
Message-ID: <011101c2869c$0f2bbce0$6df058db@PC2>
From: "Craig Whitmore" <linuxkernel@orcon.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: Adaptec S3210 RAID5 and Lilo
Date: Fri, 8 Nov 2002 09:27:14 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Spam-Score: 1.5 (*) INVALID_MSGID,SPAM_PHRASE_00_01,USER_AGENT_OE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using an Adaptec S3210 RAID5 card in a Dual Xeon 2.4G (Using various
kernels up to 2.4.20-rc1 and I cannot get it to boot via LILO at all (GRUB
Works fine)(I've tried the latest version of LILO)

When booting up LILO gives the error

LILO - Descriptor Checksum Error

and then just stops.

Has anyone any pointers on how to fix this.. All relivant info below
Any other info can be given easily.

Thanks
Craig Whitmore

------------------------------
Boot sequence.

Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
Adaptec I2O RAID controller 0 at f880c000 size=100000 irq=24
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001
TID 009  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001
TID 518  Vendor: ESG-SHV      Device: SCA HSBP M15 Rev: 0.09
TID 524  Vendor: ADAPTEC      Device: RAID-5       Rev: 370F
scsi0 : Vendor: Adaptec  Model: 3210S            FW:370F
  Vendor: ADAPTEC   Model: RAID-5            Rev: 370F
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ESG-SHV   Model: SCA HSBP M15      Rev: 0.09
  Type:   Processor                          ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 287080448 512-byte hdwr sectors (146985 MB)
Partition check:
 sda: sda1 sda2
--------------------------
isk /dev/sda: 255 heads, 63 sectors, 17869 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1       498   4000153+  83  Linux
/dev/sda2           499     17869 139532557+  83  Linux
-------------------------
/etc/lilo.conf
lba32
boot=/dev/sda
root=/dev/sda1
image=/vmlinuz
        label=Linux
        read-only
        root=/dev/sda1
        restricted
-------------------------------
(lilo -v -v -v)

Reading boot sector from /dev/sda
Device 0x0801: BIOS drive 0x80, 255 heads, 17869 cylinders,
               63 sectors. Partition offset: 63 sectors.
Using MENU secondary loader
Calling map_insert_data
Secondary loader: 16 sectors (0x3000 dataend).

Boot image: /vmlinuz
Device 0x0801: BIOS drive 0x80, 255 heads, 17869 cylinders,
               63 sectors. Partition offset: 63 sectors.
Setup length is 5 sectors.
Mapped 2637 sectors.
Added Linux *
    <dev=0xe0,hd=16,cyl=30,sct=239>
    "ro root=801"
---------------
(hdparm)
/dev/sda:
 readonly     =  0 (off)
 geometry     = 17869/255/63, sectors = 287080448, start = 0
----------------
hdparm -Tt

/dev/sda:
 Timing buffer-cache reads:   128 MB in  0.26 seconds =492.31 MB/sec
 Timing buffered disk reads:  64 MB in  1.74 seconds = 36.78 MB/sec

