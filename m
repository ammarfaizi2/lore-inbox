Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTBLKvq>; Wed, 12 Feb 2003 05:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbTBLKvq>; Wed, 12 Feb 2003 05:51:46 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:10121 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267023AbTBLKvn>;
	Wed, 12 Feb 2003 05:51:43 -0500
Date: Wed, 12 Feb 2003 12:01:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Only generate rawmode warnings for keys [3/14]
Message-ID: <20030212120119.B1563@ucw.cz>
References: <20030212115954.A1268@ucw.cz> <20030212120038.A1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120038.A1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:00:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1006, 2003-02-12 10:31:13+01:00, vojtech@suse.cz
  input: Only generate rawmode warnings if the event we cannot handle
  	is a real key and not just a button or something.


 keyboard.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Wed Feb 12 11:57:18 2003
+++ b/drivers/char/keyboard.c	Wed Feb 12 11:57:18 2003
@@ -1027,7 +1027,8 @@
 
 	if ((raw_mode = (kbd->kbdmode == VC_RAW)))
 		if (emulate_raw(vc, keycode, !down << 7))
-			printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
+			if (keycode < BTN_MISC)
+				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
 
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
 	if (keycode == KEY_SYSRQ && !rep) {
