Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWKBPEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWKBPEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWKBPEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:04:31 -0500
Received: from palrel10.hp.com ([156.153.255.245]:32153 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751204AbWKBPEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:04:30 -0500
Date: Thu, 2 Nov 2006 09:04:14 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 7/8] cciss: change cciss_open for consistency
Message-ID: <20061102150414.GF16430@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PATCH 7/11

This patch changes our open to test for drv->heads like we do in other
places in the driver. Mostly for consistency.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------------------------------------------------------------------------------------------
diff -urNp linux-2.6-p00006/drivers/block/cciss.c linux-2.6/drivers/block/cciss.c
--- linux-2.6-p00006/drivers/block/cciss.c	2006-10-31 15:48:46.000000000 -0600
+++ linux-2.6/drivers/block/cciss.c	2006-10-31 15:57:39.000000000 -0600
@@ -494,7 +494,7 @@ static int cciss_open(struct inode *inod
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
-	if (drv->nr_blocks == 0) {
+	if (drv->heads == 0) {
 		if (iminor(inode) != 0) {	/* not node 0? */
 			/* if not node 0 make sure it is a partition = 0 */
 			if (iminor(inode) & 0x0f) {
