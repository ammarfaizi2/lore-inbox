Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267106AbTGHKcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265759AbTGHKcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:32:55 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:36488 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S267106AbTGHKbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:31:37 -0400
Date: Tue, 8 Jul 2003 12:45:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Make synaptics support optional
Message-ID: <20030708104551.GA209@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Synaptics support breaks mouse for me (HP omnibook xe3). I guess it
should have its own config option, and perhaps it should be marked
experimental...

What about this patch?
								Pavel

--- /usr/src/tmp/linux/drivers/input/mouse/Kconfig	2003-06-24 12:27:47.000000000 +0200
+++ /usr/src/linux/drivers/input/mouse/Kconfig	2003-07-08 12:33:47.000000000 +0200
@@ -30,6 +30,12 @@
 	  The module will be called psmouse. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+config MOUSE_SYNAPTICS
+	tristate "Synaptics touchpad support"
+	depends on INPUT_MOUSE && MOUSE_PS2
+	help
+	  Say Y if you want your touchpad not to work any more.
+
 config MOUSE_SERIAL
 	tristate "Serial mouse"
 	depends on INPUT && INPUT_MOUSE && SERIO
@@ -134,4 +140,3 @@
 	  inserted in and removed from the running kernel whenever you want).
 	  The module will be called logibm.o. If you want to compile it as a
 	  module, say M here and read <file.:Documentation/modules.txt>.
-
--- /usr/src/tmp/linux/drivers/input/mouse/synaptics.c	2003-06-24 12:27:47.000000000 +0200
+++ /usr/src/linux/drivers/input/mouse/synaptics.c	2003-07-08 12:32:36.000000000 +0200
@@ -213,6 +213,9 @@
 {
 	struct synaptics_data *priv;
 
+#ifndef CONFIG_MOUSE_SYNAPTICS
+	return -1;
+#endif;
 	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
 	if (!priv)
 		return -1;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
