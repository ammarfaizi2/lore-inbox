Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVFUQYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVFUQYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVFUQXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:23:47 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:12188 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262172AbVFUQX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:23:27 -0400
Date: Tue, 21 Jun 2005 18:23:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 4/16] s390: compile fix for dcssblk.
Message-ID: <20050621162329.GD6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/16] s390: compile fix for dcssblk.

From: Cornelia Huck <cohuck@de.ibm.com>

Fix compile breakage in the dcss block driver introduced by the attribute
changes.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dcssblk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dcssblk.c linux-2.6-patched/drivers/s390/block/dcssblk.c
--- linux-2.6/drivers/s390/block/dcssblk.c	2005-06-21 17:36:39.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dcssblk.c	2005-06-21 17:36:47.000000000 +0200
@@ -682,7 +682,7 @@ dcssblk_check_params(void)
 			buf[j-i] = dcssblk_segments[j];
 		}
 		buf[j-i] = '\0';
-		rc = dcssblk_add_store(dcssblk_root_dev, buf, j-i);
+		rc = dcssblk_add_store(dcssblk_root_dev, NULL, buf, j-i);
 		if ((rc >= 0) && (dcssblk_segments[j] == '(')) {
 			for (k = 0; buf[k] != '\0'; k++)
 				buf[k] = toupper(buf[k]);
@@ -692,7 +692,7 @@ dcssblk_check_params(void)
 				up_read(&dcssblk_devices_sem);
 				if (dev_info)
 					dcssblk_shared_store(&dev_info->dev,
-							     "0\n", 2);
+							     NULL, "0\n", 2);
 			}
 		}
 		while ((dcssblk_segments[j] != ',') &&
