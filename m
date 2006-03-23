Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWCWUCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWCWUCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWCWUCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:02:08 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:40921 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964918AbWCWUCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:02:07 -0500
Date: Thu, 23 Mar 2006 21:02:05 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Micah Anderson <micah@riseup.net>,
       Daniel Hokka Zakrisson <daniel@hozac.com>
Subject: [PATCH] mtd: fix broken name_to_dev_t() declaration
Message-ID: <20060323200205.GJ17981@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Micah Anderson <micah@riseup.net>,
	Daniel Hokka Zakrisson <daniel@hozac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew! Folks!

drivers/mtd/devices/blkmtd.c uses a local declaration
of name_to_dev_t() which is inconsistant with the real
one. the following patch fixes this by removing the 
local declaration and including mount.h instead

this patch was originally done by Micah Anderson.

best,
Herbert

Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>
Acked-by: Micah Anderson <micah@riseup.net>
Acked-by: Daniel Hokka Zakrisson <daniel@hozac.com>
---

--- ./drivers/mtd/devices/blkmtd.c.orig	2006-01-03 17:29:35 +0100
+++ ./drivers/mtd/devices/blkmtd.c	2006-03-23 20:53:58 +0100
@@ -28,6 +28,7 @@
 #include <linux/pagemap.h>
 #include <linux/list.h>
 #include <linux/init.h>
+#include <linux/mount.h>
 #include <linux/mtd/mtd.h>
 
 
@@ -614,8 +615,6 @@ static struct mtd_erase_region_info *cal
 }
 
 
-extern dev_t __init name_to_dev_t(const char *line);
-
 static struct blkmtd_dev *add_device(char *devname, int readonly, int erase_size)
 {
 	struct block_device *bdev;

