Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUH2T16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUH2T16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268284AbUH2T16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:27:58 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:3336 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S268282AbUH2T1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:27:43 -0400
Subject: [PATCH] 2/3: 2.6.8 zr36067 driver - use msleep() instead of
	schedule_timeout()
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       mjpeg-developer@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-VNkRXZRobvAYw/bk/HL/"
Message-Id: <1093807744.26498.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 21:29:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VNkRXZRobvAYw/bk/HL/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

attached patch makes the zr36067 driver use msleep() instead of
schedule_timeout() with uninterruptible state. Patch originally
submitted by Nishanth Aravamudan <nacc@us.ibm.com> (7/26).

Ronald

Signed-off-by: Ronald Bultje <rbultje@ronald.bitfreak.net>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

--=-VNkRXZRobvAYw/bk/HL/
Content-Disposition: attachment; filename=zoran-use-msleep.diff
Content-Type: text/x-patch; name=zoran-use-msleep.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux/drivers/media/video/zoran_device.c
--- linux~zoran-use-msleep/drivers/media/video/zoran_device.c	2004-08-14 12:55:33.000000000 +0200
+++ linux/drivers/media/video/zoran_device.c	2004-08-29 18:29:06.455019400 +0200
@@ -1105,8 +1105,7 @@
 			ZR36057_ISR);
 		btand(~ZR36057_JMC_Go_en, ZR36057_JMC);	// \Go_en
 
-		current->state = TASK_UNINTERRUPTIBLE;
-		schedule_timeout(HZ / 20);
+		msleep(50);
 
 		set_videobus_dir(zr, 0);
 		set_frame(zr, 1);	// /FRAME

--=-VNkRXZRobvAYw/bk/HL/--

