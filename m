Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTJPBSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 21:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbTJPBSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 21:18:21 -0400
Received: from 82-68-107-172.dsl.in-addr.zen.co.uk ([82.68.107.172]:23424 "EHLO
	brain.pulsesol.com") by vger.kernel.org with ESMTP id S262556AbTJPBSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 21:18:12 -0400
Date: Thu, 16 Oct 2003 02:18:08 +0100
From: Antony Gelberg <antony@antgel.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Promise RAID in 2.4.22
Message-ID: <20031016011808.GA1443@brain.pulsesol.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Originally asked this on debian-user, no responses...

I have a Promise 20376 SATA RAID on my Asus A7V8X mobo.  My root
partition is mounted on it.  The driver is provided by Promise.  During
the Debian install, I was able to put the ft3xx.o module (built on
another machine) onto a floppy, and the installation script created
an initrd, which boots, loads the driver, mounts /, and carries on.
(So much for Debian's install being
crap!)

This has been great for months, and I've built several versions of
2.4.18 since, which load fine using that initrd.  However, I'm now
trying to uplevel to 2.4.22, for a 802.11b driver that I'd like to use.
Only problem is, on bootup, I get:
<Promise driver "about" line>
scsi1: ft3xx
scsi1: device driver called scsi_done() for a synchronous reset.

Then a hang.  This is _exactly_ at the point when the RAID root partition
should take over.

I must admit to not being an initrd expert.  Do I need to recompile the
ft3xx module against the 2.4.22 headers, even though I'm booting from
the same initrd as before?  And if I do, how do I create a new initrd
with that module in it?  I've read TFM on initrd, but just can't get it
to work, even for such a simple task (load a module, hand root to RAID
partition).

I build kernels The Debian Way (i.e. make-kpkg --initrd), but the initrd
that is created from that is useless - i.e. doesn't take into account
that I need to load ft3xx.o.  So usually I point lilo to
/boot/initrd.debinstall, which worked for my 2.4.18 kernels.

So, either:
1. My 2.4.18 initrd with ft3xx module that's causing the problem?  OR
2. There's a problem in 2.4.22.

Hope I'm making sense to somebody - kernel config diff is attached.

A

PS A CC would be much appreciated.

-- 
Now playing: Dream Theater - Learning To Live

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config_diff

5d4
< CONFIG_ISA=y
33a33
> # CONFIG_MK8 is not set
39a40
> # CONFIG_MVIAC3_2 is not set
49c50
< CONFIG_X86_TSC=y
---
> CONFIG_X86_HAS_TSC=y
53a55,56
> CONFIG_X86_F00F_WORKS_OK=y
> CONFIG_X86_MCE=y
61a65
> # CONFIG_HIGHMEM is not set
63a68
> # CONFIG_BIGPHYS_AREA is not set
68a74,75
> # CONFIG_X86_TSC_DISABLE is not set
> CONFIG_X86_TSC=y
79a87
> CONFIG_ISA=y
95a104,105
> # CONFIG_HOTPLUG_PCI_IBM is not set
> # CONFIG_HOTPLUG_PCI_ACPI is not set
132a143
> # CONFIG_ACPI_ASUS is not set
134a146
> # CONFIG_ACPI_RELAXED_AML is not set
171a184
> # CONFIG_CISS_SCSI_TAPE is not set
172a186
> # CONFIG_BLK_DEV_UMEM is not set
177a192
> # CONFIG_BLK_STATS is not set
199a215
> # CONFIG_NET_KEY is not set
210d225
< CONFIG_INET_ECN_DISABLED=y
211a227,229
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
212a231,232
> CONFIG_XFRM=y
> # CONFIG_XFRM_USER is not set
221a242,246
> 
> #
> # Appletalk devices
> #
> # CONFIG_DEV_APPLETALK is not set
237d261
< CONFIG_IPSEC=y
240c264
< # IPSec options (FreeS/WAN)
---
> # Network testing
242,262c266
< CONFIG_IPSEC_IPIP=y
< CONFIG_IPSEC_AH=y
< CONFIG_IPSEC_AUTH_HMAC_MD5=y
< CONFIG_IPSEC_AUTH_HMAC_SHA1=y
< CONFIG_IPSEC_ESP=y
< CONFIG_IPSEC_ENC_3DES=y
< CONFIG_IPSEC_EXT=y
< # CONFIG_IPSEC_EXT_MD5 is not set
< # CONFIG_IPSEC_EXT_RIPEMD is not set
< # CONFIG_IPSEC_EXT_SHA1 is not set
< # CONFIG_IPSEC_EXT_SHA2 is not set
< # CONFIG_IPSEC_EXT_3DES is not set
< # CONFIG_IPSEC_EXT_AES_OPT is not set
< # CONFIG_IPSEC_EXT_AES is not set
< # CONFIG_IPSEC_EXT_BLOWFISH is not set
< # CONFIG_IPSEC_EXT_CAST is not set
< # CONFIG_IPSEC_EXT_NULL is not set
< # CONFIG_IPSEC_EXT_SERPENT is not set
< # CONFIG_IPSEC_EXT_TWOFISH is not set
< CONFIG_IPSEC_IPCOMP=y
< CONFIG_IPSEC_DEBUG=y
---
> # CONFIG_NET_PKTGEN is not set
288,296c292
< # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
< # CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
< # CONFIG_BLK_DEV_IDEDISK_IBM is not set
< # CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
< # CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
< # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
< # CONFIG_BLK_DEV_IDEDISK_WD is not set
< # CONFIG_BLK_DEV_COMMERIAL is not set
< # CONFIG_BLK_DEV_TIVO is not set
---
> # CONFIG_IDEDISK_STROKE is not set
301a298
> # CONFIG_IDE_TASK_IOCTL is not set
309d305
< # CONFIG_BLK_DEV_RZ1000 is not set
310a307
> # CONFIG_BLK_DEV_GENERIC is not set
313d309
< CONFIG_BLK_DEV_ADMA=y
314a311
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
315a313
> # CONFIG_IDEDMA_ONLYDISK is not set
318c316
< # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
---
> # CONFIG_BLK_DEV_ADMA100 is not set
320d317
< # CONFIG_AEC62XX_TUNING is not set
325a323
> # CONFIG_BLK_DEV_TRIFLEX is not set
332d329
< # CONFIG_PIIX_TUNING is not set
335c332
< # CONFIG_BLK_DEV_PDC202XX is not set
---
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
337c334,336
< # CONFIG_PDC202XX_FORCE is not set
---
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
338a338
> # CONFIG_BLK_DEV_SIIMAGE is not set
350a351
> # CONFIG_BLK_DEV_ATARAID_SII is not set
366a368
> # CONFIG_CHR_DEV_SCH is not set
387a390
> # CONFIG_SCSI_AIC79XX is not set
428a432
> # CONFIG_SCSI_NSP32 is not set
448c452,455
< # CONFIG_IEEE1394_PCILYNX is not set
---
> 
> #
> #   Texas Instruments PCILynx requires I2C bit-banging
> #
455a463,465
> # CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
> # CONFIG_IEEE1394_ETH1394 is not set
> # CONFIG_IEEE1394_DV1394 is not set
456a467
> # CONFIG_IEEE1394_CMP is not set
457a469
> # CONFIG_IEEE1394_OUI_DB is not set
502a515
> # CONFIG_AMD8111_ETH is not set
505a519
> # CONFIG_B44 is not set
509d522
< # CONFIG_DGRS is not set
511a525,526
> # CONFIG_EEPRO100_PIO is not set
> # CONFIG_E100 is not set
523c538
< # CONFIG_8139_NEW_RX_RESET is not set
---
> # CONFIG_8139_OLD_RX_RESET is not set
526a542
> # CONFIG_SUNDANCE_MMIO is not set
536d551
< # CONFIG_ACENIC is not set
537a553
> # CONFIG_E1000 is not set
541a558
> # CONFIG_R8169 is not set
542a560
> CONFIG_TIGON3=m
561a580
> CONFIG_PCI_HERMES=m
622a642
> # CONFIG_TOSHIBA_OLD is not set
656d675
< # CONFIG_SERIAL_ACPI is not set
662a682
> # CONFIG_TIPAR is not set
676a697
> # CONFIG_MK712_MOUSE is not set
712a734,738
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_IPMI_PANIC_EVENT is not set
> # CONFIG_IPMI_DEVICE_INTERFACE is not set
> # CONFIG_IPMI_KCS is not set
> # CONFIG_IPMI_WATCHDOG is not set
717a744,745
> # CONFIG_SCx200_GPIO is not set
> # CONFIG_AMD_RNG is not set
718a747
> # CONFIG_AMD_PM768 is not set
734a764
> # CONFIG_AGP_AMD_8151 is not set
737a768
> # CONFIG_AGP_NVIDIA is not set
748a780,781
> # CONFIG_DRM_I810_XFREE_41 is not set
> # CONFIG_DRM_I830 is not set
761a795
> # CONFIG_QFMT_V2 is not set
770a805,807
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BEFS_DEBUG is not set
784c821
< # CONFIG_RAMFS is not set
---
> CONFIG_RAMFS=y
787a825,827
> # CONFIG_JFS_FS is not set
> # CONFIG_JFS_DEBUG is not set
> # CONFIG_JFS_STATISTICS is not set
814a855
> # CONFIG_NFS_DIRECTIO is not set
817a859
> # CONFIG_NFSD_TCP is not set
833d874
< CONFIG_ZLIB_FS_INFLATE=y
852a894
> # CONFIG_EFI_PARTITION is not set
912a955
> # CONFIG_FB_PM3 is not set
921a965
> # CONFIG_FB_INTEL is not set
922a967
> # CONFIG_FB_NEOMAGIC is not set
946a992
> # CONFIG_SOUND_ALI5455 is not set
957a1004
> # CONFIG_SOUND_FORTE is not set
969a1017
> # CONFIG_SOUND_AD1889 is not set
988a1037
> # CONFIG_SOUND_KAHLUA is not set
1011d1059
< # CONFIG_USB_LONG_TIMEOUT is not set
1014c1062
< # USB Controllers
---
> # USB Host Controller Drivers
1015a1064
> CONFIG_USB_EHCI_HCD=m
1023a1073
> # CONFIG_USB_EMI26 is not set
1024a1075
> # CONFIG_USB_MIDI is not set
1032a1084
> # CONFIG_USB_STORAGE_SDDR55 is not set
1040a1093
> # CONFIG_USB_HIDINPUT is not set
1043a1097
> # CONFIG_USB_AIPTEK is not set
1044a1099,1100
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
1066a1123
> # CONFIG_USB_RTL8150 is not set
1068a1126
> # CONFIG_USB_AX8817X is not set
1080a1139
> # CONFIG_USB_SERIAL_DEBUG is not set
1090a1150
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
1094a1155
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
1103a1165,1168
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_TIGL is not set
> # CONFIG_USB_BRLVGER is not set
> # CONFIG_USB_LCD is not set
1113a1179,1190
> 
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
> 
> #
> # Library routines
> #
> # CONFIG_CRC32 is not set
> CONFIG_ZLIB_INFLATE=y
> # CONFIG_ZLIB_DEFLATE is not set

--d6Gm4EdcadzBjdND--
