Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWAQQf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWAQQf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWAQQf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:35:28 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:19161
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932145AbWAQQf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:35:27 -0500
Subject: [PATCH] synclink_gt fix size of register value storage
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 10:35:18 -0600
Message-Id: <1137515718.3403.5.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect variable size used to hold
register value. This bug might wipe out a portion of the
TCR value when setting the interface options.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>


--- linux-2.6.16-rc1/drivers/char/synclink_gt.c	2006-01-17 09:31:20.000000000 -0600
+++ linux-2.6.16-rc1-mg/drivers/char/synclink_gt.c	2006-01-17 10:22:48.000000000 -0600
@@ -2630,7 +2630,7 @@ static int get_interface(struct slgt_inf
 static int set_interface(struct slgt_info *info, int if_mode)
 {
  	unsigned long flags;
-	unsigned char val;
+	unsigned short val;
 
 	DBGINFO(("%s set_interface=%x)\n", info->device_name, if_mode));
 	spin_lock_irqsave(&info->lock,flags);


