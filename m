Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbUKGGHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbUKGGHw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 01:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbUKGGHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 01:07:51 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:37877 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261544AbUKGGFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 01:05:33 -0500
Date: Sat, 6 Nov 2004 22:04:42 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] WIN_* -> ATA_CMD_* conversion (take #2): cleanup hdreg.h
Message-ID: <20041107060442.GD25569@taniwha.stupidest.org>
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com> <20041106032305.GB6060@taniwha.stupidest.org> <418D0066.9040002@pobox.com> <418D043E.3090406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418D043E.3090406@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== include/linux/hdreg.h 1.28 vs edited =====
--- 1.28/include/linux/hdreg.h	2004-11-02 11:32:44 -08:00
+++ edited/include/linux/hdreg.h	2004-11-06 21:49:37 -08:00
@@ -21,12 +21,8 @@
 #define HD_HCYL		0x1f5		/* high byte of starting cyl */
 #define HD_CURRENT	0x1f6		/* 101dhhhh , d=drive, hhhh=head */
 #define HD_STATUS	0x1f7		/* see status-bits */
-#define HD_FEATURE	HD_ERROR	/* same io address, read=error, write=feature */
-#define HD_PRECOMP	HD_FEATURE	/* obsolete use of this port - predates IDE */
-#define HD_COMMAND	HD_STATUS	/* same io address, read=status, write=cmd */
 
 #define HD_CMD		0x3f6		/* used for resets */
-#define HD_ALTSTATUS	0x3f6		/* same as HD_STATUS but doesn't clear irq */
 
 /* remainder is shared between hd.c, ide.c, ide-cd.c, and the hdparm utility */
 
@@ -180,154 +176,20 @@
 #define TASKFILE_P_IN_DMAQ		0x2000
 #define TASKFILE_P_OUT_DMAQ		0x4000
 
-/* ATA/ATAPI Commands pre T13 Spec */
-#define WIN_NOP				0x00
-/*
- *	0x01->0x02 Reserved
- */
-#define CFA_REQ_EXT_ERROR_CODE		0x03 /* CFA Request Extended Error Code */
-/*
- *	0x04->0x07 Reserved
- */
-#define WIN_SRST			0x08 /* ATAPI soft reset command */
-#define WIN_DEVICE_RESET		0x08
-/*
- *	0x09->0x0F Reserved
- */
-#define WIN_RECAL			0x10
-#define WIN_RESTORE			WIN_RECAL
-/*
- *	0x10->0x1F Reserved
- */
-#define WIN_READ			0x20 /* 28-Bit */
-#define WIN_READ_ONCE			0x21 /* 28-Bit without retries */
-#define WIN_READ_LONG			0x22 /* 28-Bit */
-#define WIN_READ_LONG_ONCE		0x23 /* 28-Bit without retries */
-#define WIN_READ_EXT			0x24 /* 48-Bit */
-#define WIN_READDMA_EXT			0x25 /* 48-Bit */
-#define WIN_READDMA_QUEUED_EXT		0x26 /* 48-Bit */
-#define WIN_READ_NATIVE_MAX_EXT		0x27 /* 48-Bit */
-/*
- *	0x28
- */
-#define WIN_MULTREAD_EXT		0x29 /* 48-Bit */
-/*
- *	0x2A->0x2F Reserved
- */
-#define WIN_WRITE			0x30 /* 28-Bit */
-#define WIN_WRITE_ONCE			0x31 /* 28-Bit without retries */
-#define WIN_WRITE_LONG			0x32 /* 28-Bit */
-#define WIN_WRITE_LONG_ONCE		0x33 /* 28-Bit without retries */
-#define WIN_WRITE_EXT			0x34 /* 48-Bit */
-#define WIN_WRITEDMA_EXT		0x35 /* 48-Bit */
-#define WIN_WRITEDMA_QUEUED_EXT		0x36 /* 48-Bit */
-#define WIN_SET_MAX_EXT			0x37 /* 48-Bit */
-#define CFA_WRITE_SECT_WO_ERASE		0x38 /* CFA Write Sectors without erase */
-#define WIN_MULTWRITE_EXT		0x39 /* 48-Bit */
-/*
- *	0x3A->0x3B Reserved
- */
-#define WIN_WRITE_VERIFY		0x3C /* 28-Bit */
-/*
- *	0x3D->0x3F Reserved
- */
-#define WIN_VERIFY			0x40 /* 28-Bit - Read Verify Sectors */
-#define WIN_VERIFY_ONCE			0x41 /* 28-Bit - without retries */
-#define WIN_VERIFY_EXT			0x42 /* 48-Bit */
-/*
- *	0x43->0x4F Reserved
- */
-#define WIN_FORMAT			0x50
-/*
- *	0x51->0x5F Reserved
- */
-#define WIN_INIT			0x60
-/*
- *	0x61->0x5F Reserved
- */
-#define WIN_SEEK			0x70 /* 0x70-0x7F Reserved */
-
-#define CFA_TRANSLATE_SECTOR		0x87 /* CFA Translate Sector */
-#define WIN_DIAGNOSE			0x90
-#define WIN_SPECIFY			0x91 /* set drive geometry translation */
-#define WIN_DOWNLOAD_MICROCODE		0x92
-#define WIN_STANDBYNOW2			0x94
-#define WIN_STANDBY2			0x96
-#define WIN_SETIDLE2			0x97
-#define WIN_CHECKPOWERMODE2		0x98
-#define WIN_SLEEPNOW2			0x99
-/*
- *	0x9A VENDOR
- */
-#define WIN_PACKETCMD			0xA0 /* Send a packet command. */
-#define WIN_PIDENTIFY			0xA1 /* identify ATAPI device	*/
-#define WIN_QUEUED_SERVICE		0xA2
-#define WIN_SMART			0xB0 /* self-monitoring and reporting */
-#define CFA_ERASE_SECTORS		0xC0
-#define WIN_MULTREAD			0xC4 /* read sectors using multiple mode*/
-#define WIN_MULTWRITE			0xC5 /* write sectors using multiple mode */
-#define WIN_SETMULT			0xC6 /* enable/disable multiple mode */
-#define WIN_READDMA_QUEUED		0xC7 /* read sectors using Queued DMA transfers */
-#define WIN_READDMA			0xC8 /* read sectors using DMA transfers */
-#define WIN_READDMA_ONCE		0xC9 /* 28-Bit - without retries */
-#define WIN_WRITEDMA			0xCA /* write sectors using DMA transfers */
-#define WIN_WRITEDMA_ONCE		0xCB /* 28-Bit - without retries */
-#define WIN_WRITEDMA_QUEUED		0xCC /* write sectors using Queued DMA transfers */
-#define CFA_WRITE_MULTI_WO_ERASE	0xCD /* CFA Write multiple without erase */
-#define WIN_GETMEDIASTATUS		0xDA
-#define WIN_ACKMEDIACHANGE		0xDB /* ATA-1, ATA-2 vendor */
-#define WIN_POSTBOOT			0xDC
-#define WIN_PREBOOT 			0xDD
-#define WIN_DOORLOCK			0xDE /* lock door on removable drives */
-#define WIN_DOORUNLOCK			0xDF /* unlock door on removable drives */
-#define WIN_STANDBYNOW1			0xE0
-#define WIN_IDLEIMMEDIATE		0xE1 /* force drive to become "ready" */
-#define WIN_STANDBY			0xE2 /* Set device in Standby Mode */
-#define WIN_SETIDLE1			0xE3
-#define WIN_READ_BUFFER			0xE4 /* force read only 1 sector */
-#define WIN_CHECKPOWERMODE1		0xE5
-#define WIN_SLEEPNOW1			0xE6
-#define WIN_FLUSH_CACHE			0xE7
-#define WIN_WRITE_BUFFER		0xE8 /* force write only 1 sector */
-#define WIN_WRITE_SAME			0xE9 /* read ata-2 to use */
-	/* SET_FEATURES 0x22 or 0xDD */
-#define WIN_FLUSH_CACHE_EXT		0xEA /* 48-Bit */
-#define WIN_IDENTIFY			0xEC /* ask drive to identify itself	*/
-#define WIN_MEDIAEJECT			0xED
-#define WIN_IDENTIFY_DMA		0xEE /* same as WIN_IDENTIFY, but DMA */
-#define WIN_SETFEATURES			0xEF /* set special drive features */
 #define EXABYTE_ENABLE_NEST		0xF0
-#define WIN_SECURITY_SET_PASS		0xF1
-#define WIN_SECURITY_UNLOCK		0xF2
-#define WIN_SECURITY_ERASE_PREPARE	0xF3
-#define WIN_SECURITY_ERASE_UNIT		0xF4
-#define WIN_SECURITY_FREEZE_LOCK	0xF5
-#define WIN_SECURITY_DISABLE		0xF6
-#define WIN_READ_NATIVE_MAX		0xF8 /* return the native maximum address */
-#define WIN_SET_MAX			0xF9
-#define DISABLE_SEAGATE			0xFB
 
-/* WIN_SMART sub-commands */
+/* ATA_CMD_SMART sub-commands */
 
 #define SMART_READ_VALUES		0xD0
 #define SMART_READ_THRESHOLDS		0xD1
-#define SMART_AUTOSAVE			0xD2
-#define SMART_SAVE			0xD3
-#define SMART_IMMEDIATE_OFFLINE		0xD4
-#define SMART_READ_LOG_SECTOR		0xD5
-#define SMART_WRITE_LOG_SECTOR		0xD6
-#define SMART_WRITE_THRESHOLDS		0xD7
 #define SMART_ENABLE			0xD8
-#define SMART_DISABLE			0xD9
-#define SMART_STATUS			0xDA
-#define SMART_AUTO_OFFLINE		0xDB
 
 /* Password used in TF4 & TF5 executing SMART commands */
 
 #define SMART_LCYL_PASS			0x4F
 #define SMART_HCYL_PASS			0xC2
 
-/* WIN_SETFEATURES sub-commands */
+/* ATA_CMD_SET_FEATURES sub-commands */
 #define SETFEATURES_EN_8BIT	0x01	/* Enable 8-Bit Transfers */
 #define SETFEATURES_EN_WCACHE	0x02	/* Enable write cache */
 #define SETFEATURES_DIS_DEFECT	0x04	/* Disable Defect Management */
@@ -359,15 +221,6 @@
 #define SETFEATURES_DIS_RI	0xDD	/* Disable release interrupt ATAPI */
 #define SETFEATURES_EN_SAME_M	0xDD	/* for a entire device ATA-1 */
 #define SETFEATURES_DIS_SI	0xDE	/* Disable SERVICE interrupt ATAPI */
-
-/* WIN_SECURITY sub-commands */
-
-#define SECURITY_SET_PASSWORD		0xBA
-#define SECURITY_UNLOCK			0xBB
-#define SECURITY_ERASE_PREPARE		0xBC
-#define SECURITY_ERASE_UNIT		0xBD
-#define SECURITY_FREEZE_LOCK		0xBE
-#define SECURITY_DISABLE_PASSWORD	0xBF
 
 struct hd_geometry {
       unsigned char heads;
