Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUFVRxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUFVRxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUFVRxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:53:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:54197 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265091AbUFVRno convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:44 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261122864@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:53 -0700
Message-Id: <10879261133613@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.27, 2004/06/14 10:50:59-07:00, mhoffman@lightlink.com

[PATCH] I2C: add alternate VCORE calculations for w83627thf and w83637hf

Pick a VRM (for VID interpretation) based on the VRM & OVT config,
if available.  Props to Jean Delvare <khali@linux-fr.org> for the
idea & code fragment.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83627hf.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:46:43 2004
+++ b/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:46:43 2004
@@ -1275,12 +1275,15 @@
 	}
 
 	/* Read VRM & OVT Config only once */
-	if (w83627thf == data->type || w83637hf == data->type)
+	if (w83627thf == data->type || w83637hf == data->type) {
 		data->vrm_ovt = 
 			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
+		data->vrm = (data->vrm_ovt & 0x01) ? 90 : 82;
+	} else {
+		/* Convert VID to voltage based on default VRM */
+		data->vrm = DEFAULT_VRM;
+	}
 
-	/* Convert VID to voltage based on default VRM */
-	data->vrm = DEFAULT_VRM;
 	if (type != w83697hf)
 		vid = vid_from_reg(vid, data->vrm);
 

