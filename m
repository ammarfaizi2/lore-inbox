Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVGYC6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVGYC6m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 22:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVGYC6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 22:58:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15594 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261621AbVGYC6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 22:58:41 -0400
Date: Mon, 25 Jul 2005 04:58:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix compilation in collie.c
Message-ID: <20050725025833.GA1773@elf.ucw.cz>
References: <20050721052527.GC7849@elf.ucw.cz> <20050724233503.C20019@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050724233503.C20019@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes wrong number of arguments in call to write_scoop_reg and
John's email. Please apply,
							Pavel

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
@@ -111,16 +180,18 @@ static struct mtd_partition collie_parti
 
 static void collie_set_vpp(int vpp)
 {
-	write_scoop_reg(SCOOP_GPCR, read_scoop_reg(SCOOP_GPCR) | COLLIE_SCP_VPEN);
+	struct device *dev = &colliescoop_device.dev;
+
+	write_scoop_reg(dev, SCOOP_GPCR, read_scoop_reg(dev, SCOOP_GPCR) | COLLIE_SCP_VPEN);
 	if (vpp) {
-		write_scoop_reg(SCOOP_GPWR, read_scoop_reg(SCOOP_GPWR) | COLLIE_SCP_VPEN);
+		write_scoop_reg(dev, SCOOP_GPWR, read_scoop_reg(dev, SCOOP_GPWR) | COLLIE_SCP_VPEN);
 	} else {
-		write_scoop_reg(SCOOP_GPWR, read_scoop_reg(SCOOP_GPWR) & ~COLLIE_SCP_VPEN);
+		write_scoop_reg(dev, SCOOP_GPWR, read_scoop_reg(dev, SCOOP_GPWR) & ~COLLIE_SCP_VPEN);
 	}
 }
 
 static struct flash_platform_data collie_flash_data = {
 	.map_name	= "cfi_probe",
 	.set_vpp	= collie_set_vpp,
 	.parts		= collie_partitions,
 	.nr_parts	= ARRAY_SIZE(collie_partitions),

-- 
teflon -- maybe it is a trademark, but it should not be.
