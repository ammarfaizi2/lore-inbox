Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVGUFZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVGUFZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVGUFZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:25:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10954 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261628AbVGUFZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:25:26 -0400
Date: Thu, 21 Jul 2005 07:25:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, Russell King <rmk@arm.linux.org.uk>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] fix compilation in collie.c
Message-ID: <20050721052527.GC7849@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes wrong number of arguments in call to write_scoop_reg, fixes
map_name and John's email. Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  *
  * ChangeLog:
- *  03-06-2004 John Lenz <jelenz@wisc.edu>
+ *  03-06-2004 John Lenz <lenz@cs.wisc.edu>
  *  06-04-2002 Chris Larson <kergoth@digitalnemesis.net>
  *  04-16-2001 Lineo Japan,Inc. ...
  */
@@ -111,16 +180,16 @@ static struct mtd_partition collie_parti
 
 static void collie_set_vpp(int vpp)
 {
-	write_scoop_reg(SCOOP_GPCR, read_scoop_reg(SCOOP_GPCR) | COLLIE_SCP_VPEN);
+	write_scoop_reg(NULL, SCOOP_GPCR, read_scoop_reg(NULL, SCOOP_GPCR) | COLLIE_SCP_VPEN);
 	if (vpp) {
-		write_scoop_reg(SCOOP_GPWR, read_scoop_reg(SCOOP_GPWR) | COLLIE_SCP_VPEN);
+		write_scoop_reg(NULL, SCOOP_GPWR, read_scoop_reg(NULL, SCOOP_GPWR) | COLLIE_SCP_VPEN);
 	} else {
-		write_scoop_reg(SCOOP_GPWR, read_scoop_reg(SCOOP_GPWR) & ~COLLIE_SCP_VPEN);
+		write_scoop_reg(NULL, SCOOP_GPWR, read_scoop_reg(NULL, SCOOP_GPWR) & ~COLLIE_SCP_VPEN);
 	}
 }
 
 static struct flash_platform_data collie_flash_data = {
-	.map_name	= "cfi_probe",
+	.map_name	= "sharp",
 	.set_vpp	= collie_set_vpp,
 	.parts		= collie_partitions,
 	.nr_parts	= ARRAY_SIZE(collie_partitions),

-- 
teflon -- maybe it is a trademark, but it should not be.
