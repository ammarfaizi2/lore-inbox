Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWDUPu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWDUPu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWDUPu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:50:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:56025 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932365AbWDUPu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:50:57 -0400
Date: Fri, 21 Apr 2006 10:50:50 -0500
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: LKML <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Altix snsc: duplicate kobject fix
Message-ID: <Pine.SGI.4.58.0604211007140.16960@gallifrey.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from: Greg Howard <ghoward@sgi.com>

This patch fixes Altix system controller (snsc) device names to
include the slot number of the blade whose associated system
controller is the target of the device interface.  Including the
slot number avoids a problem we're currently having where slots
within the same enclosure are attempting to create multiple
kobjects with identical names.

The patch should apply cleanly to 2.6.17.

Signed-off-by: Greg Howard <ghoward@sgi.com>
---
--- a/linux/drivers/char/snsc.c	2006-04-21 10:19:06 -05:00
+++ b/linux/drivers/char/snsc.c	2006-04-20 14:55:20 -05:00
@@ -390,7 +390,8 @@ scdrv_init(void)
 			format_module_id(devnamep, geo_module(geoid),
 					 MODULE_FORMAT_BRIEF);
 			devnamep = devname + strlen(devname);
-			sprintf(devnamep, "#%d", geo_slab(geoid));
+			sprintf(devnamep, "^%d#%d", geo_slot(geoid),
+				geo_slab(geoid));

 			/* allocate sysctl device data */
 			scd = kzalloc(sizeof (struct sysctl_data_s),
