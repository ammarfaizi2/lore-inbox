Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSJHIEc>; Tue, 8 Oct 2002 04:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSJHIEc>; Tue, 8 Oct 2002 04:04:32 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:44940 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261619AbSJHIEX>;
	Tue, 8 Oct 2002 04:04:23 -0400
Date: Tue, 8 Oct 2002 10:09:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Krishnakumar B <kitty@cse.wustl.edu>
Cc: Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
Subject: Keyboard problems with Linux-2.5.40
Message-ID: <20021008100941.B4412@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am using a MS Natural Pro Keyboard with a PS/2 adapter (if I use it as
> a USB keyboard I am not able to use it to select the kernel to load i.e
> use the keyboard before the kernel is loaded, anybody know how to get
> around this ? )

You need to enable 'USB Legacy keyboard support: Boot' or similar option
in your BIOS configuration.

> I get the following in my kernel logs when I press XF86AudioMedia or
> XF86Refresh. And the window manager doesn't do anything i.e it doesn't
> start XMMS or reload the page under the browser
> 
> atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) pressed.

> Also when I press XF86AudioLowerVolume, I get the same behaviour as
> XF86HomePage i.e another instance of the browser is started. All other
> keys work fine.
> 
> Can someone help me with this annoying problem ? Is there any package
> that I should upgrade ? Have the keycodes for this keyboard changed
> with the new kernel or have I miscompiled the kernel ? None of these
> problems occur with Linux-2.4.19.

Patch:

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Tue Oct  8 10:08:56 2002
+++ b/drivers/char/keyboard.c	Tue Oct  8 10:08:56 2002
@@ -917,14 +917,14 @@
 	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
 	 80, 81, 82, 83, 43, 85, 86, 87, 88,115,119,120,121,375,123, 90,
 	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
-	367,294,293,286,350, 92,334,512,116,377,109,111,373,347,348,349,
-	360, 93, 94, 95, 98,376,100,101,357,316,354,304,289,102,351,355,
-	103,104,105,275,281,272,306,106,274,107,288,364,358,363,362,361,
-	291,108,381,290,287,292,279,305,280, 99,112,257,258,113,270,114,
+	367,288,302,304,350, 92,334,512,116,377,109,111,373,347,348,349,
+	360, 93, 94, 95, 98,376,100,101,321,316,354,286,289,102,351,355,
+	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
+	291,108,381,281,290,272,292,305,280, 99,112,257,258,359,270,114,
 	118,117,125,374,379,115,112,125,121,123,264,265,266,267,268,269,
-	271,273,276,277,278,282,283,295,296,297,299,300,301,302,303,307,
-	308,310,313,314,315,317,318,319,320,321,322,323,324,325,326,330,
-	332,340,341,342,343,344,345,346,356,359,365,368,369,370,371,372 };
+	271,273,276,277,278,282,283,295,296,297,299,300,301,293,303,307,
+	308,310,313,314,315,317,318,319,320,357,322,323,324,325,326,330,
+	332,340,365,342,343,344,345,346,356,113,341,368,369,370,371,372 };
 
 #ifdef CONFIG_MAC_EMUMOUSEBTN
 extern int mac_hid_mouse_emulate_buttons(int, int, int);
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Oct  8 10:08:56 2002
+++ b/drivers/input/keyboard/atkbd.c	Tue Oct  8 10:08:56 2002
@@ -55,11 +55,11 @@
 	252,253,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	254,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,
 	  0,  0, 92, 90, 85,  0,137,  0,  0,  0,  0, 91, 89,144,115,  0,
-	136,100,255,  0, 97,149,164,  0,156,  0,  0,140,115,  0,  0,125,
-	  0,150,  0,154,152,163,151,126,112,166,  0,140,  0,147,  0,127,
-	159,167,139,160,163,  0,  0,116,158,  0,150,165,  0,  0,  0,142,
-	157,  0,114,166,168,  0,  0,  0,155,  0, 98,113,  0,148,  0,138,
-	  0,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
+	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,  0,125,
+	173,114,  0,113,152,163,151,126,128,166,  0,140,  0,147,  0,127,
+	159,167,115,160,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
+	157,  0,114,166,168,  0,  0,  0,155,  0, 98,113,  0,163,  0,138,
+	226,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
 	133,  0,116,  0,143,  0,174,133,  0,107,  0,105,102,  0,  0,112,
 	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119
 };
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Oct  8 10:08:56 2002
+++ b/include/linux/input.h	Tue Oct  8 10:08:56 2002
@@ -332,6 +332,7 @@
 #define KEY_CANCEL		223
 #define KEY_BRIGHTNESSDOWN	224
 #define KEY_BRIGHTNESSUP	225
+#define KEY_MEDIA		226
 
 #define KEY_UNKNOWN		240
 

===================================================================
