Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUCPOX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUCPOXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:23:55 -0500
Received: from styx.suse.cz ([82.208.2.94]:4226 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261959AbUCPOTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:50 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446778376@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 38/44] Fix oops (NULL pointer dereference) on resume in psmouse.c
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <10794467783462@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.78.12, 2004-03-08 14:32:00+01:00, vojtech@suse.cz
  input: Fix oops (NULL pointer dereference) on resume in psmouse.c,
         when the mouse goes away while sleeping.


 psmouse-base.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:17:45 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:17:45 2004
@@ -643,12 +643,14 @@
 {
 	struct psmouse *psmouse = serio->private;
 	struct serio_dev *dev = serio->dev;
-	int old_type = psmouse->type;
+	int old_type;
 
-	if (!dev) {
+	if (!dev || !psmouse) {
 		printk(KERN_DEBUG "psmouse: reconnect request, but serio is disconnected, ignoring...\n");
 		return -1;
 	}
+
+	old_type = psmouse->type;
 
 	psmouse->state = PSMOUSE_NEW_DEVICE;
 	psmouse->type = psmouse->acking = psmouse->cmdcnt = psmouse->pktcnt = 0;

