Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271935AbTGYGyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 02:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271936AbTGYGyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 02:54:45 -0400
Received: from evil.netppl.fi ([195.242.209.201]:41919 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id S271935AbTGYGyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 02:54:43 -0400
Date: Fri, 25 Jul 2003 10:09:43 +0300
From: Pekka Pietikainen <pp@netppl.fi>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make 2.4 shut up about "can't emulate rawmode for keycode 272" with logitech cordless mice
Message-ID: <20030725070942.GA29589@netppl.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Could you please apply this patch to 2.4. It fixes a very annoying problem
with logitech wireless keyboard/mouse combinations. Every time a 
mouse button is pressed the message 

keyboard.c: can't emulate rawmode for keycode 272

appears on the console, which is somewhat annoying especially if you want
to use gpm. For 2.5 this has been fixed by the patch in
http://www.cs.helsinki.fi/linux/linux-kernel/2003-06/0754.html,
Here's a similar patch for 2.4, which fixes the problem for me.

--- linux/drivers/input/keybdev.c.orig	2003-05-31 14:23:10.000000000 +0300
+++ linux/drivers/input/keybdev.c	2003-05-31 14:23:58.000000000 +0300
@@ -172,7 +172,8 @@
 	if (type != EV_KEY) return;
 
 	if (emulate_raw(code, down))
-		printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", code);
+		if(code < BTN_MISC)
+			printk(KERN_WARNING "keybdev.c: can't emulate rawmode for keycode %d\n", code);
 
 	tasklet_schedule(&keyboard_tasklet);
 }


-- 
Pekka Pietikainen
