Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVA0RP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVA0RP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVA0RPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:15:35 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:63455 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262669AbVA0ROU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:14:20 -0500
Subject: [PATCH 5/6] Add missing input_sync() calls to atkbd.c
In-Reply-To: <11068460381981@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 27 Jan 2005 18:13:58 +0100
Message-Id: <11068460382243@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1975.1.3, 2005-01-27 14:58:43+01:00, vojtech@silver.ucw.cz
  input: Add missing input_sync() calls to atkbd.c.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 atkbd.c |    2 ++
 1 files changed, 2 insertions(+)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2005-01-27 17:47:36 +01:00
+++ b/drivers/input/keyboard/atkbd.c	2005-01-27 17:47:36 +01:00
@@ -234,6 +234,7 @@
 	input_regs(dev, regs);
 	if (value == 3) {
 		input_report_key(dev, code, 1);
+		input_sync(dev);
 		input_report_key(dev, code, 0);
 	} else
 		input_event(dev, EV_KEY, code, value);
@@ -352,6 +353,7 @@
 				       "to make it known.\n",
 				       code & 0x80 ? "e0" : "", code & 0x7f);
 			}
+			input_sync(&atkbd->dev);
 			break;
 		case ATKBD_SCR_1:
 			scroll = 1 - atkbd->release * 2;

