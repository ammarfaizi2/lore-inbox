Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUB2HFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbUB2HEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:04:07 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:17068 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261983AbUB2HDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:03:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 5/9] psmouse broken hardware workaround
Date: Sun, 29 Feb 2004 01:58:49 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402290153.08798.dtor_core@ameritech.net> <200402290156.53325.dtor_core@ameritech.net> <200402290158.04309.dtor_core@ameritech.net>
In-Reply-To: <200402290158.04309.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290158.52036.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1689, 2004-02-27 23:57:31-05:00, dtor_core@ameritech.net
  Psmouse: some hardware does not ACK "disable streaming mode" command.
           Since we already have an idea that it's a mouse device that
           is present (from its response to GET ID command), instead of
           aborting, issue a warning and continue.


 psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Sun Feb 29 01:17:30 2004
+++ b/drivers/input/mouse/psmouse-base.c	Sun Feb 29 01:17:30 2004
@@ -442,7 +442,7 @@
  */
 
 	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
-		return -1;
+		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", psmouse->serio->phys);
 
 /*
  * And here we try to determine if it has any extensions over the
