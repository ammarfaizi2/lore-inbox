Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUCPPfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUCPOjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:39:39 -0500
Received: from styx.suse.cz ([82.208.2.94]:63617 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261921AbUCPOTn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:43 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <107944677736@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 19/44] Don't fail when mouse reset doesn't work
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467772683@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.54.5, 2004-03-03 00:31:24-05:00, dtor_core@ameritech.net
  Psmouse: some hardware does not ACK "disable streaming mode" command.
           Since we already have an idea that it's a mouse device that
           is present (from its response to GET ID command), instead of
           aborting, issue a warning and continue.


 psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:18:55 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:18:55 2004
@@ -442,7 +442,7 @@
  */
 
 	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
-		return -1;
+		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", psmouse->serio->phys);
 
 /*
  * And here we try to determine if it has any extensions over the

