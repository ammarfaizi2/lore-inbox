Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTDHAPN (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTDHAMo (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:12:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21889
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263810AbTDGXWf (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:22:35 -0400
Date: Tue, 8 Apr 2003 01:41:30 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080041.h380fUaG009330@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH; ics2101 needs to match the gus_lock name too
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/ics2101.c linux-2.5.67-ac1/sound/oss/ics2101.c
--- linux-2.5.67/sound/oss/ics2101.c	2003-02-10 18:38:00.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/ics2101.c	2003-04-03 23:45:12.000000000 +0100
@@ -29,7 +29,7 @@
 
 extern int     *gus_osp;
 extern int      gus_base;
-extern spinlock_t lock;
+extern spinlock_t gus_lock;
 static int      volumes[ICS_MIXDEVS];
 static int      left_fix[ICS_MIXDEVS] =
 {1, 1, 1, 2, 1, 2};
@@ -87,12 +87,12 @@
 		attn_addr |= 0x03;
 	}
 
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
 	outb((ctrl_addr), u_MixSelect);
 	outb((selector[dev]), u_MixData);
 	outb((attn_addr), u_MixSelect);
 	outb(((unsigned char) vol), u_MixData);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
 
 static int set_volumes(int dev, int vol)
@@ -209,10 +209,10 @@
 
 static struct mixer_operations ics2101_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"ICS2101",
-	name:	"ICS2101 Multimedia Mixer",
-	ioctl:	ics2101_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "ICS2101",
+	.name	= "ICS2101 Multimedia Mixer",
+	.ioctl	= ics2101_mixer_ioctl
 };
 
 int __init ics2101_mixer_init(void)
