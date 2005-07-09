Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263048AbVGIAst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbVGIAst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbVGIArT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:47:19 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:52898 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263039AbVGIAoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:44:19 -0400
Message-ID: <42CF1DDA.40407@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:44:10 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/14 2.6.13-rc2-mm1] V4L I2C Infrared Remote Control
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------060909010803040601030904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060909010803040601030904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------060909010803040601030904
Content-Type: text/x-patch;
 name="v4l_i2c_ir.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_i2c_ir.diff"

- Removed unused structures.
- CodingStyle rules applied to comments.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/common/ir-common.c |  255 ++++++++++---------------
 1 files changed, 110 insertions(+), 145 deletions(-)

diff -u linux-2.6.13/drivers/media/common/ir-common.c linux/drivers/media/common/ir-common.c
--- linux-2.6.13/drivers/media/common/ir-common.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/common/ir-common.c	2005-07-07 19:57:58.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-common.c,v 1.10 2005/05/22 19:23:39 nsh Exp $
+ * $Id: ir-common.c,v 1.11 2005/07/07 14:44:43 mchehab Exp $
  *
  * some common structs and functions to handle infrared remotes via
  * input layer ...
@@ -46,79 +46,49 @@
 /* see http://users.pandora.be/nenya/electronics/rc5/codes00.htm */
 /* used by old (black) Hauppauge remotes                         */
 IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB_SIZE] = {
-	[ 0x00 ] = KEY_KP0,             // 0
-	[ 0x01 ] = KEY_KP1,             // 1
-	[ 0x02 ] = KEY_KP2,             // 2
-	[ 0x03 ] = KEY_KP3,             // 3
-	[ 0x04 ] = KEY_KP4,             // 4
-	[ 0x05 ] = KEY_KP5,             // 5
-	[ 0x06 ] = KEY_KP6,             // 6
-	[ 0x07 ] = KEY_KP7,             // 7
-	[ 0x08 ] = KEY_KP8,             // 8
-	[ 0x09 ] = KEY_KP9,             // 9
-
-	[ 0x0b ] = KEY_CHANNEL,         // channel / program (japan: 11)
-	[ 0x0c ] = KEY_POWER,           // standby
-	[ 0x0d ] = KEY_MUTE,            // mute / demute
-	[ 0x0f ] = KEY_TV,              // display
-	[ 0x10 ] = KEY_VOLUMEUP,        // volume +
-	[ 0x11 ] = KEY_VOLUMEDOWN,      // volume -
-	[ 0x12 ] = KEY_BRIGHTNESSUP,    // brightness +
-	[ 0x13 ] = KEY_BRIGHTNESSDOWN,  // brightness -
-	[ 0x1e ] = KEY_SEARCH,          // search +
-	[ 0x20 ] = KEY_CHANNELUP,       // channel / program +
-	[ 0x21 ] = KEY_CHANNELDOWN,     // channel / program -
-	[ 0x22 ] = KEY_CHANNEL,         // alt / channel
-	[ 0x23 ] = KEY_LANGUAGE,        // 1st / 2nd language
-	[ 0x26 ] = KEY_SLEEP,           // sleeptimer
-	[ 0x2e ] = KEY_MENU,            // 2nd controls (USA: menu)
-	[ 0x30 ] = KEY_PAUSE,           // pause
-	[ 0x32 ] = KEY_REWIND,          // rewind
-	[ 0x33 ] = KEY_GOTO,            // go to
-	[ 0x35 ] = KEY_PLAY,            // play
-	[ 0x36 ] = KEY_STOP,            // stop
-	[ 0x37 ] = KEY_RECORD,          // recording
-	[ 0x3c ] = KEY_TEXT,            // teletext submode (Japan: 12)
-	[ 0x3d ] = KEY_SUSPEND,         // system standby
-
-#if 0 /* FIXME */
-	[ 0x0a ] = KEY_RESERVED,        // 1/2/3 digits (japan: 10)
-	[ 0x0e ] = KEY_RESERVED,        // P.P. (personal preference)
-	[ 0x14 ] = KEY_RESERVED,        // colour saturation +
-	[ 0x15 ] = KEY_RESERVED,        // colour saturation -
-	[ 0x16 ] = KEY_RESERVED,        // bass +
-	[ 0x17 ] = KEY_RESERVED,        // bass -
-	[ 0x18 ] = KEY_RESERVED,        // treble +
-	[ 0x19 ] = KEY_RESERVED,        // treble -
-	[ 0x1a ] = KEY_RESERVED,        // balance right
-	[ 0x1b ] = KEY_RESERVED,        // balance left
-	[ 0x1c ] = KEY_RESERVED,        // contrast +
-	[ 0x1d ] = KEY_RESERVED,        // contrast -
-	[ 0x1f ] = KEY_RESERVED,        // tint/hue +
-	[ 0x24 ] = KEY_RESERVED,        // spacial stereo on/off
-	[ 0x25 ] = KEY_RESERVED,        // mono / stereo (USA)
-	[ 0x27 ] = KEY_RESERVED,        // tint / hue -
-	[ 0x28 ] = KEY_RESERVED,        // RF switch/PIP select
-	[ 0x29 ] = KEY_RESERVED,        // vote
-	[ 0x2a ] = KEY_RESERVED,        // timed page/channel clck
-	[ 0x2b ] = KEY_RESERVED,        // increment (USA)
-	[ 0x2c ] = KEY_RESERVED,        // decrement (USA)
-	[ 0x2d ] = KEY_RESERVED,        //
-	[ 0x2f ] = KEY_RESERVED,        // PIP shift
-	[ 0x31 ] = KEY_RESERVED,        // erase
-	[ 0x34 ] = KEY_RESERVED,        // wind
-	[ 0x38 ] = KEY_RESERVED,        // external 1
-	[ 0x39 ] = KEY_RESERVED,        // external 2
-	[ 0x3a ] = KEY_RESERVED,        // PIP display mode
-	[ 0x3b ] = KEY_RESERVED,        // view data mode / advance
-	[ 0x3e ] = KEY_RESERVED,        // crispener on/off
-	[ 0x3f ] = KEY_RESERVED,        // system select
-#endif
+	/* Keys 0 to 9 */
+	[ 0x00 ] = KEY_KP0,
+	[ 0x01 ] = KEY_KP1,
+	[ 0x02 ] = KEY_KP2,
+	[ 0x03 ] = KEY_KP3,
+	[ 0x04 ] = KEY_KP4,
+	[ 0x05 ] = KEY_KP5,
+	[ 0x06 ] = KEY_KP6,
+	[ 0x07 ] = KEY_KP7,
+	[ 0x08 ] = KEY_KP8,
+	[ 0x09 ] = KEY_KP9,
+
+	[ 0x0b ] = KEY_CHANNEL,		/* channel / program (japan: 11) */
+	[ 0x0c ] = KEY_POWER,		/* standby */
+	[ 0x0d ] = KEY_MUTE,		/* mute / demute */
+	[ 0x0f ] = KEY_TV,		/* display */
+	[ 0x10 ] = KEY_VOLUMEUP,
+	[ 0x11 ] = KEY_VOLUMEDOWN,
+	[ 0x12 ] = KEY_BRIGHTNESSUP,
+	[ 0x13 ] = KEY_BRIGHTNESSDOWN,
+	[ 0x1e ] = KEY_SEARCH,		/* search + */
+	[ 0x20 ] = KEY_CHANNELUP,	/* channel / program + */
+	[ 0x21 ] = KEY_CHANNELDOWN,	/* channel / program - */
+	[ 0x22 ] = KEY_CHANNEL,		/* alt / channel */
+	[ 0x23 ] = KEY_LANGUAGE,	/* 1st / 2nd language */
+	[ 0x26 ] = KEY_SLEEP,		/* sleeptimer */
+	[ 0x2e ] = KEY_MENU,		/* 2nd controls (USA: menu) */
+	[ 0x30 ] = KEY_PAUSE,
+	[ 0x32 ] = KEY_REWIND,
+	[ 0x33 ] = KEY_GOTO,
+	[ 0x35 ] = KEY_PLAY,
+	[ 0x36 ] = KEY_STOP,
+	[ 0x37 ] = KEY_RECORD,		/* recording */
+	[ 0x3c ] = KEY_TEXT,    	/* teletext submode (Japan: 12) */
+	[ 0x3d ] = KEY_SUSPEND,		/* system standby */
+
 };
 EXPORT_SYMBOL_GPL(ir_codes_rc5_tv);
 
 /* Table for Leadtek Winfast Remote Controls - used by both bttv and cx88 */
 IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTAB_SIZE] = {
+	/* Keys 0 to 9 */
+	[ 18 ] = KEY_KP0,
 	[  5 ] = KEY_KP1,
 	[  6 ] = KEY_KP2,
 	[  7 ] = KEY_KP3,
@@ -128,39 +98,31 @@
 	[ 13 ] = KEY_KP7,
 	[ 14 ] = KEY_KP8,
 	[ 15 ] = KEY_KP9,
-	[ 18 ] = KEY_KP0,
 
 	[  0 ] = KEY_POWER,
-//      [ 27 ] = MTS button
-	[  2 ] = KEY_TUNER,     // TV/FM
+	[  2 ] = KEY_TUNER,		/* TV/FM */
 	[ 30 ] = KEY_VIDEO,
-//      [ 22 ] = display button
 	[  4 ] = KEY_VOLUMEUP,
 	[  8 ] = KEY_VOLUMEDOWN,
 	[ 12 ] = KEY_CHANNELUP,
 	[ 16 ] = KEY_CHANNELDOWN,
-	[  3 ] = KEY_ZOOM,      // fullscreen
-	[ 31 ] = KEY_SUBTITLE,  // closed caption/teletext
+	[  3 ] = KEY_ZOOM,		/* fullscreen */
+	[ 31 ] = KEY_SUBTITLE,		/* closed caption/teletext */
 	[ 32 ] = KEY_SLEEP,
-//      [ 41 ] = boss key
 	[ 20 ] = KEY_MUTE,
 	[ 43 ] = KEY_RED,
 	[ 44 ] = KEY_GREEN,
 	[ 45 ] = KEY_YELLOW,
 	[ 46 ] = KEY_BLUE,
-	[ 24 ] = KEY_KPPLUS,    //fine tune +
-	[ 25 ] = KEY_KPMINUS,   //fine tune -
-//      [ 42 ] = picture in picture
+	[ 24 ] = KEY_KPPLUS,		/* fine tune + */
+	[ 25 ] = KEY_KPMINUS,		/* fine tune - */
         [ 33 ] = KEY_KPDOT,
 	[ 19 ] = KEY_KPENTER,
-//      [ 17 ] = recall
 	[ 34 ] = KEY_BACK,
 	[ 35 ] = KEY_PLAYPAUSE,
 	[ 36 ] = KEY_NEXT,
-//      [ 37 ] = time shifting
 	[ 38 ] = KEY_STOP,
 	[ 39 ] = KEY_RECORD
-//      [ 40 ] = snapshot
 };
 EXPORT_SYMBOL_GPL(ir_codes_winfast);
 
@@ -174,54 +136,61 @@
  * slightly different versions), shipped with cx88+ivtv cards.
  * almost rc5 coding, but some non-standard keys */
 IR_KEYTAB_TYPE ir_codes_hauppauge_new[IR_KEYTAB_SIZE] = {
-	[ 0x00 ] = KEY_KP0,             // 0
-	[ 0x01 ] = KEY_KP1,             // 1
-	[ 0x02 ] = KEY_KP2,             // 2
-	[ 0x03 ] = KEY_KP3,             // 3
-	[ 0x04 ] = KEY_KP4,             // 4
-	[ 0x05 ] = KEY_KP5,             // 5
-	[ 0x06 ] = KEY_KP6,             // 6
-	[ 0x07 ] = KEY_KP7,             // 7
-	[ 0x08 ] = KEY_KP8,             // 8
-	[ 0x09 ] = KEY_KP9,             // 9
-	[ 0x0a ] = KEY_TEXT,      	// keypad asterisk as well
-	[ 0x0b ] = KEY_RED,             // red button
-	[ 0x0c ] = KEY_RADIO,           // radio
-	[ 0x0d ] = KEY_MENU,            // menu
-	[ 0x0e ] = KEY_SUBTITLE,	// also the # key
-	[ 0x0f ] = KEY_MUTE,            // mute
-	[ 0x10 ] = KEY_VOLUMEUP,        // volume +
-	[ 0x11 ] = KEY_VOLUMEDOWN,      // volume -
-	[ 0x12 ] = KEY_PREVIOUS,        // previous channel
-	[ 0x14 ] = KEY_UP,              // up
-	[ 0x15 ] = KEY_DOWN,		// down
-	[ 0x16 ] = KEY_LEFT,		// left
-	[ 0x17 ] = KEY_RIGHT,		// right
-	[ 0x18 ] = KEY_VIDEO,		// Videos
-	[ 0x19 ] = KEY_AUDIO,		// Music
-	[ 0x1a ] = KEY_MHP,		// Pictures - presume this means "Multimedia Home Platform"- no "PICTURES" key in input.h
-	[ 0x1b ] = KEY_EPG,		// Guide
-	[ 0x1c ] = KEY_TV,		// TV
-	[ 0x1e ] = KEY_NEXTSONG,        // skip >|
-	[ 0x1f ] = KEY_EXIT,            // back/exit
-	[ 0x20 ] = KEY_CHANNELUP,       // channel / program +
-	[ 0x21 ] = KEY_CHANNELDOWN,     // channel / program -
-	[ 0x22 ] = KEY_CHANNEL,         // source (old black remote)
-	[ 0x24 ] = KEY_PREVIOUSSONG,    // replay |<
-	[ 0x25 ] = KEY_ENTER,           // OK
-	[ 0x26 ] = KEY_SLEEP,           // minimize (old black remote)
-	[ 0x29 ] = KEY_BLUE,            // blue key
-	[ 0x2e ] = KEY_GREEN,           // green button
-	[ 0x30 ] = KEY_PAUSE,           // pause
-	[ 0x32 ] = KEY_REWIND,          // backward <<
-	[ 0x34 ] = KEY_FASTFORWARD,     // forward >>
-	[ 0x35 ] = KEY_PLAY,            // play
-	[ 0x36 ] = KEY_STOP,            // stop
-	[ 0x37 ] = KEY_RECORD,          // recording
-	[ 0x38 ] = KEY_YELLOW,          // yellow key
-	[ 0x3b ] = KEY_SELECT,          // top right button
-	[ 0x3c ] = KEY_ZOOM,            // full
-	[ 0x3d ] = KEY_POWER,           // system power (green button)
+	/* Keys 0 to 9 */
+	[ 0x00 ] = KEY_KP0,
+	[ 0x01 ] = KEY_KP1,
+	[ 0x02 ] = KEY_KP2,
+	[ 0x03 ] = KEY_KP3,
+	[ 0x04 ] = KEY_KP4,
+	[ 0x05 ] = KEY_KP5,
+	[ 0x06 ] = KEY_KP6,
+	[ 0x07 ] = KEY_KP7,
+	[ 0x08 ] = KEY_KP8,
+	[ 0x09 ] = KEY_KP9,
+
+	[ 0x0a ] = KEY_TEXT,      	/* keypad asterisk as well */
+	[ 0x0b ] = KEY_RED,		/* red button */
+	[ 0x0c ] = KEY_RADIO,
+	[ 0x0d ] = KEY_MENU,
+	[ 0x0e ] = KEY_SUBTITLE,	/* also the # key */
+	[ 0x0f ] = KEY_MUTE,
+	[ 0x10 ] = KEY_VOLUMEUP,
+	[ 0x11 ] = KEY_VOLUMEDOWN,
+	[ 0x12 ] = KEY_PREVIOUS,	/* previous channel */
+	[ 0x14 ] = KEY_UP,
+	[ 0x15 ] = KEY_DOWN,
+	[ 0x16 ] = KEY_LEFT,
+	[ 0x17 ] = KEY_RIGHT,
+	[ 0x18 ] = KEY_VIDEO,		/* Videos */
+	[ 0x19 ] = KEY_AUDIO,		/* Music */
+	/* 0x1a: Pictures - presume this means
+	   "Multimedia Home Platform" -
+	   no "PICTURES" key in input.h
+	 */
+	[ 0x1a ] = KEY_MHP,
+
+	[ 0x1b ] = KEY_EPG,		/* Guide */
+	[ 0x1c ] = KEY_TV,
+	[ 0x1e ] = KEY_NEXTSONG,	/* skip >| */
+	[ 0x1f ] = KEY_EXIT,		/* back/exit */
+	[ 0x20 ] = KEY_CHANNELUP,	/* channel / program + */
+	[ 0x21 ] = KEY_CHANNELDOWN,	/* channel / program - */
+	[ 0x22 ] = KEY_CHANNEL,		/* source (old black remote) */
+	[ 0x24 ] = KEY_PREVIOUSSONG,	/* replay |< */
+	[ 0x25 ] = KEY_ENTER,		/* OK */
+	[ 0x26 ] = KEY_SLEEP,		/* minimize (old black remote) */
+	[ 0x29 ] = KEY_BLUE,		/* blue key */
+	[ 0x2e ] = KEY_GREEN,		/* green button */
+	[ 0x30 ] = KEY_PAUSE,		/* pause */
+	[ 0x32 ] = KEY_REWIND,		/* backward << */
+	[ 0x34 ] = KEY_FASTFORWARD,	/* forward >> */
+	[ 0x35 ] = KEY_PLAY,
+	[ 0x36 ] = KEY_STOP,
+	[ 0x37 ] = KEY_RECORD,		/* recording */
+	[ 0x38 ] = KEY_YELLOW,		/* yellow key */
+	[ 0x3b ] = KEY_SELECT,		/* top right button */
+	[ 0x3c ] = KEY_ZOOM,		/* full */
+	[ 0x3d ] = KEY_POWER,		/* system power (green button) */
 };
 EXPORT_SYMBOL(ir_codes_hauppauge_new);
 
@@ -237,9 +206,9 @@
 	[ 10 ] = KEY_KP8,
 	[ 18 ] = KEY_KP9,
 
-	[  3 ] = KEY_TUNER,       // TV/FM
-	[  7 ] = KEY_SEARCH,      // scan
-	[ 28 ] = KEY_ZOOM,        // full screen
+	[  3 ] = KEY_TUNER,		/* TV/FM */
+	[  7 ] = KEY_SEARCH,		/* scan */
+	[ 28 ] = KEY_ZOOM,		/* full screen */
 	[ 30 ] = KEY_POWER,
 	[ 23 ] = KEY_VOLUMEDOWN,
 	[ 31 ] = KEY_VOLUMEUP,
@@ -247,14 +216,14 @@
 	[ 22 ] = KEY_CHANNELUP,
 	[ 24 ] = KEY_MUTE,
 
-	[  0 ] = KEY_LIST,        // source
-	[ 19 ] = KEY_INFO,        // loop
-	[ 16 ] = KEY_LAST,        // +100
-	[ 13 ] = KEY_CLEAR,       // reset
-	[ 12 ] = BTN_RIGHT,       // fun++
-	[  4 ] = BTN_LEFT,        // fun--
-	[ 14 ] = KEY_GOTO,        // function
-	[ 15 ] = KEY_STOP,         // freeze
+	[  0 ] = KEY_LIST,		/* source */
+	[ 19 ] = KEY_INFO,		/* loop */
+	[ 16 ] = KEY_LAST,		/* +100 */
+	[ 13 ] = KEY_CLEAR,		/* reset */
+	[ 12 ] = BTN_RIGHT,		/* fun++ */
+	[  4 ] = BTN_LEFT,		/* fun-- */
+	[ 14 ] = KEY_GOTO,		/* function */
+	[ 15 ] = KEY_STOP,		/* freeze */
 };
 EXPORT_SYMBOL(ir_codes_pixelview);
 
@@ -321,10 +290,6 @@
 		ir->keypressed = 1;
 		ir_input_key_event(dev,ir);
 	}
-#if 0
-	/* maybe do something like this ??? */
-	input_event(a, EV_IR, ir->ir_type, ir->ir_raw);
-#endif
 }
 
 /* -------------------------------------------------------------------------- */

--------------060909010803040601030904--
