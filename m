Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312746AbSCVQRK>; Fri, 22 Mar 2002 11:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312747AbSCVQRB>; Fri, 22 Mar 2002 11:17:01 -0500
Received: from gherkin.frus.com ([192.158.254.49]:384 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S312746AbSCVQQu>;
	Fri, 22 Mar 2002 11:16:50 -0500
Message-Id: <m16oRii-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.7: ATAPI CD underruns
To: linux-kernel@vger.kernel.org
Date: Fri, 22 Mar 2002 10:16:48 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emboldened by the quick squashing of the kernel/acct.c bug (thanks!), I
thought I'd add another data point to the reports of IDE trouble in the
latest 2.5.X kernels.

The system is a Toshiba Tecra 730XCDT with a 10X cdrom drive.  I get
read errors and a stream of syslog messages like the following whenever
I'm running 2.5.7 and attempt to read a file on a mounted cdrom:

hdc: cdrom_read_intr: data underrun (4294967284 blocks)
end_request: I/O error, dev 16:00, sector 173572
hdc: cdrom_read_intr: data underrun (4294967288 blocks)
end_request: I/O error, dev 16:00, sector 173576
hdc: cdrom_read_intr: data underrun (4294967292 blocks)
end_request: I/O error, dev 16:00, sector 173580

I'm mounting the CD with default options, e.g.,
	mount -t iso9660 /dev/cdrom /mnt -r

The particular CD I was accessing at the time is a Slackware 8.0 ISO
image, but I get the errors with other CDs.  The 2.4.18 kernel doesn't
have this problem.

More detailed hardware info is available if it would be helpful.
Here are the IDE kernel options I'm using...

/*
 * ATA/IDE/MFM/RLL support
 */
#define CONFIG_IDE 1

/*
 * ATA and ATAPI Block devices
 */
#define CONFIG_BLK_DEV_IDE 1

/*
 * Please see Documentation/ide.txt for help/info on IDE drives
 */
#undef  CONFIG_BLK_DEV_HD_IDE
#undef  CONFIG_BLK_DEV_HD
#define CONFIG_BLK_DEV_IDEDISK 1
#undef  CONFIG_IDEDISK_MULTI_MODE
#undef  CONFIG_IDEDISK_STROKE
#undef  CONFIG_BLK_DEV_IDEDISK_VENDOR
#undef  CONFIG_BLK_DEV_IDEDISK_FUJITSU
#undef  CONFIG_BLK_DEV_IDEDISK_IBM
#undef  CONFIG_BLK_DEV_IDEDISK_MAXTOR
#undef  CONFIG_BLK_DEV_IDEDISK_QUANTUM
#undef  CONFIG_BLK_DEV_IDEDISK_SEAGATE
#undef  CONFIG_BLK_DEV_IDEDISK_WD
#undef  CONFIG_BLK_DEV_COMMERIAL
#undef  CONFIG_BLK_DEV_TIVO
#undef  CONFIG_BLK_DEV_IDECS
#define CONFIG_BLK_DEV_IDECD 1
#undef  CONFIG_BLK_DEV_IDETAPE
#undef  CONFIG_BLK_DEV_IDEFLOPPY
#undef  CONFIG_BLK_DEV_IDESCSI
#define CONFIG_BLK_DEV_IDESCSI_MODULE 1

/*
 * IDE chipset support
 */
#define CONFIG_BLK_DEV_CMD640 1
#undef  CONFIG_BLK_DEV_CMD640_ENHANCED
#undef  CONFIG_BLK_DEV_ISAPNP
#define CONFIG_BLK_DEV_RZ1000 1
#define CONFIG_BLK_DEV_IDEPCI 1
#undef  CONFIG_BLK_DEV_OFFBOARD
#undef  CONFIG_IDEPCI_SHARE_IRQ
#define CONFIG_BLK_DEV_IDEDMA_PCI 1
#define CONFIG_IDEDMA_PCI_AUTO 1
#undef  CONFIG_IDEDMA_ONLYDISK
#define CONFIG_BLK_DEV_IDEDMA 1
#undef  CONFIG_IDEDMA_PCI_WIP
#undef  CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
#undef  CONFIG_BLK_DEV_AEC62XX
#undef  CONFIG_AEC62XX_TUNING
#undef  CONFIG_BLK_DEV_ALI15X3
#undef  CONFIG_WDC_ALI15X3
#undef  CONFIG_BLK_DEV_AMD74XX
#undef  CONFIG_BLK_DEV_CMD64X
#undef  CONFIG_BLK_DEV_CY82C693
#undef  CONFIG_BLK_DEV_CS5530
#undef  CONFIG_BLK_DEV_HPT34X
#undef  CONFIG_HPT34X_AUTODMA
#undef  CONFIG_BLK_DEV_HPT366
#undef  CONFIG_BLK_DEV_PIIX
#undef  CONFIG_BLK_DEV_NS87415
#undef  CONFIG_BLK_DEV_OPTI621
#undef  CONFIG_BLK_DEV_PDC_ADMA
#undef  CONFIG_BLK_DEV_PDC202XX
#undef  CONFIG_PDC202XX_BURST
#undef  CONFIG_PDC202XX_FORCE
#undef  CONFIG_BLK_DEV_SVWKS
#undef  CONFIG_BLK_DEV_SIS5513
#undef  CONFIG_BLK_DEV_TRM290
#undef  CONFIG_BLK_DEV_VIA82CXXX
#undef  CONFIG_IDE_CHIPSETS
#undef  CONFIG_IDEDMA_IVB
#define CONFIG_IDEDMA_AUTO 1
#undef  CONFIG_DMA_NONPCI
#undef  CONFIG_BLK_DEV_ATARAID
#undef  CONFIG_BLK_DEV_ATARAID_PDC
#undef  CONFIG_BLK_DEV_ATARAID_HPT

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
