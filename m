Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbUKFCri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbUKFCri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 21:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbUKFCri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 21:47:38 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:24324 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261285AbUKFCrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 21:47:33 -0500
Message-ID: <418C3D3A.6010501@nvidia.com>
Date: Fri, 05 Nov 2004 18:55:54 -0800
From: achew <achew@nvidia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: [PATCH] sata_nv.c, don't have libata perform phy reset
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2004 02:47:32.0593 (UTC) FILETIME=[F6D07610:01C4C3AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch works around the issue reported in bug 3352 on the bugzilla bug database.

Link to the bug report: http://bugme.osdl.org/show_bug_cgi?id=3352

In particular, we keep libata from performing the phy reset.  Doing the phy reset sometimes results in the busy bit failing to deassert.

Signed-off-by: Andrew Chew <achew@nvidia.com>


--- linux-2.6.10-rc1-bk15/drivers/scsi/sata_nv.c	2004-11-05 17:49:37.000000000 -0800
+++ linux/drivers/scsi/sata_nv.c	2004-11-05 17:55:48.000000000 -0800
@@ -20,6 +20,9 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.04
+ *     - Disabled SATA phy reset to work around a problem where busy bit never
+ *       deasserts after a phy reset.
  *  0.03
  *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were using
  *       mmio_base, which is only set for the CK804/MCP04 case.
@@ -44,7 +47,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.03"
+#define DRV_VERSION			"0.04"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -221,7 +224,6 @@
 static struct ata_port_info nv_port_info = {
 	.sht		= &nv_sht,
 	.host_flags	= ATA_FLAG_SATA |
-			  ATA_FLAG_SATA_RESET |
 			  ATA_FLAG_SRST |
 			  ATA_FLAG_NO_LEGACY,
 	.pio_mask	= NV_PIO_MASK,

