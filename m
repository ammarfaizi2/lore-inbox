Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423445AbWBBKWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423445AbWBBKWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423447AbWBBKWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:22:40 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:62398 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1423445AbWBBKWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:22:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] drivers/char/snsc.c kmalloc2kzalloc
From: Jes Sorensen <jes@sgi.com>
Date: 02 Feb 2006 05:22:38 -0500
Message-ID: <yq0slr2njpt.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Small patch to change the SN2 system controller driver to use kzalloc
instead of kmalloc+memset.

Cheers,
Jes

Change driver to use kzalloc rather than kmalloc+memset

Signed-off-by: Jes Sorensen <jes@sgi.com>

----

 drivers/char/snsc.c       |    8 +++-----
 drivers/char/snsc_event.c |    7 ++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/char/snsc.c
===================================================================
--- linux-2.6.orig/drivers/char/snsc.c
+++ linux-2.6/drivers/char/snsc.c
@@ -5,7 +5,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2004, 2006 Silicon Graphics, Inc. All rights reserved.
  */
 
 /*
@@ -77,7 +77,7 @@
 	scd = container_of(inode->i_cdev, struct sysctl_data_s, scd_cdev);
 
 	/* allocate memory for subchannel data */
-	sd = kmalloc(sizeof (struct subch_data_s), GFP_KERNEL);
+	sd = kzalloc(sizeof (struct subch_data_s), GFP_KERNEL);
 	if (sd == NULL) {
 		printk("%s: couldn't allocate subchannel data\n",
 		       __FUNCTION__);
@@ -85,7 +85,6 @@
 	}
 
 	/* initialize subch_data_s fields */
-	memset(sd, 0, sizeof (struct subch_data_s));
 	sd->sd_nasid = scd->scd_nasid;
 	sd->sd_subch = ia64_sn_irtr_open(scd->scd_nasid);
 
@@ -394,7 +393,7 @@
 			sprintf(devnamep, "#%d", geo_slab(geoid));
 
 			/* allocate sysctl device data */
-			scd = kmalloc(sizeof (struct sysctl_data_s),
+			scd = kzalloc(sizeof (struct sysctl_data_s),
 				      GFP_KERNEL);
 			if (!scd) {
 				printk("%s: failed to allocate device info"
@@ -402,7 +401,6 @@
 				       SYSCTL_BASENAME, devname);
 				continue;
 			}
-			memset(scd, 0, sizeof (struct sysctl_data_s));
 
 			/* initialize sysctl device data fields */
 			scd->scd_nasid = cnodeid_to_nasid(cnode);
Index: linux-2.6/drivers/char/snsc_event.c
===================================================================
--- linux-2.6.orig/drivers/char/snsc_event.c
+++ linux-2.6/drivers/char/snsc_event.c
@@ -5,7 +5,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2004, 2006 Silicon Graphics, Inc. All rights reserved.
  */
 
 /*
@@ -271,7 +271,7 @@
 {
 	int rv;
 
-	event_sd = kmalloc(sizeof (struct subch_data_s), GFP_KERNEL);
+	event_sd = kzalloc(sizeof (struct subch_data_s), GFP_KERNEL);
 	if (event_sd == NULL) {
 		printk(KERN_WARNING "%s: couldn't allocate subchannel info"
 		       " for event monitoring\n", __FUNCTION__);
@@ -279,7 +279,6 @@
 	}
 
 	/* initialize subch_data_s fields */
-	memset(event_sd, 0, sizeof (struct subch_data_s));
 	event_sd->sd_nasid = scd->scd_nasid;
 	spin_lock_init(&event_sd->sd_rlock);
 
@@ -305,5 +304,3 @@
 		return;
 	}
 }
-
-
