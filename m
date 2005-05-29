Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVE2FDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVE2FDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVE2FDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:03:10 -0400
Received: from smtp833.mail.sc5.yahoo.com ([66.163.171.20]:31857 "HELO
	smtp833.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261249AbVE2FBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:12 -0400
Message-Id: <20050529045847.502681000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:21 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 08/13] psmouse: workaround for Sunrex mouse
Content-Disposition: inline; filename=sunrex-kbd-mouse-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: Workaround for Sunrex K8561 IR Keyboard/Mouse. The mouse
       sends an incorrect ID and wasn't recognized.

Reported-by: Stefan Seyfried <seife@suse.de>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/psmouse-base.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -518,13 +518,16 @@ static int psmouse_probe(struct psmouse 
 /*
  * First, we check if it's a mouse. It should send 0x00 or 0x03
  * in case of an IntelliMouse in 4-byte mode or 0x04 for IM Explorer.
+ * Sunrex K8561 IR Keyboard/Mouse reports 0xff on second and subsequent
+ * ID queries, probably due to a firmware bug.
  */
 
 	param[0] = 0xa5;
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
 		return -1;
 
-	if (param[0] != 0x00 && param[0] != 0x03 && param[0] != 0x04)
+	if (param[0] != 0x00 && param[0] != 0x03 &&
+	    param[0] != 0x04 && param[0] != 0xff)
 		return -1;
 
 /*

