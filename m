Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965355AbWKDNDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965355AbWKDNDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 08:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWKDNDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 08:03:06 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:61406 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932573AbWKDNDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 08:03:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DY5RFQkU6d9Y2Ac79l+476hUhExBXQZx3hI43knsRx+PxP6TGlIx0gokTAfjkFIgK6yJ/dCiqUR9AaQQFJ7Wjd27lekNdy3Iw3MEBBN6OWnv4HfwXGy6dNCAa1o+yPXaWUdgtlp9Uu4s/EflGxM67FChwJk/llite9wDYEIcC6k=
Message-ID: <233976e40611040503m2a4bf449k78f84b0768d1f14e@mail.gmail.com>
Date: Sat, 4 Nov 2006 14:03:02 +0100
From: "Jean-Baptiste BUTET" <ashashiwa@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Promise PDC20375 (SATA150 TX2plus) doesn't work with last kernels.
Cc: ashashiwa@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, and sorry if I made mistakes here, it's my first post... and I
really think about it before posting :) I'm scared ;)

-> I have a fresh Mandriva 2007 install (2.6.17) and have installed a
2.6.18.1 vanilla in order to test with a no-heavily patched kernel.

My pb : I have a
00:09.0 Mass storage controller: Promise Technology, Inc. PDC20375
(SATA150 TX2plus) (rev 02) that worked (under kubuntu) and here
doesn't work with new install.

I've a 160 Gb IDE disk on it. (My mother card don't accept such huge
disk without this card)

Here some infos.
-------------------
uname -rpm
2.6.18.1 i686 Pentium III (Katmai)

------------------
dmesg | grep ata
libata version 2.00 loaded.
sata_promise 0000:00:09.0: version 1.04
ata1: SATA max UDMA/133 cmd 0xD8876200 ctl 0xD8876238 bmdma 0x0 irq 9
ata2: SATA max UDMA/133 cmd 0xD8876280 ctl 0xD88762B8 bmdma 0x0 irq 9
scsi0 : sata_promise
ata1: SATA link down (SStatus 0 SControl 0)
scsi1 : sata_promise
ata2: SATA link down (SStatus 0 SControl 300)

-------------------
cat /usr/src/linux-2.6.18.1/.config | grep -i sata
CONFIG_BLK_DEV_IDE_SATA=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_AHCI=m
CONFIG_SCSI_SATA_SVW=m
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
CONFIG_SCSI_SATA_QSTOR=m
CONFIG_SCSI_SATA_PROMISE=m
# CONFIG_SCSI_SATA_SX4 is not set
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIL24=m
CONFIG_SCSI_SATA_SIS=m
CONFIG_SCSI_SATA_ULI=m
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_SATA_VITESSE=m

---------------------------
cat /usr/src/linux-2.6.18.1/.config | grep -i _ide
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
CONFIG_CD_NO_IDESCSI=y

NB : CONFIG_BLK_DEV_IDE_SATA  was set to "n" before and it doesn't work too.


----------------------
lspci -vvn
00:09.0 0180: 105a:3375 (rev 02)
        Subsystem: 105a:3375
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 576 bytes
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d000 [size=64]
        Region 1: I/O ports at b800 [size=16]
        Region 2: I/O ports at b400 [size=128]
        Region 3: Memory at d5800000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at d5000000 (32-bit, non-prefetchable) [size=128K]
        [virtual] Expansion ROM at 20010000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

---------------------[root@localhost jb]# cat /proc/interrupts
           CPU0
  0:    3893028          XT-PIC  timer
  1:       1847          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     359187          XT-PIC  wifi0
  7:          1          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:          1          XT-PIC  acpi, uhci_hcd:usb1, libata
 11:    1324243          XT-PIC  nvidia
 12:      75820          XT-PIC  i8042
 14:      18763          XT-PIC  ide0
 15:     150567          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0
----------------------
root@localhost jb]# cat /proc/iomem
00000000-0009e7ff : System RAM
  00000000-00000000 : Crash kernel
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cb3ff : Video ROM
000cc000-000cf3ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-17ffcfff : System RAM
  00100000-003443a2 : Kernel code
  003443a3-003fd7d3 : Kernel data
17ffd000-17ffefff : ACPI Tables
17fff000-17ffffff : ACPI Non-volatile Storage
20000000-2000ffff : 0000:00:0b.0
20010000-20013fff : 0000:00:09.0
d4000000-d40000ff : 0000:00:0b.0
  d4000000-d40000ff : 8139too
d4800000-d480ffff : 0000:00:0a.0
  d4800000-d480ffff : ath
d5000000-d501ffff : 0000:00:09.0
  d5000000-d501ffff : sata_promise
d5800000-d5800fff : 0000:00:09.0
  d5800000-d5800fff : sata_promise
d6000000-d7dfffff : PCI Bus #01
  d6000000-d6ffffff : 0000:01:00.0
    d6000000-d6ffffff : nvidia
d7f00000-e3ffffff : PCI Bus #01
  d7ff0000-d7ffffff : 0000:01:00.0
  d8000000-dfffffff : 0000:01:00.0
    d8000000-d9ffffff : vesafb
e4000000-e7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved
--------------

[root@localhost jb]# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : pnp 00:03
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
b000-b0ff : 0000:00:0b.0
  b000-b0ff : 8139too
b400-b47f : 0000:00:09.0
  b400-b47f : sata_promise
b800-b80f : 0000:00:09.0
  b800-b80f : sata_promise
d000-d03f : 0000:00:09.0
  d000-d03f : sata_promise
d400-d41f : 0000:00:04.2
  d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
  d800-d807 : ide0
  d808-d80f : ide1
e400-e47f : motherboard
  e400-e403 : ACPI PM1a_EVT_BLK
  e404-e405 : ACPI PM1a_CNT_BLK
  e408-e40b : ACPI PM_TMR
  e410-e415 : ACPI CPU throttle
  e420-e423 : ACPI GPE0_BLK
e800-e80f : motherboard
  e800-e80f : pnp 00:03
-----------
Is there any tests I can do to circle pb ?, other option in config ?

Really good job for all you've made all you're doing.

Clear skies,

Jean-Baptiste BUTET, GNU/linux users since Y2K.

NB : please CC me.
