Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWISOXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWISOXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbWISOXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:23:18 -0400
Received: from reiner-h.de ([83.151.27.91]:32712 "EHLO reiner-h.de")
	by vger.kernel.org with ESMTP id S1750760AbWISOXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:23:17 -0400
From: Reiner Herrmann <reiner@reiner-h.de>
To: mitr@volny.cz
Subject: [PATCH] wistron: fix detection of special buttons
Date: Tue, 19 Sep 2006 16:23:48 +0200
User-Agent: KMail/1.9.4
Cc: dtor@mail.ru, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609191623.49407.reiner@reiner-h.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If either a wifi or a bluetooth button has been detected, the code
would break off the loop. But there are laptops that have both types of buttons,
so the loop has to continue checking.

Signed-off-by: Reiner Herrmann <reiner@reiner-h.de>
---
diff -uprN -X linux-2.6.18-rc7/Documentation/dontdiff linux-2.6.18-rc7/drivers/input/misc/wistron_btns.c linux-work/drivers/input/misc/wistron_btns.c
--- linux-2.6.18-rc7/drivers/input/misc/wistron_btns.c	2006-09-14 16:08:18.000000000 +0200
+++ linux-work/drivers/input/misc/wistron_btns.c	2006-09-19 16:03:30.000000000 +0200
@@ -248,13 +248,10 @@ static int __init dmi_matched(struct dmi
 
 	keymap = dmi->driver_data;
 	for (key = keymap; key->type != KE_END; key++) {
-		if (key->type == KE_WIFI) {
+		if (key->type == KE_WIFI)
 			have_wifi = 1;
-			break;
-		} else if (key->type == KE_BLUETOOTH) {
+		else if (key->type == KE_BLUETOOTH)
 			have_bluetooth = 1;
-			break;
-		}
 	}
 	return 1;
 }
