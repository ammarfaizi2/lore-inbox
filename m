Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbULVLwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbULVLwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbULVLv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:51:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60177 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261968AbULVLuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:50:10 -0500
Date: Wed, 22 Dec 2004 12:50:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/keyboard.c: misc cleanups (fwd)
Message-ID: <20041222115008.GO5217@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 5 Dec 2004 18:00:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/keyboard.c: misc cleanups

The patch below contains the following changes:
- make four needlessly global functions static
- remove the unused global function register_leds


diffstat output:
 drivers/char/keyboard.c |   20 ++++----------------
 1 files changed, 4 insertions(+), 16 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/keyboard.c.old	2004-11-07 00:20:09.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/keyboard.c	2004-11-07 00:21:52.000000000 +0100
@@ -330,7 +330,7 @@
  * in utf-8 already. UTF-8 is defined for words of up to 31 bits,
  * but we need only 16 bits here
  */
-void to_utf8(struct vc_data *vc, ushort c) 
+static void to_utf8(struct vc_data *vc, ushort c) 
 {
 	if (c < 0x80)
 		/*  0******* */
@@ -392,7 +392,7 @@
  * Otherwise, conclude that DIACR was not combining after all,
  * queue it and return CH.
  */
-unsigned char handle_diacr(struct vc_data *vc, unsigned char ch)
+static unsigned char handle_diacr(struct vc_data *vc, unsigned char ch)
 {
 	int d = diacr;
 	int i;
@@ -853,18 +853,6 @@
 	set_leds();
 }
 
-void register_leds(struct kbd_struct *kbd, unsigned int led,
-		   unsigned int *addr, unsigned int mask)
-{
-	if (led < 3) {
-		ledptrs[led].addr = addr;
-		ledptrs[led].mask = mask;
-		ledptrs[led].valid = 1;
-		kbd->ledmode = LED_SHOW_MEM;
-	} else
-		kbd->ledmode = LED_SHOW_FLAGS;
-}
-
 static inline unsigned char getleds(void)
 {
 	struct kbd_struct *kbd = kbd_table + fg_console;
@@ -925,7 +913,7 @@
 /*
  * This allows a newly plugged keyboard to pick the LED state.
  */
-void kbd_refresh_leds(struct input_handle *handle)
+static void kbd_refresh_leds(struct input_handle *handle)
 {
 	unsigned char leds = ledstate;
 
@@ -1027,7 +1015,7 @@
 }
 #endif
 
-void kbd_rawcode(unsigned char data)
+static void kbd_rawcode(unsigned char data)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	kbd = kbd_table + fg_console;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

