Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264235AbUKAORM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbUKAORM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbUKAORJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:17:09 -0500
Received: from cantor.suse.de ([195.135.220.2]:50850 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263519AbUKAOQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:16:35 -0500
Date: Mon, 1 Nov 2004 15:16:22 +0100
From: Olaf Hering <olh@suse.de>
To: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] atyfb_base.c requires atyfb_cursor()
Message-ID: <20041101141622.GA14335@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


atyfb_base.c requires atyfb_cursor, but it is only available for linking
if CONFIG_FB_ATY_CT=y.
This patch moves the .o file to the CONFIG_FB_ATY rule.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.10-rc1-bk9.orig/drivers/video/aty/Makefile linux-2.6.10-rc1-bk9-olh/drivers/video/aty/Makefile
--- linux-2.6.10-rc1-bk9.orig/drivers/video/aty/Makefile	2004-08-14 07:36:44.000000000 +0200
+++ linux-2.6.10-rc1-bk9-olh/drivers/video/aty/Makefile	2004-10-31 21:59:06.965999776 +0100
@@ -2,9 +2,9 @@ obj-$(CONFIG_FB_ATY) += atyfb.o
 obj-$(CONFIG_FB_ATY128) += aty128fb.o
 obj-$(CONFIG_FB_RADEON) += radeonfb.o
 
-atyfb-y				:= atyfb_base.o mach64_accel.o
+atyfb-y				:= atyfb_base.o mach64_accel.o mach64_cursor.o
 atyfb-$(CONFIG_FB_ATY_GX)	+= mach64_gx.o
-atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o mach64_cursor.o
+atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o
 atyfb-objs			:= $(atyfb-y)
 
 radeonfb-y			:= radeon_base.o radeon_pm.o radeon_monitor.o radeon_accel.o

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
