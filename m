Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWCVPWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWCVPWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWCVPWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:22:41 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:20146 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751307AbWCVPWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:22:40 -0500
Date: Wed, 22 Mar 2006 16:23:07 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 15/24] s390: random values in result of BIODASDINFO2.
Message-ID: <20060322152307.GO5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[patch 15/24] s390: random values in result of BIODASDINFO2.

Use kzalloc to get a zeroed buffer for the structure returned to
user space by the BIODASDINFO2 ioctl. Not all fields are set up,
e.g. the read_devno is missing.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_ioctl.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-03-22 14:36:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-03-22 14:36:27.000000000 +0100
@@ -260,7 +260,7 @@ dasd_ioctl_information(struct dasd_devic
 	if (!device->discipline->fill_info)
 		return -EINVAL;
 
-	dasd_info = kmalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
+	dasd_info = kzalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
 	if (dasd_info == NULL)
 		return -ENOMEM;
 
@@ -303,8 +303,7 @@ dasd_ioctl_information(struct dasd_devic
 		memcpy(dasd_info->type, device->discipline->name, 4);
 	else
 		memcpy(dasd_info->type, "none", 4);
-	dasd_info->req_queue_len = 0;
-	dasd_info->chanq_len = 0;
+
 	if (device->request_queue->request_fn) {
 		struct list_head *l;
 #ifdef DASD_EXTENDED_PROFILING
