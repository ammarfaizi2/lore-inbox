Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTKYJVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 04:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTKYJVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 04:21:00 -0500
Received: from [203.199.140.162] ([203.199.140.162]:61317 "HELO
	magrathea.codito.co.in") by vger.kernel.org with SMTP
	id S262130AbTKYJU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 04:20:57 -0500
From: Amit Shah <shahamit@gmx.net>
Organization: Codito Technologies
To: linux-kernel@vger.kernel.org
Subject: SCSI: adaptec AIC7(3X): Badness in kobject_get at lib/kobject.c:439
Date: Tue, 25 Nov 2003 14:50:16 +0530
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311251450.16093.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running the 2.6.0-test10 release with CONFIG_PREEMPT=y.

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:4): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
Badness in kobject_get at lib/kobject.c:439
Call Trace:
 [<c01b62b0>] kobject_get+0x4c/0x4e
 [<c0217342>] get_device+0x1a/0x23
 [<c0244dc1>] scsi_device_get+0x2c/0x99
 [<c0244ed3>] __scsi_iterate_devices+0x3f/0x84
 [<c0248515>] scsi_run_host_queues+0x1b/0x45
 [<c0266f39>] ahc_linux_release_simq+0x95/0xd7
 [<c0263622>] ahc_linux_dv_thread+0x1f5/0x283
 [<c026342d>] ahc_linux_dv_thread+0x0/0x283
 [<c0108275>] kernel_thread_helper+0x5/0xb

  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:4:0: Tagged Queuing enabled.  Depth 32
PCI: Enabling device 0000:02:0b.0 (0116 -> 0117)
PCI: Unable to reserve mem region #2:1000@feaff000 for device 0000:02:0b.0
PCI: Unable to reserve mem region #2:1000@feaff000 for device 0000:02:0b.0
aic7xxx: <Adaptec AHA-294X Ultra SCSI host adapter> at PCI 2/11/0
aic7xxx: I/O ports already in use, ignoring.
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 0


Relevant part of the .config file is:

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_PROBE_EISA_VL=y
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC7XXX_OLD=y
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set


-- 
Amit Shah
http://amitshah.nav.to/
