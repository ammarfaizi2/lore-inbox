Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWALE7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWALE7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWALE7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:59:55 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:20419 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965014AbWALE7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:59:53 -0500
Date: Wed, 11 Jan 2006 23:58:40 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] Mask capabilities for SCSI-1 CD drive
To: Jens Axboe <axboe@suse.de>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601112359_MC3-1-B5B7-409F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI-1 CD drives can't do MRW or be opened for writing, so mask off
those capabilities.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.15a.orig/drivers/scsi/sr.c
+++ 2.6.15a/drivers/scsi/sr.c
@@ -762,8 +762,9 @@ static void get_capabilities(struct scsi
 		/* failed, drive doesn't have capabilities mode page */
 		cd->cdi.speed = 1;
 		cd->cdi.mask |= (CDC_CD_R | CDC_CD_RW | CDC_DVD_R |
-					 CDC_DVD | CDC_DVD_RAM |
-					 CDC_SELECT_DISC | CDC_SELECT_SPEED);
+				 CDC_DVD | CDC_DVD_RAM |
+				 CDC_SELECT_DISC | CDC_SELECT_SPEED |
+				 CDC_MRW | CDC_MRW_W | CDC_RAM);
 		kfree(buffer);
 		printk("%s: scsi-1 drive\n", cd->cdi.name);
 		return;
-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
