Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUCPOei (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUCPOcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:32:04 -0500
Received: from styx.suse.cz ([82.208.2.94]:64641 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261926AbUCPOTp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:45 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467772648@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 23/44] Use __obsolete_setup() in input drivers to warn about obsolete kernel params
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467773559@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.54.9, 2004-03-03 00:36:59-05:00, dtor_core@ameritech.net
  Input: use __obsolete_setup to document removed (renamed)
         options so users will have a clue why the options
         do not work anymore


 joystick/amijoy.c     |    2 ++
 joystick/analog.c     |    2 ++
 joystick/db9.c        |    4 ++++
 joystick/gamecon.c    |    6 ++++++
 joystick/turbografx.c |    4 ++++
 keyboard/atkbd.c      |    4 ++++
 mouse/98busmouse.c    |    2 ++
 mouse/inport.c        |    2 ++
 mouse/logibm.c        |    2 ++
 mouse/psmouse-base.c  |    6 ++++++
 serio/i8042.c         |    7 +++++++
 11 files changed, 41 insertions(+)

===================================================================

diff -Nru a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
--- a/drivers/input/joystick/amijoy.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/joystick/amijoy.c	Tue Mar 16 13:18:41 2004
@@ -50,6 +50,8 @@
 module_param_array_named(map, amijoy, uint, amijoy_nargs, 0);
 MODULE_PARM_DESC(map, "Map of attached joysticks in form of <a>,<b> (default is 0,1)");
 
+__obsolete_setup("amijoy=");
+
 static int amijoy_used[2] = { 0, 0 };
 static struct input_dev amijoy_dev[2];
 static char *amijoy_phys[2] = { "amijoy/input0", "amijoy/input1" };
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/joystick/analog.c	Tue Mar 16 13:18:41 2004
@@ -56,6 +56,8 @@
 module_param_array_named(map, js, charp, js_nargs, 0);
 MODULE_PARM_DESC(map, "Describes analog joysticks type/capabilities");
 
+__obsolete_setup("js=");
+
 /*
  * Times, feature definitions.
  */
diff -Nru a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
--- a/drivers/input/joystick/db9.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/joystick/db9.c	Tue Mar 16 13:18:41 2004
@@ -58,6 +58,10 @@
 module_param_array_named(dev3, db9_3, int, db9_nargs_3, 0);
 MODULE_PARM_DESC(dev3, "Describes third attached device (<parport#>,<type>)");
 
+__obsolete_setup("db9=");
+__obsolete_setup("db9_2=");
+__obsolete_setup("db9_3=");
+
 #define DB9_MULTI_STICK		0x01
 #define DB9_MULTI2_STICK	0x02
 #define DB9_GENESIS_PAD		0x03
diff -Nru a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
--- a/drivers/input/joystick/gamecon.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/joystick/gamecon.c	Tue Mar 16 13:18:41 2004
@@ -59,6 +59,10 @@
 module_param_array_named(map3, gc_3, int, gc_nargs_3, 0);
 MODULE_PARM_DESC(map3, "Describers third set of devices");
 
+__obsolete_setup("gc=");
+__obsolete_setup("gc_2=");
+__obsolete_setup("gc_3=");
+
 /* see also gs_psx_delay parameter in PSX support section */
 
 #define GC_SNES		1
@@ -243,6 +247,8 @@
 static int gc_psx_delay = GC_PSX_DELAY;
 module_param_named(psx_delay, gc_psx_delay, uint, 0);
 MODULE_PARM_DESC(psx_delay, "Delay when accessing Sony PSX controller (usecs)");
+
+__obsolete_setup("gc_psx_delay=");
 
 static short gc_psx_abs[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY, ABS_HAT0X, ABS_HAT0Y };
 static short gc_psx_btn[] = { BTN_TL, BTN_TR, BTN_TL2, BTN_TR2, BTN_A, BTN_B, BTN_X, BTN_Y,
diff -Nru a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
--- a/drivers/input/joystick/turbografx.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/joystick/turbografx.c	Tue Mar 16 13:18:41 2004
@@ -57,6 +57,10 @@
 module_param_array_named(map3, tgfx_3, int, tgfx_nargs_3, 0);
 MODULE_PARM_DESC(map3, "Describes third set of devices");
 
+__obsolete_setup("tgfx=");
+__obsolete_setup("tgfx_2=");
+__obsolete_setup("tgfx_3=");
+
 #define TGFX_REFRESH_TIME	HZ/100	/* 10 ms */
 
 #define TGFX_TRIGGER		0x08
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:18:41 2004
@@ -48,6 +48,10 @@
 module_param_named(softrepeat, atkbd_softrepeat, bool, 0);
 MODULE_PARM_DESC(softrepeat, "Use software keyboard repeat");
 
+__obsolete_setup("atkbd_set=");
+__obsolete_setup("atkbd_reset");
+__obsolete_setup("atkbd_softrepeat=");
+
 /*
  * Scancode to keycode tables. These are just the default setting, and
  * are loadable via an userland utility.
diff -Nru a/drivers/input/mouse/98busmouse.c b/drivers/input/mouse/98busmouse.c
--- a/drivers/input/mouse/98busmouse.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/mouse/98busmouse.c	Tue Mar 16 13:18:41 2004
@@ -74,6 +74,8 @@
 module_param_named(irq, pc98bm_irq, uint, 0);
 MODULE_PARM_DESC(irq, "IRQ number (13=default)");
 
+__obsolete_setup("pc98bm_irq=");
+
 static int pc98bm_used = 0;
 
 static irqreturn_t pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
diff -Nru a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
--- a/drivers/input/mouse/inport.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/mouse/inport.c	Tue Mar 16 13:18:41 2004
@@ -85,6 +85,8 @@
 module_param_named(irq, inport_irq, uint, 0);
 MODULE_PARM_DESC(irq, "IRQ number (5=default)");
 
+__obsolete_setup("inport_irq=");
+
 static int inport_used;
 
 static irqreturn_t inport_interrupt(int irq, void *dev_id, struct pt_regs *regs);
diff -Nru a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
--- a/drivers/input/mouse/logibm.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/mouse/logibm.c	Tue Mar 16 13:18:41 2004
@@ -75,6 +75,8 @@
 module_param_named(irq, logibm_irq, uint, 0);
 MODULE_PARM_DESC(irq, "IRQ number (5=default)");
 
+__obsolete_setup("logibm_irq=");
+
 static int logibm_used = 0;
 
 static irqreturn_t logibm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:18:41 2004
@@ -47,6 +47,12 @@
 module_param_named(resetafter, psmouse_resetafter, uint, 0);
 MODULE_PARM_DESC(resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");
 
+__obsolete_setup("psmouse_noext");
+__obsolete_setup("psmouse_resolution=");
+__obsolete_setup("psmouse_smartscroll=");
+__obsolete_setup("psmouse_resetafter=");
+__obsolete_setup("psmouse_rate=");
+
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
 
 /*
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Mar 16 13:18:41 2004
+++ b/drivers/input/serio/i8042.c	Tue Mar 16 13:18:41 2004
@@ -52,6 +52,13 @@
 module_param_named(dumbkbd, i8042_dumbkbd, bool, 0);
 MODULE_PARM_DESC(dumbkbd, "Pretend that controller can only read data from keyboard");
 
+__obsolete_setup("i8042_noaux");
+__obsolete_setup("i8042_nomux");
+__obsolete_setup("i8042_unlock");
+__obsolete_setup("i8042_reset");
+__obsolete_setup("i8042_direct");
+__obsolete_setup("i8042_dumbkbd");
+
 #undef DEBUG
 #include "i8042.h"
 

