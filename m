Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVILMGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVILMGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVILMGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:06:06 -0400
Received: from mx.laposte.net ([80.245.62.11]:20317 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1750766AbVILMGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:06:05 -0400
From: Michael Pujos <pujos.michael@laposte.net>
To: linux-kernel@vger.kernel.org
Subject: Problem with external USB2 drive
Date: Mon, 12 Sep 2005 14:05:45 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121405.45643.pujos.michael@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[Please CC me any reply as I'm not subsribed to the list]

I have the following hardware:

Sony Vaio A317
Pentium M @ 1.7Ghz
Internal SATA 80Gb HDD
An external 200Gb Seagate HDD connected through USB2

Distribution is PCLinuxOS which comes with kernel 2.6.12.5 with patches (i'm 
using the lastes, 2.6.12-oci3):

http://pclinuxfiles.com/ocilent1/kernel/2.6.X-oci-kernel-changelog

My problem is the USB HDD drive. If I let a process read/write on this drive 
constantly (like a P2P program) on a FAT32 partition, after a few hours I 
*always* have these errors in the kernel log (note that with the prior kernel 
2.6.12-oci2 based on 2.6.12.3 I had a system freeze without any log or 
recovery possible with SysRq and machine does not asnwer to ping)

Sep 12 05:22:48 vaio kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Sep 12 05:22:48 vaio kernel: sdb: Current: sense key: Hardware Error
Sep 12 05:22:48 vaio kernel:     Additional sense: Data phase error
Sep 12 05:22:48 vaio kernel: end_request: I/O error, dev sdb, sector 323277908
Sep 12 05:22:48 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047840
Sep 12 05:22:54 vaio kernel: usb 1-1: reset high speed USB device using 
ehci_hcd and address 2
Sep 12 05:22:54 vaio kernel: scsi: Device offlined - not ready after error 
recovery: host 2 channel 0 id 0 lun 0
Sep 12 05:22:54 vaio kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Sep 12 05:22:54 vaio kernel: Unrecognized sense data (in hex):
Sep 12 05:22:54 vaio kernel:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00
Sep 12 05:22:54 vaio kernel:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00
Sep 12 05:22:54 vaio kernel: end_request: I/O error, dev sdb, sector 323277909
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047841
Sep 12 05:22:54 vaio kernel: scsi2 (0:0): rejecting I/O to offline device
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047842
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047843
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047844
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047845
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047846
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047847
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047848
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047849
Sep 12 05:22:54 vaio kernel: Buffer I/O error on device sdb6, logical block 
126047850
Sep 12 05:22:54 vaio kernel: scsi2 (0:0): rejecting I/O to offline device
Sep 12 05:22:57 vaio last message repeated 37 times
Sep 12 05:22:57 vaio kernel: FAT: FAT read failed (blocknr 14512)
Sep 12 05:22:57 vaio kernel: scsi2 (0:0): rejecting I/O to offline device


That could be a hardware failure but I'm quite sure it's not the case because 
I never had this crashes using Ubuntu Hoary which use a custom kernel 2.6.10 
and Kubuntu Breezy with kernel 2.6.12. After googling I found people with 
similar problem with less recent kernels and often with big partitions.

Here's the partiton table of the drive:

Disk /dev/sdb: 200.0 GB, 200049647616 bytes
255 heads, 63 sectors/track, 24321 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1   *           1        9727    78132096    b  W95 FAT32
/dev/sdb2            9728       24321   117226305    f  W95 Ext'd (LBA)
/dev/sdb5            9728       12277    20482843+   7  HPFS/NTFS
/dev/sdb6           12278       24321    96743398+   b  W95 FAT32

modules:


Module                  Size  Used by
ipw2200                94056  0
binfmt_misc             8744  1
firmware_class          7520  1 ipw2200
ieee80211              27972  1 ipw2200
ieee80211_crypt         4424  2 ipw2200,ieee80211
af_packet              16552  0
usbkbd                  5984  0
loop                   13480  0
nls_cp850               4544  3
vfat                   10464  3
fat                    47324  1 vfat
nls_iso8859_1           3744  5
ntfs                  211128  2
ide_cd                 39236  0
sonypi                 20744  2
cpufreq_ondemand        5116  0
cpufreq_userspace       3324  1
cpufreq_powersave       1376  0
speedstep_centrino      6484  1
snd_seq_dummy           2596  0
snd_seq_oss            31424  0
snd_seq_midi_event      5664  1 snd_seq_oss
snd_seq                47952  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          6892  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            48032  0
snd_mixer_oss          16896  1 snd_pcm_oss
snd_hda_intel          13440  0
snd_hda_codec          79168  1 snd_hda_intel
snd_pcm                80292  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              20772  2 snd_seq,snd_pcm
snd                    46404  9 
snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
soundcore               7008  1 snd
snd_page_alloc          8488  2 snd_hda_intel,snd_pcm
button                  4880  0
thermal                10920  0
processor              18516  2 speedstep_centrino,thermal
fan                     3172  0
ac                      3332  0
battery                 8196  0
hci_usb                12584  0
bluetooth              42244  1 hci_usb
usbmouse                4320  0
usbhid                 44032  0
intel_agp              20412  1
agpgart                29832  1 intel_agp
rtc                     9848  0
evdev                   7488  0
dm_mod                 52156  0
uhci_hcd               29648  0
BusLogic               79028  0
aic7xxx               192712  0
scsi_transport_spi     17216  1 aic7xxx
aha152x                37552  0
a100u2w                 9408  0
sata_vsc                5060  0
sata_via                5636  0
sata_svw                4996  0
sata_sil                6116  0
sata_promise            7908  0
sata_sis                4256  0
sata_nv                 6212  0
usb_storage            72768  3
ehci_hcd               28808  0
usbcore               109308  8 
usbkbd,hci_usb,usbmouse,usbhid,uhci_hcd,usb_storage,ehci_hcd
sg                     34108  0
sr_mod                 15300  0
cdrom                  38656  2 ide_cd,sr_mod
ext3                  128744  1
jbd                    49880  1 ext3
sd_mod                 16272  9
ata_piix                7300  4
libata                 42148  8 
sata_vsc,sata_via,sata_svw,sata_sil,sata_promise,sata_sis,sata_nv,ata_piix
scsi_mod              126792  11 
BusLogic,aic7xxx,scsi_transport_spi,aha152x,a100u2w,sata_promise,usb_storage,sg,sr_mod,sd_mod,libata

