Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVGYGjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVGYGjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVGYFzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:55:02 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:18809 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261654AbVGYFxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:23 -0400
Message-Id: <20050725054532.587479000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 14/24] synaptics - limit rate on Toshiba Dynabooks
Content-Disposition: inline; filename=synaptics-dynabook.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Horman <horms@valinux.co.jp>

Input: synaptics - limit rate to 40pps on Toshiba Dynabooks

Toshiba Dynabooks require the same workaround as Satellites -
Synaptics report rate should be lowered to 40pps (from 80),
otherwise KBC starts losing keypresses.

Signed-off-by: Simon Horman <horms@valinux.co.jp>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/synaptics.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

Index: work/drivers/input/mouse/synaptics.c
===================================================================
--- work.orig/drivers/input/mouse/synaptics.c
+++ work/drivers/input/mouse/synaptics.c
@@ -608,6 +608,13 @@ static struct dmi_system_id toshiba_dmi_
 			DMI_MATCH(DMI_PRODUCT_NAME , "Satellite"),
 		},
 	},
+	{
+		.ident = "Toshiba Dynabook",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME , "dynabook"),
+		},
+	},
 	{ }
 };
 #endif
@@ -656,7 +663,8 @@ int synaptics_init(struct psmouse *psmou
 	 * thye same as rate of standard PS/2 mouse.
 	 */
 	if (psmouse->rate >= 80 && dmi_check_system(toshiba_dmi_table)) {
-		printk(KERN_INFO "synaptics: Toshiba Satellite detected, limiting rate to 40pps.\n");
+		printk(KERN_INFO "synaptics: Toshiba %s detected, limiting rate to 40pps.\n",
+			dmi_get_system_info(DMI_PRODUCT_NAME));
 		psmouse->rate = 40;
 	}
 #endif

