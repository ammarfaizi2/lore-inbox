Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTJZRqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTJZRqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:46:25 -0500
Received: from smtp2.libero.it ([193.70.192.52]:938 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S263370AbTJZRqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:46:18 -0500
Date: Sun, 26 Oct 2003 18:48:53 +0100
From: Daniele Pala <dandario@libero.it>
To: linux-kernel@vger.kernel.org
Cc: paulus@cs.anu.edu.au
Subject: [PPC] Mac mouse emulate buttons
Message-ID: <20031026174853.GA350@SuperSoul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mouse button emulation doesn't work in the console, because the expression

if ((raw_mode = (kbd->kbdmode == VC_RAW)))

never gets true. So i moved the call to mac_hid_mouse_emulate_buttons outside the emulate_raw function. Mouse emulation
sucks, but i'm too poor to buy a 3-buttons mouse :)

I'm not subscribed to the list, please CC me privately

Cheers,
	Daniele


--- linux-2.6.0-test8/drivers/char/keyboard.c	Tue Sep 30 18:43:22 2003
+++ linux-2.6.0-test8_mod/drivers/char/keyboard.c	Sun Oct 26 09:31:50 2003
@@ -964,11 +964,6 @@
 static int emulate_raw(struct vc_data *vc, unsigned int keycode, 
 		       unsigned char up_flag)
 {
-#ifdef CONFIG_MAC_EMUMOUSEBTN
-	if (mac_hid_mouse_emulate_buttons(1, keycode, !up_flag))
-		return 0;
-#endif /* CONFIG_MAC_EMUMOUSEBTN */
-
 	if (keycode > 255 || !x86_keycodes[keycode])
 		return -1; 
 
@@ -1039,6 +1034,11 @@
 #endif
 
 	rep = (down == 2);
+
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+        if(mac_hid_mouse_emulate_buttons(1, keycode, down << 7))
+		return;
+#endif /* CONFIG_MAC_EMUMOUSEBTN */
 
 	if ((raw_mode = (kbd->kbdmode == VC_RAW)))
 		if (emulate_raw(vc, keycode, !down << 7))



