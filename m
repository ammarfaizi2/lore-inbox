Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVIDXhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVIDXhN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVIDXhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:37:00 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:54657 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932112AbVIDXbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:03 -0400
Message-Id: <20050904232335.730738000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:49 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Oliver Endriss <o.endriss@gmx.de>
Content-Disposition: inline; filename=dvb-ttpci-av7110-remove-workaround.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 50/54] av7110: conditionally disable workaround for broken firmware
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Endriss <o.endriss@gmx.de>

Disable COM_IF_LOCK workaround for firmware > 0x261f.

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110_hw.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110_hw.c	2005-09-04 22:30:58.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110_hw.c	2005-09-04 22:30:59.000000000 +0200
@@ -366,7 +366,8 @@ static int __av7110_send_fw_cmd(struct a
 		msleep(1);
 	}
 
-	wdebi(av7110, DEBINOSWAP, COM_IF_LOCK, 0xffff, 2);
+	if (FW_VERSION(av7110->arm_app) <= 0x261f)
+		wdebi(av7110, DEBINOSWAP, COM_IF_LOCK, 0xffff, 2);
 
 #ifndef _NOHANDSHAKE
 	start = jiffies;
@@ -439,7 +440,8 @@ static int __av7110_send_fw_cmd(struct a
 
 	wdebi(av7110, DEBINOSWAP, COMMAND, (u32) buf[0], 2);
 
-	wdebi(av7110, DEBINOSWAP, COM_IF_LOCK, 0x0000, 2);
+	if (FW_VERSION(av7110->arm_app) <= 0x261f)
+		wdebi(av7110, DEBINOSWAP, COM_IF_LOCK, 0x0000, 2);
 
 #ifdef COM_DEBUG
 	start = jiffies;

--

