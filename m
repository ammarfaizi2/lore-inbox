Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVKTGrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVKTGrf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVKTGrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:47:17 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:60306 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750756AbVKTGrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:12 -0500
Message-Id: <20051120064420.140395000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 07/14] wistron - disable wifi/bluetooth on suspend
Content-Disposition: inline; filename=wistron-disable-on-suspend.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miloslav Trmac <mitr@volny.cz>

Input: wistron - disable wifi/bluetooth on suspend

Try to save battery power by disabling wifi and bluetooth on suspend.

Signed-off-by: Miloslav Trmac <mitr@volny.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/wistron_btns.c |    6 ++++++
 1 files changed, 6 insertions(+)

Index: work/drivers/input/misc/wistron_btns.c
===================================================================
--- work.orig/drivers/input/misc/wistron_btns.c
+++ work/drivers/input/misc/wistron_btns.c
@@ -451,6 +451,12 @@ static int wistron_suspend(struct platfo
 {
 	del_timer_sync(&poll_timer);
 
+	if (have_wifi)
+		bios_set_state(WIFI, 0);
+
+	if (have_bluetooth)
+		bios_set_state(BLUETOOTH, 0);
+
 	return 0;
 }
 

