Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTBNSw2>; Fri, 14 Feb 2003 13:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbTBNSw2>; Fri, 14 Feb 2003 13:52:28 -0500
Received: from inmail.compaq.com ([161.114.1.205]:23819 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S264716AbTBNSw1>; Fri, 14 Feb 2003 13:52:27 -0500
Date: Fri, 14 Feb 2003 13:03:17 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.60, cciss, fix array bounds overrun
Message-ID: <20030214070317.GA12692@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix overrun if you have more than 16 attached tape drives + tape changers.
Thanks to Mike Anderson for pointing this out.

-- steve

--- lx2560/drivers/block/cciss_scsi.c~currentsd_overrun	2003-02-14 12:53:35.000000000 +0600
+++ lx2560-scameron/drivers/block/cciss_scsi.c	2003-02-14 12:59:34.000000000 +0600
@@ -1106,6 +1106,12 @@ cciss_update_non_disk_devices(int cntl_n
 		{
 		  case 0x01: /* sequential access, (tape) */
 		  case 0x08: /* medium changer */
+			if (ncurrent >= CCISS_MAX_SCSI_DEVS_PER_HBA) {
+				printk(KERN_INFO "cciss%d: %s ignored, "
+					"too many devices.\n", cntl_num,
+					DEVICETYPE(devtype));
+				break;
+			}
 			memcpy(&currentsd[ncurrent].scsi3addr[0], 
 				&scsi3addr[0], 8);
 			currentsd[ncurrent].devtype = devtype;

_
