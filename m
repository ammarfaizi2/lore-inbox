Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUCPO1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUCPOYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:24:41 -0500
Received: from styx.suse.cz ([82.208.2.94]:5506 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261960AbUCPOTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:50 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446778675@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 43/44] Enable relative mode and gestures if Synaptics uses non-native protocol
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <10794467783476@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.54.12, 2004-03-11 02:27:59-05:00, dtor_core@ameritech.net
  Input: if Synaptics' absolute mode is disabled make sure that
         touchpad is reset back to relative mode and gestures
         (taps) are enabled


 psmouse-base.c |    4 ++++
 synaptics.c    |    8 +++++++-
 synaptics.h    |    1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:17:26 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:17:26 2004
@@ -389,6 +389,10 @@
  */
 			psmouse_max_proto = PSMOUSE_IMEX;
 		}
+/*
+ * Make sure that touchpad is in relative mode, gestures (taps) are enabled
+ */
+		synaptics_reset(psmouse);
 	}
 
 	if (psmouse_max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Mar 16 13:17:26 2004
+++ b/drivers/input/mouse/synaptics.c	Tue Mar 16 13:17:26 2004
@@ -357,9 +357,15 @@
 	clear_bit(REL_Y, dev->relbit);
 }
 
-static void synaptics_disconnect(struct psmouse *psmouse)
+void synaptics_reset(struct psmouse *psmouse)
 {
+	/* reset touchpad back to relative mode, gestures enabled */
 	synaptics_mode_cmd(psmouse, 0);
+}
+
+static void synaptics_disconnect(struct psmouse *psmouse)
+{
+	synaptics_reset(psmouse);
 	kfree(psmouse->private);
 }
 
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	Tue Mar 16 13:17:26 2004
+++ b/drivers/input/mouse/synaptics.h	Tue Mar 16 13:17:26 2004
@@ -12,6 +12,7 @@
 extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
 extern int synaptics_detect(struct psmouse *psmouse);
 extern int synaptics_init(struct psmouse *psmouse);
+extern void synaptics_reset(struct psmouse *psmouse);
 
 /* synaptics queries */
 #define SYN_QUE_IDENTIFY		0x00

