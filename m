Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbULBKb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbULBKb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 05:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbULBKb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 05:31:56 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:58641 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S261539AbULBKbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 05:31:53 -0500
Date: Thu, 2 Dec 2004 11:30:07 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.2x, 2.6.x][PPC32] don't recursively crash in die() on CHRP/PReP machines
Message-ID: <20041202103007.GA32637@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch avoids recursive crash (leading to kernel stack overflow) in
die() on CHRP/PReP machines when CONFIG_PMAC_BACKLIGHT=y.
set_backlight_* functions are placed in pmac section, which is discarded
when _machine != _MACH_Pmac.

Should apply to latest 2.4.x and 2.6.x as well.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-ppc-oops.patch"

--- linux-2.4.27/arch/ppc/kernel/traps.c.orig	Wed Apr 14 15:05:27 2004
+++ linux-2.4.27/arch/ppc/kernel/traps.c	Mon Nov 29 19:05:28 2004
@@ -88,8 +88,10 @@
 	console_verbose();
 	spin_lock_irq(&die_lock);
 #ifdef CONFIG_PMAC_BACKLIGHT
-	set_backlight_enable(1);
-	set_backlight_level(BACKLIGHT_MAX);
+	if (_machine == _MACH_Pmac) {
+		set_backlight_enable(1);
+		set_backlight_level(BACKLIGHT_MAX);
+	}
 #endif
 	printk("Oops: %s, sig: %ld\n", str, err);
 	show_regs(fp);

--ReaqsoxgOBHFXBhH--
