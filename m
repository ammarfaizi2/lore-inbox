Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTLAHU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTLAHSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:18:45 -0500
Received: from smtp802.mail.ukl.yahoo.com ([217.12.12.139]:45177 "HELO
	smtp802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263488AbTLAHSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:18:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 3/3] Input: resume support for i8042 (atkbd & psmouse)
Date: Mon, 1 Dec 2003 02:17:52 -0500
User-Agent: KMail/1.5.4
Cc: Pavel Machek <pavel@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>
References: <200312010215.58533.dtor_core@ameritech.net> <200312010217.16553.dtor_core@ameritech.net>
In-Reply-To: <200312010217.16553.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312010217.54552.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1516, 2003-12-01 01:44:41-05:00, dtor_core@ameritech.net
  Input: psmouse_reconnect() - do not close/open serop port
         as i8042 should restore it for us already.


 psmouse-base.c |   10 ----------
 1 files changed, 10 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Mon Dec  1 01:46:27 2003
+++ b/drivers/input/mouse/psmouse-base.c	Mon Dec  1 01:46:27 2003
@@ -638,16 +638,6 @@
 		return -1;
 	}
 	
-	/* We need to reopen the serio port to reinitialize the i8042 controller */
-	serio_close(serio);
-	if (serio_open(serio, dev)) {
-		/* do a disconnect here as serio_open leaves dev as NULL so disconnect 
-		 * will not be called automatically later
-		 */
-		psmouse_disconnect(serio);
-		return -1;
-	}
-	
 	psmouse->state = PSMOUSE_NEW_DEVICE;
 	psmouse->type = psmouse->acking = psmouse->cmdcnt = psmouse->pktcnt = 0;
 	if (psmouse->reconnect) {
