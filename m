Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWCEO40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWCEO40 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 09:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCEO40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 09:56:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11488 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751298AbWCEO4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 09:56:25 -0500
Date: Sun, 5 Mar 2006 15:28:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [patch] fix hardcoded values in collie frontlight
Message-ID: <20060305142859.GA21173@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In frontlight support, we should really use values from flash-ROM
instead of hardcoding our own.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index ada6e75..2bcff84 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -20,6 +20,7 @@
 
 #include <asm/hardware/locomo.h>
 #include <asm/irq.h>
+#include <asm/mach/sharpsl_param.h>
 
 #ifdef CONFIG_SA1100_COLLIE
 #include <asm/arch/collie.h>
@@ -27,7 +28,7 @@
 #include <asm/arch/poodle.h>
 #endif
 
-extern void (*sa1100fb_lcd_power)(int on);
+#include "../../../arch/arm/mach-sa1100/generic.h"
 
 static struct locomo_dev *locomolcd_dev;
 
@@ -82,7 +83,7 @@ static void locomolcd_off(int comadj)
 
 void locomolcd_power(int on)
 {
-	int comadj = 118;
+	int comadj = sharpsl_param.comadj;
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -93,11 +94,13 @@ void locomolcd_power(int on)
 	}
 
 	/* read comadj */
+	if (comadj == -1) {
 #ifdef CONFIG_MACH_POODLE
-	comadj = 118;
+		comadj = 118;
 #else
-	comadj = 128;
+		comadj = 128;
 #endif
+	}
 
 	if (on)
 		locomolcd_on(comadj);

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
