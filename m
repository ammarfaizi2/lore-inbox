Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262665AbTDBU3b>; Wed, 2 Apr 2003 15:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262678AbTDBU3a>; Wed, 2 Apr 2003 15:29:30 -0500
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:65033 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262665AbTDBU3S>; Wed, 2 Apr 2003 15:29:18 -0500
Date: Wed, 2 Apr 2003 22:40:20 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.66] IDE cdrom does not work :(
Message-ID: <Pine.LNX.4.51L.0304022232050.2451@piorun.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I realized that I can't use my cdrom! When I try to mount it on 
2.5.66 I get:

# mount /mnt/cdrom/
mount: /dev/cdroms/cdrom0 is not a valid block device
# ls -l /dev/cdroms/cdrom0
lrwxrwxrwx    1 root     root            6 03-08 04:07 /dev/cdroms/cdrom0 -> ../hdd
# ls -l /dev/hdd
brw-rw----    1 root     disk      22,  64 1998-05-05  /dev/hdd

In previous kernels (prior 2.5.65) it was ok. cdrom and isofs modules are 
loaded.

dmesg fragment:
[...]
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:DMA
hda: ST340016A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: LG DVD-ROM DRD-8120B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
[...]

# lsmod
Module                  Size  Used by
snd_pcm_oss            54276  1
cdrom                  32672  0
snd_via82xx            21892  1
snd_mpu401_uart         7616  1 snd_via82xx
snd_emu10k1            84100  2
snd_rawmidi            23808  2 snd_mpu401_uart,snd_emu10k1
snd_pcm                93824  3 snd_pcm_oss,snd_via82xx,snd_emu10k1
snd_timer              24128  1 snd_pcm
snd_seq_device          8324  2 snd_emu10k1,snd_rawmidi
snd_ac97_codec         43716  2 snd_via82xx,snd_emu10k1
snd_page_alloc         10820  3 snd_via82xx,snd_emu10k1,snd_pcm
snd_util_mem            4864  1 snd_emu10k1
snd_hwdep               9088  1 snd_emu10k1
nls_iso8859_2           4992  2
smbfs                  64496  2 [unsafe]
parport_pc             42696  1
lp                     10944  0
parport                42432  2 parport_pc,lp
binfmt_misc            11908  1
md5                     4480  1
ipv6                  213284  6 [unsafe]
sd_mod                 16352  0
scsi_mod               84892  1 sd_mod
3c59x                  39528  1
isofs                  36476  0
zlib_inflate           22912  1 isofs
psmouse                 7812  0
uhci_hcd               30792  0
usbcore               106164  3 uhci_hcd
genrtc                  9816  0 [unsafe]


My kernel config: http://piorun.ds.pg.gda.pl/~blues/config-2.5.66.txt
If some more info is needed

-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
