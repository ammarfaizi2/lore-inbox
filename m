Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUCRVxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbUCRVxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:53:13 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:48393 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S262981AbUCRVw6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:52:58 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: lkml <linux-kernel@vger.kernel.org>
Subject: software suspend and modular IDE in 2.6.4
Date: Thu, 18 Mar 2004 22:50:37 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403182250.37787.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm using kernel with modular IDE (modules are loaded from initrd). suspending 
to disk works fine (it seems) but resume won't since kernel is trying to 
resume before running initrd so I'm getting resume failed
Resume Machine: resuming from /dev/hda2
Resuming from device unknown-block(0,0)
Resume Machine: Error -6 resuming
and then initrd loading proper modules + machine starts as normal boot (see 
log below).

Would be it possible to delay resuming after loading initrd? Or some userspace 
utility that would run from initrd after loading IDE modules and forced 
resume from swap?

NET: Registered protocol family 17
Resume Machine: resuming from /dev/hda2
Resuming from device unknown-block(0,0)
Resume Machine: Error -6 resuming
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (romfs filesystem) readonly.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK3021GAS, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Samsung CD-RW/DVD-ROM SN-324B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB), CHS=58140/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda3: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 1409662
ext3_orphan_cleanup: deleting unreferenced inode 328817
EXT3-fs: hda3: 2 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.

[arekm@mobarm ~]$ lsmod
Module                  Size  Used by
binfmt_misc             8072  1
ipv6                  209728  15
ds                     11140  2
yenta_socket           13440  0
pcmcia_core            59104  2 ds,yenta_socket
via_ircc               19728  0
via_rhine              17672  0
mii                     3968  1 via_rhine
crc32                   4096  1 via_rhine
usbmouse                4352  0
uhci_hcd               27152  0
ohci_hcd               16004  0
nls_iso8859_2           4480  1
ntfs                   95468  0
ircomm_tty             21256  0
ircomm                 11652  1 ircomm_tty
irda                  115132  3 via_ircc,ircomm_tty,ircomm
snd_pcm_oss            46628  0
snd_mixer_oss          16384  1 snd_pcm_oss
snd_via82xx            21408  2
snd_pcm                80264  4 snd_pcm_oss,snd_via82xx
snd_timer              20484  1 snd_pcm
snd_ac97_codec         55940  1 snd_via82xx
snd_page_alloc          8964  2 snd_via82xx,snd_pcm
gameport                3712  1 snd_via82xx
snd_mpu401_uart         5632  1 snd_via82xx
snd_rawmidi            19488  1 snd_mpu401_uart
snd_seq_device          6792  1 snd_rawmidi
snd                    45668  11 
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7008  1 snd
tsdev                   5760  0
joydev                  8896  0
evdev                   7936  0
psmouse                16776  0
proc_intf               3200  0
powernow_k7             6304  0
freq_table              3460  1 powernow_k7
thermal                11664  0
processor              16560  1 thermal
fan                     3212  0
button                  4760  0
battery                 7948  0
ac                      3980  0
capability              3076  0
commoncap               4992  1 capability
ide_cd                 36740  0
cdrom                  35612  1 ide_cd
rtc                     9912  0
hid                    49792  0
ehci_hcd               21892  0
usbcore                86364  7 usbmouse,uhci_hcd,ohci_hcd,hid,ehci_hcd
ext3                  100520  1
mbcache                 6532  1 ext3
jbd                    48792  1 ext3
ide_disk               14720  2
via82cxxx              11164  0 [permanent]
ide_core              126944  3 ide_cd,ide_disk,via82cxxx

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
