Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264989AbUDUGIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbUDUGIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264988AbUDUGIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:08:37 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:40364 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264989AbUDUGFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:46 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] New set of input patches: psmouse rescan on hotplug
Date: Wed, 21 Apr 2004 01:00:03 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210100.05530.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1911, 2004-04-20 22:33:23-05:00, dtor_core@ameritech.net
  Input: when getting a new device announce (0xAA 0x00) in psmouse
         try reconnecting instead of rescanning to preserve (if possible)
         the same input device.


 psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Apr 20 23:10:23 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Apr 20 23:10:23 2004
@@ -180,7 +180,7 @@
 		if (psmouse->pktcnt == 2) {
 			if (psmouse->packet[1] == PSMOUSE_RET_ID) {
 				psmouse->state = PSMOUSE_IGNORE;
-				serio_rescan(serio);
+				serio_reconnect(serio);
 				goto out;
 			}
 			if (psmouse->type == PSMOUSE_SYNAPTICS) {
