Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUFRKEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUFRKEh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbUFRKEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:04:35 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:8387 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265087AbUFRKEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:04:07 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:53:49 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: IR input driver update.
Message-ID: <20040618095349.GA24604@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the ir-kbd-gpio and ir-kbd-i2c drivers.  Nothing
major, just some keytable fixes and support for more hardware.

  Gerd

diff -up linux-2.6.7/drivers/media/video/ir-kbd-gpio.c linux/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.7/drivers/media/video/ir-kbd-gpio.c	2004-06-17 10:30:27.000000000 +0200
+++ linux/drivers/media/video/ir-kbd-gpio.c	2004-06-17 13:47:59.530320398 +0200
@@ -1,3 +1,4 @@
+
 /*
  * Copyright (c) 2003 Gerd Knorr
  * Copyright (c) 2003 Pavel Machek
@@ -32,47 +33,45 @@
 /* ---------------------------------------------------------------------- */
 
 static IR_KEYTAB_TYPE ir_codes_avermedia[IR_KEYTAB_SIZE] = {
-	[ 17 ] = KEY_KP0, 
-	[ 20 ] = KEY_KP1, 
-	[ 12 ] = KEY_KP2, 
-	[ 28 ] = KEY_KP3, 
-	[ 18 ] = KEY_KP4, 
-	[ 10 ] = KEY_KP5, 
-	[ 26 ] = KEY_KP6, 
-	[ 22 ] = KEY_KP7, 
-	[ 14 ] = KEY_KP8, 
-	[ 30 ] = KEY_KP9, 
+	[ 34 ] = KEY_KP0, 
+	[ 40 ] = KEY_KP1, 
+	[ 24 ] = KEY_KP2, 
+	[ 56 ] = KEY_KP3, 
+	[ 36 ] = KEY_KP4, 
+	[ 20 ] = KEY_KP5, 
+	[ 52 ] = KEY_KP6, 
+	[ 44 ] = KEY_KP7, 
+	[ 28 ] = KEY_KP8, 
+	[ 60 ] = KEY_KP9, 
 
-	[ 24 ] = KEY_EJECTCD,     // Unmarked on my controller
+	[ 48 ] = KEY_EJECTCD,     // Unmarked on my controller
 	[  0 ] = KEY_POWER, 
-	[  9 ] = BTN_LEFT,        // DISPLAY/L
-	[ 25 ] = BTN_RIGHT,       // LOOP/R
-	[  5 ] = KEY_MUTE, 
-	[ 19 ] = KEY_RECORD, 
-	[ 11 ] = KEY_PAUSE, 
-	[ 27 ] = KEY_STOP, 
-	[ 15 ] = KEY_VOLUMEDOWN, 
-	[ 31 ] = KEY_VOLUMEUP, 
-
-	[ 16 ] = KEY_TUNER,       // TV/FM
-	[  8 ] = KEY_CD, 
-	[  4 ] = KEY_VIDEO, 
-	[  2 ] = KEY_AUDIO, 
-	[  6 ] = KEY_ZOOM,        // full screen
-	[  1 ] = KEY_INFO,        // preview 
-	[ 21 ] = KEY_SEARCH,      // autoscan
-	[ 13 ] = KEY_STOP,        // freeze 
-	[ 29 ] = KEY_RECORD,      // capture 
-	[  3 ] = KEY_PLAY,        // unmarked
-	[ 23 ] = KEY_RED,         // unmarked
-	[  7 ] = KEY_GREEN,       // unmarked
-
-#if 0
-	[ 16 ] = KEY_YELLOW,      // unmarked
-	[  8 ] = KEY_CHANNELDOWN, 
-	[ 24 ] = KEY_CHANNELUP, 
-	[  0 ] = KEY_BLUE,        // unmarked
-#endif
+	[ 18 ] = BTN_LEFT,        // DISPLAY/L
+	[ 50 ] = BTN_RIGHT,       // LOOP/R
+	[ 10 ] = KEY_MUTE, 
+	[ 38 ] = KEY_RECORD, 
+	[ 22 ] = KEY_PAUSE, 
+	[ 54 ] = KEY_STOP, 
+	[ 30 ] = KEY_VOLUMEDOWN, 
+	[ 62 ] = KEY_VOLUMEUP, 
+
+	[ 32 ] = KEY_TUNER,       // TV/FM
+	[ 16 ] = KEY_CD, 
+	[  8 ] = KEY_VIDEO, 
+	[  4 ] = KEY_AUDIO, 
+	[ 12 ] = KEY_ZOOM,        // full screen
+	[  2 ] = KEY_INFO,        // preview 
+	[ 42 ] = KEY_SEARCH,      // autoscan
+	[ 26 ] = KEY_STOP,        // freeze 
+	[ 58 ] = KEY_RECORD,      // capture 
+	[  6 ] = KEY_PLAY,        // unmarked
+	[ 46 ] = KEY_RED,         // unmarked
+	[ 14 ] = KEY_GREEN,       // unmarked
+
+	[ 33 ] = KEY_YELLOW,      // unmarked
+	[ 17 ] = KEY_CHANNELDOWN, 
+	[ 49 ] = KEY_CHANNELUP, 
+	[  1 ] = KEY_BLUE,        // unmarked
 };
 
 static IR_KEYTAB_TYPE winfast_codes[IR_KEYTAB_SIZE] = {
@@ -280,8 +279,9 @@ static int ir_probe(struct device *dev)
 	case BTTV_AVPHONE98:
 	case BTTV_AVERMEDIA98:
 		ir_codes         = ir_codes_avermedia;
-		ir->mask_keycode = 0xf80000;
+		ir->mask_keycode = 0xf88000;
 		ir->mask_keydown = 0x010000;
+		ir->polling      = 50; // ms
 		break;
 
 	case BTTV_PXELVWPLTVPAK:
@@ -300,7 +300,7 @@ static int ir_probe(struct device *dev)
 
 	case BTTV_WINFAST2000:
 		ir_codes         = winfast_codes;
-		ir->mask_keycode = 0x8f8;
+		ir->mask_keycode = 0x1f8;
 		break;
 	case BTTV_MAGICTVIEW061:
 	case BTTV_MAGICTVIEW063:
diff -up linux-2.6.7/drivers/media/video/ir-kbd-i2c.c linux/drivers/media/video/ir-kbd-i2c.c
--- linux-2.6.7/drivers/media/video/ir-kbd-i2c.c	2004-06-17 10:27:28.000000000 +0200
+++ linux/drivers/media/video/ir-kbd-i2c.c	2004-06-17 13:47:59.534319645 +0200
@@ -43,26 +43,26 @@
 
 /* Mark Phalan <phalanm@o2.ie> */
 static IR_KEYTAB_TYPE ir_codes_pv951[IR_KEYTAB_SIZE] = {
-	[  0 ] = KEY_KP0,
-	[  1 ] = KEY_KP1,
-	[  2 ] = KEY_KP2,
-	[  3 ] = KEY_KP3,
-	[  4 ] = KEY_KP4,
-	[  5 ] = KEY_KP5,
-	[  6 ] = KEY_KP6,
-	[  7 ] = KEY_KP7,
-	[  8 ] = KEY_KP8,
-	[  9 ] = KEY_KP9,
-
-	[ 18 ] = KEY_POWER,
-	[ 16 ] = KEY_MUTE,
-	[ 31 ] = KEY_VOLUMEDOWN,
-	[ 27 ] = KEY_VOLUMEUP,
+	[  0 ] = KEY_KP0, 
+	[  1 ] = KEY_KP1, 
+	[  2 ] = KEY_KP2, 
+	[  3 ] = KEY_KP3, 
+	[  4 ] = KEY_KP4, 
+	[  5 ] = KEY_KP5, 
+	[  6 ] = KEY_KP6, 
+	[  7 ] = KEY_KP7, 
+	[  8 ] = KEY_KP8, 
+	[  9 ] = KEY_KP9, 
+
+	[ 18 ] = KEY_POWER, 
+	[ 16 ] = KEY_MUTE, 
+	[ 31 ] = KEY_VOLUMEDOWN, 
+	[ 27 ] = KEY_VOLUMEUP, 
 	[ 26 ] = KEY_CHANNELUP,
 	[ 30 ] = KEY_CHANNELDOWN,
 	[ 14 ] = KEY_PAGEUP,
-	[ 29 ] = KEY_PAGEDOWN,
-	[ 19 ] = KEY_SOUND,
+	[ 29 ] = KEY_PAGEDOWN,	
+	[ 19 ] = KEY_SOUND, 
 
 	[ 24 ] = KEY_KPPLUSMINUS,	// CH +/-
 	[ 22 ] = KEY_SUBTITLE,		// CC
@@ -75,8 +75,58 @@ static IR_KEYTAB_TYPE ir_codes_pv951[IR_
 
 	/* Not sure what to do with these ones! */
 	[ 15 ] = KEY_SELECT, 		// SOURCE
-	[ 10 ] = KEY_KPPLUS,		// +100
+	[ 10 ] = KEY_KPPLUS,		// +100  
 	[ 20 ] = KEY_KPEQUAL,		// SYNC
+	[ 28 ] = KEY_MEDIA,             // PC/TV
+};
+
+static IR_KEYTAB_TYPE ir_codes_purpletv[IR_KEYTAB_SIZE] = {
+	[ 0x3  ] = KEY_POWER,
+	[ 0x6f ] = KEY_MUTE,
+	[ 0x10 ] = KEY_BACKSPACE,	// Recall
+
+	[ 0x11 ] = KEY_KP0,
+	[ 0x4  ] = KEY_KP1,
+	[ 0x5  ] = KEY_KP2,
+	[ 0x6  ] = KEY_KP3,
+	[ 0x8  ] = KEY_KP4,
+	[ 0x9  ] = KEY_KP5,
+	[ 0xa  ] = KEY_KP6,
+	[ 0xc  ] = KEY_KP7,
+	[ 0xd  ] = KEY_KP8,
+	[ 0xe  ] = KEY_KP9,
+	[ 0x12 ] = KEY_KPDOT,		// 100+
+
+	[ 0x7  ] = KEY_VOLUMEUP,
+	[ 0xb  ] = KEY_VOLUMEDOWN,
+	[ 0x1a ] = KEY_KPPLUS,
+	[ 0x18 ] = KEY_KPMINUS,
+	[ 0x15 ] = KEY_UP,
+	[ 0x1d ] = KEY_DOWN,
+	[ 0xf  ] = KEY_CHANNELUP,
+	[ 0x13 ] = KEY_CHANNELDOWN,
+	[ 0x48 ] = KEY_ZOOM,
+
+	[ 0x1b ] = KEY_VIDEO,		// Video source
+#if 0
+	[ 0x1f ] = KEY_S,       	// Snapshot
+#endif
+	[ 0x49 ] = KEY_LANGUAGE,	// MTS Select
+	[ 0x19 ] = KEY_SEARCH,		// Auto Scan
+
+	[ 0x4b ] = KEY_RECORD,    
+	[ 0x46 ] = KEY_PLAY,    
+	[ 0x45 ] = KEY_PAUSE,   	// Pause
+	[ 0x44 ] = KEY_STOP,
+#if 0
+	[ 0x43 ] = KEY_T,    		// Time Shift
+	[ 0x47 ] = KEY_Y,    		// Time Shift OFF
+	[ 0x4a ] = KEY_O,    		// TOP
+	[ 0x17 ] = KEY_F,    		// SURF CH
+#endif
+	[ 0x40 ] = KEY_FORWARD,   	// Forward ?
+	[ 0x42 ] = KEY_REWIND,   	// Backward ?
+
 };
 
 struct IR;
@@ -202,11 +252,33 @@ static int get_key_knc1(struct IR *ir, u
 	return 1;
 }
 
+static int get_key_purpletv(struct IR *ir, u32 *ir_key, u32 *ir_raw)
+{
+        unsigned char b;
+	
+	/* poll IR chip */
+	if (1 != i2c_master_recv(&ir->c,&b,1)) {
+		dprintk(1,"read error\n");
+		return -EIO;
+	}
+
+	/* no button press */
+	if (b==0)
+		return 0;
+
+	/* repeating */
+	if (b & 0x80) 
+		return 1;
+
+	*ir_key = b;
+	*ir_raw = b;
+	return 1;
+}
 /* ----------------------------------------------------------------------- */
 
 static void ir_key_poll(struct IR *ir)
 {
-	u32 ir_key, ir_raw;
+	static u32 ir_key, ir_raw;
 	int rc;
 
 	dprintk(2,"ir_poll_key\n");
@@ -300,6 +372,12 @@ static int ir_attach(struct i2c_adapter 
 		ir_type     = IR_TYPE_OTHER;
 		ir_codes    = ir_codes_empty;
 		break;
+	case 0x7a:
+		name        = "Purple TV";
+		ir->get_key = get_key_purpletv;
+		ir_type     = IR_TYPE_OTHER;
+		ir_codes    = ir_codes_purpletv;
+		break;
 	default:
 		/* shouldn't happen */
 		printk(DEVNAME ": Huh? unknown i2c address (0x%02x)?\n",addr);
@@ -320,7 +398,8 @@ static int ir_attach(struct i2c_adapter 
 	ir->input.name       = ir->c.name;
 	ir->input.phys       = ir->phys;
 	input_register_device(&ir->input);
-	printk(DEVNAME ": %s detected at %s\n",ir->input.name,ir->input.phys);
+	printk(DEVNAME ": %s detected at %s [%s]\n",
+	       ir->input.name,ir->input.phys,adap->name);
 	       
 	/* start polling via eventd */
 	INIT_WORK(&ir->work, ir_work, ir);
@@ -361,22 +440,33 @@ static int ir_probe(struct i2c_adapter *
 	   That's why we probe 0x1a (~0x34) first. CB 
 	*/
 	
-	static const int probe[] = { 0x1a, 0x18, 0x4b, 0x64, 0x30, -1};
+	static const int probe_bttv[] = { 0x1a, 0x18, 0x4b, 0x64, 0x30, -1};
+	static const int probe_saa7134[] = { 0x7a, -1};
+	const int *probe = NULL;
 	struct i2c_client c; char buf; int i,rc;
 
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848)) {
-		memset(&c,0,sizeof(c));
-		c.adapter = adap;
-		for (i = 0; -1 != probe[i]; i++) {
-			c.addr = probe[i];
-			rc = i2c_master_recv(&c,&buf,1);
-			dprintk(1,"probe 0x%02x @ %s: %s\n",
-				probe[i], adap->name, 
-				(1 == rc) ? "yes" : "no");
-			if (1 == rc) {
-				ir_attach(adap,probe[i],0,0);
-				break;
-			}
+	switch (adap->id) {
+	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+		probe = probe_bttv;
+		break;
+	case I2C_ALGO_SAA7134:
+		probe = probe_saa7134;
+		break;
+	}
+	if (NULL == probe)
+		return 0;
+	
+	memset(&c,0,sizeof(c));
+	c.adapter = adap;
+	for (i = 0; -1 != probe[i]; i++) {
+		c.addr = probe[i];
+		rc = i2c_master_recv(&c,&buf,1);
+		dprintk(1,"probe 0x%02x @ %s: %s\n",
+			probe[i], adap->name, 
+			(1 == rc) ? "yes" : "no");
+		if (1 == rc) {
+			ir_attach(adap,probe[i],0,0);
+			break;
 		}
 	}
 	return 0;

-- 
Smoking Crack Organization
