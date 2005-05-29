Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVE2FDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVE2FDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVE2FCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:02:48 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:5756 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261246AbVE2FBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:09 -0400
Message-Id: <20050529045847.851027000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:24 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 11/13] i8042: dont activate MUX mode on Toshiba Satellite P10
Content-Disposition: inline; filename=toshiba-nomux.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: automatically disable MUX mode on Toshiba Satellite P10
       because it interferes with ALPS touchpad detection and
       causes horrible death on reboot. Since P10 does not have
       external PS/2 ports MUX mode does not have any advantages
       over legacy mode anyway.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

Index: work/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work.orig/drivers/input/serio/i8042-x86ia64io.h
+++ work/drivers/input/serio/i8042-x86ia64io.h
@@ -88,9 +88,11 @@ static struct dmi_system_id __initdata i
 };
 
 /*
- * Some Fujitsu notebooks are ahving trouble with touhcpads if
+ * Some Fujitsu notebooks are having trouble with touchpads if
  * active multiplexing mode is activated. Luckily they don't have
  * external PS/2 ports so we can safely disable it.
+ * ... apparently some Toshibas don't like MUX mode either and
+ * die horrible death on reboot.
  */
 static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
 	{
@@ -121,6 +123,13 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
 		},
 	},
+	{
+		.ident = "Toshiba P10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
+		},
+	},
 	{ }
 };
 

