Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWA1Ww6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWA1Ww6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 17:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWA1Ww6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 17:52:58 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:24841 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750774AbWA1Ww4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 17:52:56 -0500
To: linux-kernel@vger.kernel.org
Cc: thockin@hockin.org, trond.myklebust@fys.uio.no
Subject: 2.6.15.1: persistent nasty hang in sync_page killing NFS (ne2k-pci
 / DP83815-related?), i686/PIII
From: Nix <nix@esperi.org.uk>
X-Emacs: the definitive fritterware.
Date: Sat, 28 Jan 2006 22:52:21 +0000
Message-ID: <87fyn8artm.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc:ed to NFS and DP83815 maintainers: any ideas?]

So I just had a catastrophic static-induced hardware failure on one of
my systems and was forced to engage in a brain transplant, ripping out
the SCSI controller and disks and moving them over to a new machine. In
the process the .config underwent this diff (lots more info below,
scroll down!)

102c102
< CONFIG_M586MMX=y
---
> # CONFIG_M586MMX is not set
105c105
< # CONFIG_MPENTIUMIII is not set
---
> CONFIG_MPENTIUMIII=y
125,126d124
< CONFIG_X86_PPRO_FENCE=y
< CONFIG_X86_F00F_BUG=y
132d129
< CONFIG_X86_ALIGNMENT_16=y
134a132
> CONFIG_X86_USE_PPRO_CHECKSUM=y
147c145
< # CONFIG_MICROCODE is not set
---
> CONFIG_MICROCODE=m
171c169
< # CONFIG_MTRR is not set
---
> CONFIG_MTRR=y
333,339c331
< CONFIG_PARPORT=m
< CONFIG_PARPORT_PC=m
< # CONFIG_PARPORT_SERIAL is not set
< CONFIG_PARPORT_PC_FIFO=y
< # CONFIG_PARPORT_PC_SUPERIO is not set
< # CONFIG_PARPORT_GSC is not set
< # CONFIG_PARPORT_1284 is not set
---
> # CONFIG_PARPORT is not set
344,351c336
< CONFIG_PNP=y
< # CONFIG_PNP_DEBUG is not set
<
< #
< # Protocols
< #
< CONFIG_ISAPNP=y
< # CONFIG_PNPBIOS is not set
---
> # CONFIG_PNP is not set
356c341
< CONFIG_BLK_DEV_FD=y
---
> # CONFIG_BLK_DEV_FD is not set
358d342
< # CONFIG_PARIDE is not set
386,387c370,371
< CONFIG_IDEDISK_MULTI_MODE=y
< # CONFIG_BLK_DEV_IDECD is not set
---
> # CONFIG_IDEDISK_MULTI_MODE is not set
> CONFIG_BLK_DEV_IDECD=y
398d381
< # CONFIG_BLK_DEV_IDEPNP is not set
400c383
< CONFIG_IDEPCI_SHARE_IRQ=y
---
> # CONFIG_IDEPCI_SHARE_IRQ is not set
402c385
< # CONFIG_BLK_DEV_GENERIC is not set
---
> CONFIG_BLK_DEV_GENERIC=y
432c415
< # CONFIG_BLK_DEV_VIA82CXXX is not set
---
> CONFIG_BLK_DEV_VIA82CXXX=y
453,454c436
< CONFIG_BLK_DEV_SR=y
< # CONFIG_BLK_DEV_SR_VENDOR is not set
---
> # CONFIG_BLK_DEV_SR is not set
504,505d485
< # CONFIG_SCSI_PPA is not set
< # CONFIG_SCSI_IMM is not set
544c524,532
< # CONFIG_BLK_DEV_MD is not set
---
> CONFIG_BLK_DEV_MD=y
> # CONFIG_MD_LINEAR is not set
> # CONFIG_MD_RAID0 is not set
> # CONFIG_MD_RAID1 is not set
> # CONFIG_MD_RAID10 is not set
> CONFIG_MD_RAID5=y
> # CONFIG_MD_RAID6 is not set
> # CONFIG_MD_MULTIPATH is not set
> # CONFIG_MD_FAULTY is not set
578d565
< # CONFIG_NET_SB1000 is not set
598,606c585
< CONFIG_NET_VENDOR_3COM=y
< # CONFIG_EL1 is not set
< # CONFIG_EL2 is not set
< # CONFIG_ELPLUS is not set
< # CONFIG_EL16 is not set
< # CONFIG_EL3 is not set
< # CONFIG_3C515 is not set
< CONFIG_VORTEX=y
< # CONFIG_TYPHOON is not set
---
> # CONFIG_NET_VENDOR_3COM is not set
629c608
< CONFIG_EEPRO100=y
---
> # CONFIG_EEPRO100 is not set
633c612
< # CONFIG_NE2K_PCI is not set
---
> CONFIG_NE2K_PCI=y
641d619
< # CONFIG_NET_POCKET is not set
683d660
< CONFIG_PLIP=m
746d722
< # CONFIG_SERIO_PARKBD is not set
776,778d751
< # CONFIG_PRINTER is not set
< # CONFIG_PPDEV is not set
< # CONFIG_TIPAR is not set
801c774,784
< # CONFIG_AGP is not set
---
> CONFIG_AGP=y
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> CONFIG_AGP_VIA=y
> # CONFIG_AGP_EFFICEON is not set
840d822
< # CONFIG_I2C_PARPORT is not set
880c862
< CONFIG_HWMON_VID=y
---
> # CONFIG_HWMON_VID is not set
897c879
< CONFIG_SENSORS_LM78=y
---
> # CONFIG_SENSORS_LM78 is not set
909c891
< # CONFIG_SENSORS_VIA686A is not set
---
> CONFIG_SENSORS_VIA686A=y
958a941,942
> CONFIG_SND_AC97_CODEC=m
> CONFIG_SND_AC97_BUS=m
989d972
< # CONFIG_SND_AD1816A is not set
994d976
< # CONFIG_SND_ES968 is not set
1000,1001d981
< # CONFIG_SND_INTERWAVE is not set
< # CONFIG_SND_INTERWAVE_STB is not set
1007,1008c987
< CONFIG_SND_SBAWE=m
< CONFIG_SND_SB16_CSP=y
---
> # CONFIG_SND_SBAWE is not set
1010,1011d988
< # CONFIG_SND_ALS100 is not set
< # CONFIG_SND_AZT2320 is not set
1013d989
< # CONFIG_SND_DT019X is not set
1052c1028,1029
< # CONFIG_SND_FM801 is not set
---
> CONFIG_SND_FM801=m
> # CONFIG_SND_FM801_TEA575X is not set
1177d1153
< # CONFIG_USB_USS720 is not set


(aside: although md is configured in the new .config, I'm not using it
for anything yet.)

Notably, the network card changed from a 3c905 to a NatSemi DP83815.


Pretty much everything works on the resulting system, except that
queries to remote NFS servers freeze solid after a very small
amount of work, always in the same place:

0 D compiler  1137   999  0  76   0 *   875 sync_p 22:19 pts/1    00:00:00 cp ../../configs/config.loki .config
0 D root      1426  1314  0  76   0 *   867 sync_p 22:28 pts/3    00:00:00 cat /usr/archive/music/.hades/archos/Liszt/Nocturne/1-Nocturne.mp3

A bit of ps fiddling makes it clearer:

loki:/mnt/tmp/i686-loki/drivers/net# ps -eo wchan=WCHANLONGLONGLONG | grep sync_p
sync_page
sync_page

so it's definitely stalled in sync_page.

tcpdumps and the kernel's packet counters on both sides show NFS packets
flowing, and being retried, over and over again:

a server, on 192.168.14.14:

22:29:07.343094 IP (tos 0x0, ttl  64, id 296, offset 0, flags [DF], proto: UDP (17), length: 144) 192.168.14.16.2009716336 > 192.168.14.14.nfs: 116 read [|nfs]
22:29:07.343539 IP (tos 0x0, ttl  64, id 33017, offset 0, flags [+], proto: UDP (17), length: 1452) 192.168.14.14.nfs > 192.168.14.16.2009716336: reply ok 1424 read [|nfs]
22:29:07.343558 IP (tos 0x0, ttl  64, id 33017, offset 1432, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.343566 IP (tos 0x0, ttl  64, id 33017, offset 2864, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.343573 IP (tos 0x0, ttl  64, id 33017, offset 4296, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.343581 IP (tos 0x0, ttl  64, id 33017, offset 5728, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.343588 IP (tos 0x0, ttl  64, id 33017, offset 7160, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.343596 IP (tos 0x0, ttl  64, id 33017, offset 8592, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.343603 IP (tos 0x0, ttl  64, id 33017, offset 10024, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.343615 IP (tos 0x0, ttl  64, id 33017, offset 11456, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.344569 IP (tos 0x0, ttl  64, id 33017, offset 12888, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.344574 IP (tos 0x0, ttl  64, id 33017, offset 14320, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.344579 IP (tos 0x0, ttl  64, id 33017, offset 15752, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.344589 IP (tos 0x0, ttl  64, id 33017, offset 17184, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.344593 IP (tos 0x0, ttl  64, id 33017, offset 18616, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.344598 IP (tos 0x0, ttl  64, id 33017, offset 20048, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.344603 IP (tos 0x0, ttl  64, id 33017, offset 21480, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.344608 IP (tos 0x0, ttl  64, id 33017, offset 22912, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.344613 IP (tos 0x0, ttl  64, id 33017, offset 24344, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.345656 IP (tos 0x0, ttl  64, id 33017, offset 25776, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.345665 IP (tos 0x0, ttl  64, id 33017, offset 27208, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.345670 IP (tos 0x0, ttl  64, id 33017, offset 28640, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.345675 IP (tos 0x0, ttl  64, id 33017, offset 30072, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:07.345680 IP (tos 0x0, ttl  64, id 33017, offset 31504, flags [none], proto: UDP (17), length: 876) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.742889 IP (tos 0x0, ttl  64, id 297, offset 0, flags [DF], proto: UDP (17), length: 144) 192.168.14.16.2009716336 > 192.168.14.14.nfs: 116 read [|nfs]
22:29:08.743208 IP (tos 0x0, ttl  64, id 33018, offset 0, flags [+], proto: UDP (17), length: 1452) 192.168.14.14.nfs > 192.168.14.16.2009716336: reply ok 1424 read [|nfs]
22:29:08.743221 IP (tos 0x0, ttl  64, id 33018, offset 1432, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.743228 IP (tos 0x0, ttl  64, id 33018, offset 2864, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.743235 IP (tos 0x0, ttl  64, id 33018, offset 4296, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.743242 IP (tos 0x0, ttl  64, id 33018, offset 5728, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.743249 IP (tos 0x0, ttl  64, id 33018, offset 7160, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.743256 IP (tos 0x0, ttl  64, id 33018, offset 8592, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.743263 IP (tos 0x0, ttl  64, id 33018, offset 10024, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.743274 IP (tos 0x0, ttl  64, id 33018, offset 11456, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.744226 IP (tos 0x0, ttl  64, id 33018, offset 12888, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.744235 IP (tos 0x0, ttl  64, id 33018, offset 14320, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.744240 IP (tos 0x0, ttl  64, id 33018, offset 15752, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.744245 IP (tos 0x0, ttl  64, id 33018, offset 17184, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.744250 IP (tos 0x0, ttl  64, id 33018, offset 18616, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.744254 IP (tos 0x0, ttl  64, id 33018, offset 20048, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.744259 IP (tos 0x0, ttl  64, id 33018, offset 21480, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.744264 IP (tos 0x0, ttl  64, id 33018, offset 22912, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.744269 IP (tos 0x0, ttl  64, id 33018, offset 24344, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.745293 IP (tos 0x0, ttl  64, id 33018, offset 25776, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.745302 IP (tos 0x0, ttl  64, id 33018, offset 27208, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.745307 IP (tos 0x0, ttl  64, id 33018, offset 28640, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.745312 IP (tos 0x0, ttl  64, id 33018, offset 30072, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:29:08.745317 IP (tos 0x0, ttl  64, id 33018, offset 31504, flags [none], proto: UDP (17), length: 876) 192.168.14.14 > 192.168.14.16: ip-proto-17

the locking client, on 192.168.14.16, here being bugged by *several* NFS
servers without result:

22:31:05.739123 IP (tos 0x0, ttl  64, id 318, offset 0, flags [DF], proto: UDP (17), length: 144) 192.168.14.16.2009716336 > 192.168.14.14.nfs: 116 read [|nfs]
22:31:05.741252 IP (tos 0x0, ttl  64, id 33039, offset 0, flags [+], proto: UDP (17), length: 1452) 192.168.14.14.nfs > 192.168.14.16.2009716336: reply ok 1424 read [|nfs]
22:31:05.742434 IP (tos 0x0, ttl  64, id 33039, offset 1432, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.743626 IP (tos 0x0, ttl  64, id 33039, offset 2864, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.744818 IP (tos 0x0, ttl  64, id 33039, offset 4296, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.746016 IP (tos 0x0, ttl  64, id 33039, offset 5728, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.747202 IP (tos 0x0, ttl  64, id 33039, offset 7160, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.748394 IP (tos 0x0, ttl  64, id 33039, offset 8592, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.749587 IP (tos 0x0, ttl  64, id 33039, offset 10024, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.750869 IP (tos 0x0, ttl  64, id 33039, offset 11456, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.752022 IP (tos 0x0, ttl  64, id 33039, offset 12888, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.753163 IP (tos 0x0, ttl  64, id 33039, offset 14320, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.754349 IP (tos 0x0, ttl  64, id 33039, offset 15752, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.755599 IP (tos 0x0, ttl  64, id 33039, offset 17184, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.756786 IP (tos 0x0, ttl  64, id 33039, offset 18616, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.757980 IP (tos 0x0, ttl  64, id 33039, offset 20048, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.759142 IP (tos 0x0, ttl  64, id 33039, offset 21480, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.760311 IP (tos 0x0, ttl  64, id 33039, offset 22912, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.761496 IP (tos 0x0, ttl  64, id 33039, offset 24344, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.762688 IP (tos 0x0, ttl  64, id 33039, offset 25776, flags [+], proto: UDP (17), length: 1452) 192.168.14.14 > 192.168.14.16: ip-proto-17
22:31:05.919036 IP (tos 0x0, ttl  64, id 197, offset 0, flags [DF], proto: UDP (17), length: 176) 192.168.14.16.2141008286 > 192.168.14.18.nfs: 148 read [|nfs]
22:31:05.921364 IP (tos 0x0, ttl  64, id 1890, offset 0, flags [+], proto: UDP (17), length: 1452) 192.168.14.18.nfs > 192.168.14.16.2141008286: reply ok 1424 read [|nfs]
22:31:05.922558 IP (tos 0x0, ttl  64, id 1890, offset 1432, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.923770 IP (tos 0x0, ttl  64, id 1890, offset 2864, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.925195 IP (tos 0x0, ttl  64, id 1890, offset 4296, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.926408 IP (tos 0x0, ttl  64, id 1890, offset 5728, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.927670 IP (tos 0x0, ttl  64, id 1890, offset 7160, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.928920 IP (tos 0x0, ttl  64, id 1890, offset 8592, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.930137 IP (tos 0x0, ttl  64, id 1890, offset 10024, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.931324 IP (tos 0x0, ttl  64, id 1890, offset 11456, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.932514 IP (tos 0x0, ttl  64, id 1890, offset 12888, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.933705 IP (tos 0x0, ttl  64, id 1890, offset 14320, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.934897 IP (tos 0x0, ttl  64, id 1890, offset 15752, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.936153 IP (tos 0x0, ttl  64, id 1890, offset 17184, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.937345 IP (tos 0x0, ttl  64, id 1890, offset 18616, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.938536 IP (tos 0x0, ttl  64, id 1890, offset 20048, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.939722 IP (tos 0x0, ttl  64, id 1890, offset 21480, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.940986 IP (tos 0x0, ttl  64, id 1890, offset 22912, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17
22:31:05.942177 IP (tos 0x0, ttl  64, id 1890, offset 24344, flags [+], proto: UDP (17), length: 1452) 192.168.14.18 > 192.168.14.16: ip-proto-17

The obvious conclusion is that the network packets are getting there
fine, but that something is eating them. Network packets for other
protocols appear to have no difficulty (although I do very little with
UDP, that machine is also the local net's nameserver and I think I'd
notice if name service had come to the same grinding halt). So I tink
the hardware is blameless here.

While this is happening some sort of global lock seems to be taken out,
because even normally-successful NFS client accesses from that client
freeze as well (e.g. an ls of a very small directory).

NFS communication from a UML embedded within the errant client,
communicating with the wider network via a bridge on the errant client,
suffers the same failures. So this is almost certainly a peculiar
network-layer failure. (That UML has not been rebuilt and is therefore
identical to the copy which had working NFS before the brain
transplant. It's also the machine from which mail delivery takes place,
*over NFS*, so I hope I'll be able to read any responses to this.)

No other configuration changes have happened since the upgrade; just the
kernel rebuild (oh, and a couple of disks got added but they have
nothing whatsosever on them yet).


Has anyone seen this before? Is it Celeron-related, DP83815-related, or
what? Whatever it is it's unlikely to be compiler-related, because
I've seen it on a kernel compiled with GCC 3.3.6 (from a Knoppix CD)
and a kernel compiled with the same .config with GCC 3.4.5. I even
saw it on that Knoppix kernel, which was 2.6.11! This bug has remained
unfixed for ages, whatever it is.

I'd suspect some sort of peculiar NFS/DP83815 interaction (a lock
problem somewhere in sync_page? I wasn't aware sync_page took out
any locks directly, though maybe I'm missing something...)

If there's anything at all I can do to help diagnose it, up to and
including handing out logins on the failing machines, you have but to
ask.


Here's the complete .config on the failing client:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15.1-skas3-v9-pre7
# Sat Jan 28 15:25:34 2006
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
CONFIG_SYSCTL_URANDOM=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=m
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=m
# CONFIG_DEFAULT_AS is not set
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_PROC_MM=y
# CONFIG_PROC_MM_DUMPABLE is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_BRIDGE=y
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID5=y
# CONFIG_MD_RAID6 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
CONFIG_NATSEMI=y
CONFIG_NE2K_PCI=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_FRANDOM=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_GENERIC_DRIVER=y

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
CONFIG_SND_FM801=m
# CONFIG_SND_FM801_TEA575X is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_STORAGE_ISD200=y
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=m

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_AES_586 is not set
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y


-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
