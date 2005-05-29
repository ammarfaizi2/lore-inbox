Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVE2FDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVE2FDX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVE2FCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:02:40 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:63113 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261247AbVE2FBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:09 -0400
Message-Id: <20050529045848.083190000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 13/13] synaptics: be less verbose on startup
Content-Disposition: inline; filename=synaptics-verbosiness.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: synaptics - reduce verboseness of synaptics driver - there
       is no reason one driver should take 10 lines in dmesg.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/synaptics.c |   39 +++++----------------------------------
 1 files changed, 5 insertions(+), 34 deletions(-)

Index: work/drivers/input/mouse/synaptics.c
===================================================================
--- work.orig/drivers/input/mouse/synaptics.c
+++ work/drivers/input/mouse/synaptics.c
@@ -143,39 +143,6 @@ static int synaptics_identify(struct psm
 	return -1;
 }
 
-static void print_ident(struct synaptics_data *priv)
-{
-	printk(KERN_INFO "Synaptics Touchpad, model: %ld\n", SYN_ID_MODEL(priv->identity));
-	printk(KERN_INFO " Firmware: %ld.%ld\n", SYN_ID_MAJOR(priv->identity),
-	       SYN_ID_MINOR(priv->identity));
-	if (SYN_MODEL_ROT180(priv->model_id))
-		printk(KERN_INFO " 180 degree mounted touchpad\n");
-	if (SYN_MODEL_PORTRAIT(priv->model_id))
-		printk(KERN_INFO " portrait touchpad\n");
-	printk(KERN_INFO " Sensor: %ld\n", SYN_MODEL_SENSOR(priv->model_id));
-	if (SYN_MODEL_NEWABS(priv->model_id))
-		printk(KERN_INFO " new absolute packet format\n");
-	if (SYN_MODEL_PEN(priv->model_id))
-		printk(KERN_INFO " pen detection\n");
-
-	if (SYN_CAP_EXTENDED(priv->capabilities)) {
-		printk(KERN_INFO " Touchpad has extended capability bits\n");
-		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
-			printk(KERN_INFO " -> %d multi-buttons, i.e. besides standard buttons\n",
-			       (int)(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)));
-		if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
-			printk(KERN_INFO " -> middle button\n");
-		if (SYN_CAP_FOUR_BUTTON(priv->capabilities))
-			printk(KERN_INFO " -> four buttons\n");
-		if (SYN_CAP_MULTIFINGER(priv->capabilities))
-			printk(KERN_INFO " -> multifinger detection\n");
-		if (SYN_CAP_PALMDETECT(priv->capabilities))
-			printk(KERN_INFO " -> palm detection\n");
-		if (SYN_CAP_PASS_THROUGH(priv->capabilities))
-			printk(KERN_INFO " -> pass-through port\n");
-	}
-}
-
 static int synaptics_query_hardware(struct psmouse *psmouse)
 {
 	int retries = 0;
@@ -666,7 +633,11 @@ int synaptics_init(struct psmouse *psmou
 
 	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;
 
-	print_ident(priv);
+	printk(KERN_INFO "Synaptics Touchpad, model: %ld, fw: %ld.%ld, id: %#lx, caps: %#lx/%#lx\n",
+		SYN_ID_MODEL(priv->identity),
+		SYN_ID_MAJOR(priv->identity), SYN_ID_MINOR(priv->identity),
+		priv->model_id, priv->capabilities, priv->ext_cap);
+
 	set_input_params(&psmouse->dev, priv);
 
 	psmouse->protocol_handler = synaptics_process_byte;

