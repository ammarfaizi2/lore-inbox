Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUFGL5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUFGL5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbUFGL5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:57:08 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:1153 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264499AbUFGLzf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:35 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <1086609353103@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1086609353730@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 11/39] input: Use reconnect instead of rescan in psmouse if possible
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.18, 2004-04-23 02:41:59-05:00, dtor_core@ameritech.net
  Input: when getting a new device announce (0xAA 0x00) in psmouse
         try reconnecting instead of rescanning to preserve (if possible)
         the same input device.


 psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-07 13:12:53 +02:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-07 13:12:53 +02:00
@@ -180,7 +180,7 @@
 		if (psmouse->pktcnt == 2) {
 			if (psmouse->packet[1] == PSMOUSE_RET_ID) {
 				psmouse->state = PSMOUSE_IGNORE;
-				serio_rescan(serio);
+				serio_reconnect(serio);
 				goto out;
 			}
 			if (psmouse->type == PSMOUSE_SYNAPTICS) {

