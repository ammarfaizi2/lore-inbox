Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTLSM5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTLSMz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:55:59 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:22414 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262864AbTLSMgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:36:54 -0500
Date: Fri, 19 Dec 2003 13:36:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: ryutaroh@it.ss.titech.ac.jp
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
Message-ID: <20031219123645.GA28801@ucw.cz>
References: <20031219.212456.74735601.ryutaroh@it.ss.titech.ac.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20031219.212456.74735601.ryutaroh@it.ss.titech.ac.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 19, 2003 at 09:24:56PM +0900, ryutaroh@it.ss.titech.ac.jp wrote:
> Hello,
> 
> I found a problem in drivers/input/keyboard/atkbd.c in Linux 2.6.0.
> 
> We cannot input | (bar) with the JP 106 keyboards (the standard Japanese
> keyboards). This is because the scancode 0x7d (125) is translated to
> the keycode 0xb7 (183). The scancode 0x7d corresponds to | (bar) on
> the JP 106 keyboard. In Linux 2.4.23, the scancode 0x7d (125) is
> translated to the keycode 0x7c (124). Scancodes and keycodes can be
> displayed by showkey(1).
> 
> The following patch makes the translation rule the same as that in
> Linux 2.4.23. We also have to update drivers/char/keyboard.c in order
> to get correct scancode.
> 
> If you send comments, please send them to
> ryutaroh@it.ss.titech.ac.jp. I don't subscribe LKML.

Can you try the attached patch?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=setkeycodes-fix


ChangeSet@1.1373, 2003-10-28 23:14:03+01:00, vojtech@suse.cz
  input: Make setkeycodes actually be useful on 2.6, the tables will
  follow 2.4 format now by default. Also fixes Japanese and Korean
  key mappings, because they are part of the problem.

 drivers/char/keyboard.c        |   35 ++++----
 drivers/input/keyboard/atkbd.c |  176 +++++++++++++++++++++--------------------
 include/linux/keyboard.h       |    3 
 3 files changed, 116 insertions(+), 98 deletions(-)

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Tue Oct 28 23:16:06 2003
+++ b/drivers/char/keyboard.c	Tue Oct 28 23:16:06 2003
@@ -941,16 +941,16 @@
 	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
 	 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
 	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-	 80, 81, 82, 83, 43, 85, 86, 87, 88,115,119,120,121,375,123, 90,
-	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
-	367,288,302,304,350, 92,334,512,116,377,109,111,373,347,348,349,
-	360, 93, 94, 95, 98,376,100,101,321,316,354,286,289,102,351,355,
+	 80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
+	284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
+	367,288,302,304,350, 89,334,326,116,377,109,111,126,347,348,349,
+	360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
 	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
-	291,108,381,281,290,272,292,305,280, 99,112,257,258,359,270,114,
-	118,117,125,374,379,115,112,125,121,123,264,265,266,267,268,269,
-	271,273,276,277,278,282,283,295,296,297,299,300,301,293,303,307,
-	308,310,313,314,315,317,318,319,320,357,322,323,324,325,326,330,
-	332,340,365,342,343,344,345,346,356,113,341,368,369,370,371,372 };
+	291,108,381,281,290,272,292,305,280, 99,112,257,258,359,113,114,
+	264,117,271,374,379,115,125,273,121,123, 92,265,266,267,268,269,
+	120,119,118,277,278,282,283,295,296,297,299,300,301,293,303,307,
+	308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
+	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };
 
 #ifdef CONFIG_MAC_EMUMOUSEBTN
 extern int mac_hid_mouse_emulate_buttons(int, int, int);
@@ -972,11 +972,18 @@
 	if (keycode > 255 || !x86_keycodes[keycode])
 		return -1; 
 
-	if (keycode == KEY_PAUSE) {
-		put_queue(vc, 0xe1);
-		put_queue(vc, 0x1d | up_flag);
-		put_queue(vc, 0x45 | up_flag);
-		return 0;
+	switch (keycode) {
+		case KEY_PAUSE:
+			put_queue(vc, 0xe1);
+			put_queue(vc, 0x1d | up_flag);
+			put_queue(vc, 0x45 | up_flag);
+			return 0;
+		case KEY_LANG1:
+			if (!up_flag) put_queue(vc, 0xf1);
+			return 0;
+		case KEY_LANG2:
+			if (!up_flag) put_queue(vc, 0xf2);
+			return 0;
 	} 
 
 	if (keycode == KEY_SYSRQ && sysrq_alt) {
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Oct 28 23:16:06 2003
+++ b/drivers/input/keyboard/atkbd.c	Tue Oct 28 23:16:06 2003
@@ -48,33 +48,30 @@
  */
 
 static unsigned char atkbd_set2_keycode[512] = {
-	  0, 67, 65, 63, 61, 59, 60, 88,  0, 68, 66, 64, 62, 15, 41, 85,
-	  0, 56, 42,182, 29, 16,  2, 89,  0,  0, 44, 31, 30, 17,  3, 90,
-	  0, 46, 45, 32, 18,  5,  4, 91, 90, 57, 47, 33, 20, 19,  6,  0,
-	 91, 49, 48, 35, 34, 21,  7,  0,  0,  0, 50, 36, 22,  8,  9,  0,
+
+	  0, 67, 65, 63, 61, 59, 60, 88,  0, 68, 66, 64, 62, 15, 41,117,
+	  0, 56, 42,182, 29, 16,  2,  0,  0,  0, 44, 31, 30, 17,  3,  0,
+	  0, 46, 45, 32, 18,  5,  4,186,  0, 57, 47, 33, 20, 19,  6, 85,
+	  0, 49, 48, 35, 34, 21,  7, 89,  0,  0, 50, 36, 22,  8,  9, 90,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
-	122, 89, 40,120, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,  0,
-	 85, 86, 90, 91, 92, 93, 14, 94, 95, 79,183, 75, 71,121,  0,123,
+	  0,181, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,194,
+	  0, 86,193,192,184,  0, 14,185,  0, 79,182, 75, 71,124,  0,  0,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
-	  0,  0,  0, 65, 99,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,
-	  0,  0, 92, 90, 85,  0,137,  0,  0,  0,  0, 91, 89,144,115,  0,
-	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,  0,125,
-	173,114,  0,113,152,163,151,126,128,166,  0,140,  0,147,  0,127,
-	159,167,115,160,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
-	157,  0,114,166,168,  0,  0,213,155,  0, 98,113,  0,163,  0,138,
-	226,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
-	133,  0,116,  0,143,  0,174,133,  0,107,  0,105,102,  0,  0,112,
-	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119
+	217,100,255,  0, 97,165,  0,  0,156,  0,  0,  0,  0,  0,  0,125,
+	173,114,  0,113,  0,  0,  0,126,128,  0,  0,140,  0,  0,  0,127,
+	159,  0,115,  0,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
+	157,  0,  0,  0,  0,  0,  0,  0,155,  0, 98,  0,  0,163,  0,  0,
+	226,  0,  0,  0,  0,  0,  0,  0,  0,255, 96,  0,  0,  0,143,  0,
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,107,  0,105,102,  0,  0,112,
+	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119,  0,
+
+	  0,  0,  0, 65, 99,
 };
 
 static unsigned char atkbd_set3_keycode[512] = {
+
 	  0,  0,  0,  0,  0,  0,  0, 59,  1,138,128,129,130, 15, 41, 60,
 	131, 29, 42, 86, 58, 16,  2, 61,133, 56, 44, 31, 30, 17,  3, 62,
 	134, 46, 45, 32, 18,  5,  4, 63,135, 57, 47, 33, 20, 19,  6, 64,
@@ -83,25 +80,21 @@
 	113,114, 40, 84, 26, 13, 87, 99, 97, 54, 28, 27, 43, 84, 88, 70,
 	108,105,119,103,111,107, 14,110,  0, 79,106, 75, 71,109,102,104,
 	 82, 83, 80, 76, 77, 72, 69, 98,  0, 96, 81,  0, 78, 73, 55, 85,
+
 	 89, 90, 91, 92, 74,185,184,182,  0,  0,  0,125,126,127,112,  0,
 	  0,139,150,163,165,115,152,150,166,140,160,154,113,114,167,168,
-	148,149,147,140,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255
+	148,149,147,140
 };
 
 static unsigned char atkbd_unxlate_table[128] = {
-	  0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
-	 21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
-	 35, 43, 52, 51, 59, 66, 75, 76, 82, 14, 18, 93, 26, 34, 33, 42,
-	 50, 49, 58, 65, 73, 74, 89,124, 17, 41, 88,  5,  6,  4, 12,  3,
-	 11,  2, 10,  1,  9,119,126,108,117,125,123,107,115,116,121,105,
-	114,122,112,113,127, 96, 97,120,  7, 15, 23, 31, 39, 47, 55, 63,
-	 71, 79, 86, 94,  8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 87,111,
-	 19, 25, 57, 81, 83, 92, 95, 98, 99,100,101,103,104,106,109,110
+          0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
+         21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
+         35, 43, 52, 51, 59, 66, 75, 76, 82, 14, 18, 93, 26, 34, 33, 42,
+         50, 49, 58, 65, 73, 74, 89,124, 17, 41, 88,  5,  6,  4, 12,  3,
+         11,  2, 10,  1,  9,119,126,108,117,125,123,107,115,116,121,105,
+        114,122,112,113,127, 96, 97,120,  7, 15, 23, 31, 39, 47, 55, 63,
+         71, 79, 86, 94,  8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 87,111,
+         19, 25, 57, 81, 83, 92, 95, 98, 99,100,101,103,104,106,109,110
 };
 
 #define ATKBD_CMD_SETLEDS	0x10ed
@@ -125,6 +118,9 @@
 #define ATKBD_RET_EMULX		0x80
 #define ATKBD_RET_EMUL1		0xe1
 #define ATKBD_RET_RELEASE	0xf0
+#define ATKBD_RET_HANGUEL	0xf1
+#define ATKBD_RET_HANJA		0xf2
+#define ATKBD_RET_ERR		0xff
 
 #define ATKBD_KEY_UNKNOWN	  0
 #define ATKBD_KEY_NULL		255
@@ -156,6 +152,17 @@
 	unsigned long time;
 };
 
+static void atkbd_report_key(struct input_dev *dev, struct pt_regs *regs, int code, int value)
+{
+	input_regs(dev, regs);
+	if (value == 3) {
+		input_report_key(dev, code, 1);
+		input_report_key(dev, code, 0);
+	} else
+		input_event(dev, EV_KEY, code, value);
+	input_sync(dev);
+}
+
 /*
  * atkbd_interrupt(). Here takes place processing of data received from
  * the keyboard into events.
@@ -184,47 +191,37 @@
 		atkbd->resend = 0;
 #endif
 
-	switch (code) {
-		case ATKBD_RET_ACK:
-			atkbd->ack = 1;
-			goto out;
-		case ATKBD_RET_NAK:
-			atkbd->ack = -1;
-			goto out;
-	}
-
-	if (atkbd->translated) do {
-
-		if (atkbd->emul != 1) {
-			if (code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1)
-				break;
-			if (code == ATKBD_RET_BAT) {
-				if (!atkbd->bat_xl)
-					break;
-				atkbd->bat_xl = 0;
-			}
-			if (code == (ATKBD_RET_BAT & 0x7f))
-				atkbd->bat_xl = 1;
-		}
-
-		if (code < 0x80) {
-			code = atkbd_unxlate_table[code];
-			break;
+	if (!atkbd->ack)
+		switch (code) {
+			case ATKBD_RET_ACK:
+				atkbd->ack = 1;
+				goto out;
+			case ATKBD_RET_NAK:
+				atkbd->ack = -1;
+				goto out;
 		}
 
-		if (atkbd->cmdcnt)
-			break;
-
-		code = atkbd_unxlate_table[code & 0x7f];
-		atkbd->release = 1;
-
-	} while (0);
-
 	if (atkbd->cmdcnt) {
 		atkbd->cmdbuf[--atkbd->cmdcnt] = code;
 		goto out;
 	}
 
+	if (atkbd->translated) {
+		
+		if (atkbd->emul || 
+		    !(code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1 ||
+		      code == ATKBD_RET_HANGUEL || code == ATKBD_RET_HANJA ||
+		      code == ATKBD_RET_ERR ||
+	             (code == ATKBD_RET_BAT && !atkbd->bat_xl))) {
+			atkbd->release = code >> 7;
+			code &= 0x7f;
+		}
+
+		if (!atkbd->emul &&
+		     (code & 0x7f) == (ATKBD_RET_BAT & 0x7f))
+			atkbd->bat_xl = !atkbd->release;
+	} 
+
 	switch (code) {
 		case ATKBD_RET_BAT:
 			serio_rescan(atkbd->serio);
@@ -238,22 +235,33 @@
 		case ATKBD_RET_RELEASE:
 			atkbd->release = 1;
 			goto out;
+		case ATKBD_RET_HANGUEL:
+			atkbd_report_key(&atkbd->dev, regs, KEY_LANG1, 3);
+			goto out;
+		case ATKBD_RET_HANJA:
+			atkbd_report_key(&atkbd->dev, regs, KEY_LANG2, 3);
+			goto out;
+		case ATKBD_RET_ERR:
+			printk(KERN_WARNING "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
+			goto out;
 	}
-
+	
+	if (atkbd->set != 3)
+		code = (code & 0x7f) | ((code & 0x80) << 1);
 	if (atkbd->emul) {
 		if (--atkbd->emul)
 			goto out;
-		code |= 0x100;
+		code |= (atkbd->set != 3) ? 0x80 : 0x100;
 	}
 
 	switch (atkbd->keycode[code]) {
 		case ATKBD_KEY_NULL:
 			break;
 		case ATKBD_KEY_UNKNOWN:
-			printk(KERN_WARNING "atkbd.c: Unknown key %s (%s set %d, code %#x, data %#x, on %s).\n",
+			printk(KERN_WARNING "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
 				atkbd->release ? "released" : "pressed",
 				atkbd->translated ? "translated" : "raw", 
-				atkbd->set, code, data, serio->phys);
+				atkbd->set, code, serio->phys);
 			break;
 		default:
 			value = atkbd->release ? 0 :
@@ -273,9 +281,7 @@
 					break;
 			}
 
-			input_regs(&atkbd->dev, regs);
-			input_event(&atkbd->dev, EV_KEY, atkbd->keycode[code], value);
-			input_sync(&atkbd->dev);
+			atkbd_report_key(&atkbd->dev, regs, atkbd->keycode[code], value);
 	}
 
 	atkbd->release = 0;
@@ -624,6 +630,7 @@
 		atkbd->dev.rep[REP_PERIOD] = 33;
 	}
 
+	atkbd->ack = 1;
 	atkbd->serio = serio;
 
 	init_input_dev(&atkbd->dev);
@@ -665,17 +672,23 @@
 			atkbd->translated ? "Translated" : "Raw", atkbd->set);
 
 	sprintf(atkbd->phys, "%s/input0", serio->phys);
-
-	if (atkbd->set == 3)
-		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
-	else
+	
+	if (atkbd->translated) {
+		for (i = 0; i < 128; i++) {
+			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
+			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
+		}
+	} else if (atkbd->set == 2) {
 		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
+	} else {
+		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
+	}
 
 	atkbd->dev.name = atkbd->name;
 	atkbd->dev.phys = atkbd->phys;
 	atkbd->dev.id.bustype = BUS_I8042;
 	atkbd->dev.id.vendor = 0x0001;
-	atkbd->dev.id.product = atkbd->set;
+	atkbd->dev.id.product = atkbd->translated ? 1 : atkbd->set;
 	atkbd->dev.id.version = atkbd->id;
 
 	for (i = 0; i < 512; i++)
@@ -686,7 +699,6 @@
 
 	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
 }
-
 
 static struct serio_dev atkbd_dev = {
 	.interrupt =	atkbd_interrupt,
diff -Nru a/include/linux/keyboard.h b/include/linux/keyboard.h
--- a/include/linux/keyboard.h	Tue Oct 28 23:16:06 2003
+++ b/include/linux/keyboard.h	Tue Oct 28 23:16:06 2003
@@ -2,7 +2,6 @@
 #define __LINUX_KEYBOARD_H
 
 #include <linux/wait.h>
-#include <linux/input.h>
 
 #define KG_SHIFT	0
 #define KG_CTRL		2
@@ -17,7 +16,7 @@
 
 #define NR_SHIFT	9
 
-#define NR_KEYS		(KEY_MAX+1)
+#define NR_KEYS		255
 #define MAX_NR_KEYMAPS	256
 /* This means 128Kb if all keymaps are allocated. Only the superuser
 	may increase the number of keymaps beyond MAX_NR_OF_USER_KEYMAPS. */

--wRRV7LY7NUeQGEoC--
