Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbUKGDOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUKGDOn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 22:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUKGDOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 22:14:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54792 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261526AbUKGDNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 22:13:32 -0500
Date: Sun, 7 Nov 2004 04:12:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] small input cleanup
Message-ID: <20041107031256.GD14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups under drivers/input/ :
- make some needlessly global code static
- remove the completely unused EXPORT_SYMBOL'ed function gameport_rescan
- make the EXPORT_SYMBOL'ed function ps2_sendbyte static since it isn't
  used outside the file where it's defined

Please review this patch.

In case in-kernel users for the EXPORT_SYMBOL's I've removed are coming 
soon, simply drop the corresponding parts of the patch.


diffstat output:
 drivers/input/evbug.c               |    4 ++--
 drivers/input/gameport/emu10k1-gp.c |    4 ++--
 drivers/input/gameport/fm801-gp.c   |    4 ++--
 drivers/input/gameport/gameport.c   |    7 -------
 drivers/input/gameport/lightning.c  |    4 ++--
 drivers/input/gameport/ns558.c      |    4 ++--
 drivers/input/gameport/vortex.c     |    4 ++--
 drivers/input/input.c               |    2 +-
 drivers/input/joystick/a3d.c        |   10 +++++-----
 drivers/input/joystick/adi.c        |    4 ++--
 drivers/input/joystick/analog.c     |    6 +++---
 drivers/input/joystick/cobra.c      |    4 ++--
 drivers/input/joystick/db9.c        |    4 ++--
 drivers/input/joystick/gamecon.c    |    4 ++--
 drivers/input/joystick/gf2k.c       |    4 ++--
 drivers/input/joystick/grip.c       |    4 ++--
 drivers/input/joystick/guillemot.c  |    4 ++--
 drivers/input/joystick/interact.c   |    4 ++--
 drivers/input/joystick/magellan.c   |    4 ++--
 drivers/input/joystick/sidewinder.c |    4 ++--
 drivers/input/joystick/spaceball.c  |    4 ++--
 drivers/input/joystick/spaceorb.c   |    4 ++--
 drivers/input/joystick/stinger.c    |    4 ++--
 drivers/input/joystick/tmdc.c       |    4 ++--
 drivers/input/joystick/turbografx.c |    6 +++---
 drivers/input/joystick/warrior.c    |    4 ++--
 drivers/input/keyboard/atkbd.c      |    4 ++--
 drivers/input/keyboard/lkkbd.c      |    4 ++--
 drivers/input/keyboard/newtonkbd.c  |   12 ++++++------
 drivers/input/keyboard/sunkbd.c     |    4 ++--
 drivers/input/keyboard/xtkbd.c      |   12 ++++++------
 drivers/input/misc/pcspkr.c         |    2 +-
 drivers/input/misc/uinput.c         |    2 +-
 drivers/input/mouse/alps.c          |    4 ++--
 drivers/input/mouse/psmouse-base.c  |    4 ++--
 drivers/input/mouse/sermouse.c      |    4 ++--
 drivers/input/mouse/vsxxxaa.c       |    4 ++--
 drivers/input/mousedev.c            |    2 +-
 drivers/input/serio/ct82c710.c      |    4 ++--
 drivers/input/serio/i8042.c         |   10 +++++-----
 drivers/input/serio/libps2.c        |    3 +--
 drivers/input/serio/parkbd.c        |    4 ++--
 drivers/input/serio/serio.c         |    2 +-
 drivers/input/serio/serio_raw.c     |    6 +++---
 drivers/input/touchscreen/gunze.c   |    4 ++--
 drivers/input/tsdev.c               |    2 +-
 include/linux/gameport.h            |    1 -
 include/linux/libps2.h              |    1 -
 48 files changed, 100 insertions(+), 110 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/input/evbug.c.old	2004-11-07 03:34:41.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/evbug.c	2004-11-07 03:35:01.000000000 +0100
@@ -88,13 +88,13 @@
 	.id_table =	evbug_ids,
 };
 
-int __init evbug_init(void)
+static int __init evbug_init(void)
 {
 	input_register_handler(&evbug_handler);
 	return 0;
 }
 
-void __exit evbug_exit(void)
+static void __exit evbug_exit(void)
 {
 	input_unregister_handler(&evbug_handler);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/gameport/emu10k1-gp.c.old	2004-11-07 03:35:11.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/gameport/emu10k1-gp.c	2004-11-07 03:35:23.000000000 +0100
@@ -118,12 +118,12 @@
         .remove =       __devexit_p(emu_remove),
 };
 
-int __init emu_init(void)
+static int __init emu_init(void)
 {
 	return pci_module_init(&emu_driver);
 }
 
-void __exit emu_exit(void)
+static void __exit emu_exit(void)
 {
 	pci_unregister_driver(&emu_driver);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/gameport/fm801-gp.c.old	2004-11-07 03:35:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/gameport/fm801-gp.c	2004-11-07 03:36:05.000000000 +0100
@@ -143,12 +143,12 @@
 	.remove =	__devexit_p(fm801_gp_remove),
 };
 
-int __init fm801_gp_init(void)
+static int __init fm801_gp_init(void)
 {
 	return pci_module_init(&fm801_gp_driver);
 }
 
-void __exit fm801_gp_exit(void)
+static void __exit fm801_gp_exit(void)
 {
 	pci_unregister_driver(&fm801_gp_driver);
 }
--- linux-2.6.10-rc1-mm3-full/include/linux/gameport.h.old	2004-11-07 03:36:50.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/linux/gameport.h	2004-11-07 03:36:59.000000000 +0100
@@ -53,7 +53,6 @@
 
 int gameport_open(struct gameport *gameport, struct gameport_dev *dev, int mode);
 void gameport_close(struct gameport *gameport);
-void gameport_rescan(struct gameport *gameport);
 
 #if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
 void gameport_register_port(struct gameport *gameport);
--- linux-2.6.10-rc1-mm3-full/drivers/input/gameport/gameport.c.old	2004-11-07 03:37:08.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/gameport/gameport.c	2004-11-07 03:37:18.000000000 +0100
@@ -29,7 +29,6 @@
 EXPORT_SYMBOL(gameport_unregister_device);
 EXPORT_SYMBOL(gameport_open);
 EXPORT_SYMBOL(gameport_close);
-EXPORT_SYMBOL(gameport_rescan);
 EXPORT_SYMBOL(gameport_cooked_read);
 
 static LIST_HEAD(gameport_list);
@@ -112,12 +111,6 @@
         }
 }
 
-void gameport_rescan(struct gameport *gameport)
-{
-	gameport_close(gameport);
-	gameport_find_dev(gameport);
-}
-
 void gameport_register_port(struct gameport *gameport)
 {
 	list_add_tail(&gameport->node, &gameport_list);
--- linux-2.6.10-rc1-mm3-full/drivers/input/gameport/lightning.c.old	2004-11-07 03:37:40.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/gameport/lightning.c	2004-11-07 03:37:56.000000000 +0100
@@ -53,13 +53,13 @@
 MODULE_DESCRIPTION("PDPI Lightning 4 gamecard driver");
 MODULE_LICENSE("GPL");
 
-struct l4 {
+static struct l4 {
 	struct gameport gameport;
 	unsigned char port;
 	char phys[32];
 } *l4_port[8];
 
-char l4_name[] = "PDPI Lightning 4";
+static char l4_name[] = "PDPI Lightning 4";
 
 /*
  * l4_wait_ready() waits for the L4 to become ready.
--- linux-2.6.10-rc1-mm3-full/drivers/input/gameport/ns558.c.old	2004-11-07 03:38:06.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/gameport/ns558.c	2004-11-07 03:38:23.000000000 +0100
@@ -261,7 +261,7 @@
 
 #endif
 
-int __init ns558_init(void)
+static int __init ns558_init(void)
 {
 	int i = 0;
 
@@ -276,7 +276,7 @@
 	return list_empty(&ns558_list) ? -ENODEV : 0;
 }
 
-void __exit ns558_exit(void)
+static void __exit ns558_exit(void)
 {
 	struct ns558 *port;
 
--- linux-2.6.10-rc1-mm3-full/drivers/input/gameport/vortex.c.old	2004-11-07 03:38:32.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/gameport/vortex.c	2004-11-07 03:38:45.000000000 +0100
@@ -172,12 +172,12 @@
 	.remove =	__devexit_p(vortex_remove),
 };
 
-int __init vortex_init(void)
+static int __init vortex_init(void)
 {
 	return pci_module_init(&vortex_driver);
 }
 
-void __exit vortex_exit(void)
+static void __exit vortex_exit(void)
 {
 	pci_unregister_driver(&vortex_driver);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/input.c.old	2004-11-07 03:39:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/input.c	2004-11-07 03:39:11.000000000 +0100
@@ -50,7 +50,7 @@
 
 #ifdef CONFIG_PROC_FS
 static struct proc_dir_entry *proc_bus_input_dir;
-DECLARE_WAIT_QUEUE_HEAD(input_devices_poll_wait);
+static DECLARE_WAIT_QUEUE_HEAD(input_devices_poll_wait);
 static int input_devices_state;
 #endif
 
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/a3d.c.old	2004-11-07 03:39:37.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/a3d.c	2004-11-07 03:40:22.000000000 +0100
@@ -50,7 +50,7 @@
 #define A3D_MODE_OEM		3	/* Panther OEM version */
 #define A3D_MODE_PXL		4	/* Panther XL */
 
-char *a3d_names[] = { NULL, "FP-Gaming Assassin 3D", "MadCatz Panther", "OEM Panther",
+static char *a3d_names[] = { NULL, "FP-Gaming Assassin 3D", "MadCatz Panther", "OEM Panther",
 			"MadCatz Panther XL", "MadCatz Panther XL w/ rudder" };
 
 struct a3d {
@@ -195,7 +195,7 @@
  * call this more than 50 times a second, which would use too much CPU.
  */
 
-int a3d_adc_cooked_read(struct gameport *gameport, int *axes, int *buttons)
+static int a3d_adc_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
 	struct a3d *a3d = gameport->driver;
 	int i;
@@ -210,7 +210,7 @@
  * any but cooked data.
  */
 
-int a3d_adc_open(struct gameport *gameport, int mode)
+static int a3d_adc_open(struct gameport *gameport, int mode)
 {
 	struct a3d *a3d = gameport->driver;
 	if (mode != GAMEPORT_MODE_COOKED)
@@ -390,13 +390,13 @@
 	.disconnect =	a3d_disconnect,
 };
 
-int __init a3d_init(void)
+static int __init a3d_init(void)
 {
 	gameport_register_device(&a3d_dev);
 	return 0;
 }
 
-void __exit a3d_exit(void)
+static void __exit a3d_exit(void)
 {
 	gameport_unregister_device(&a3d_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/adi.c.old	2004-11-07 03:40:34.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/adi.c	2004-11-07 03:40:54.000000000 +0100
@@ -549,13 +549,13 @@
 	.disconnect =	adi_disconnect,
 };
 
-int __init adi_init(void)
+static int __init adi_init(void)
 {
 	gameport_register_device(&adi_dev);
 	return 0;
 }
 
-void __exit adi_exit(void)
+static void __exit adi_exit(void)
 {
 	gameport_unregister_device(&adi_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/analog.c.old	2004-11-07 03:41:10.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/analog.c	2004-11-07 03:41:45.000000000 +0100
@@ -696,7 +696,7 @@
 	int value;
 };
 
-struct analog_types analog_types[] = {
+static struct analog_types analog_types[] = {
 	{ "none",	0x00000000 },
 	{ "auto",	0x000000ff },
 	{ "2btn",	0x0000003f },
@@ -746,14 +746,14 @@
 	.disconnect =	analog_disconnect,
 };
 
-int __init analog_init(void)
+static int __init analog_init(void)
 {
 	analog_parse_options();
 	gameport_register_device(&analog_dev);
 	return 0;
 }
 
-void __exit analog_exit(void)
+static void __exit analog_exit(void)
 {
 	gameport_unregister_device(&analog_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/cobra.c.old	2004-11-07 03:41:56.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/cobra.c	2004-11-07 03:42:08.000000000 +0100
@@ -241,13 +241,13 @@
 	.disconnect =	cobra_disconnect,
 };
 
-int __init cobra_init(void)
+static int __init cobra_init(void)
 {
 	gameport_register_device(&cobra_dev);
 	return 0;
 }
 
-void __exit cobra_exit(void)
+static void __exit cobra_exit(void)
 {
 	gameport_unregister_device(&cobra_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/db9.c.old	2004-11-07 03:42:17.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/db9.c	2004-11-07 03:42:31.000000000 +0100
@@ -619,7 +619,7 @@
 	return db9;
 }
 
-int __init db9_init(void)
+static int __init db9_init(void)
 {
 	db9_base[0] = db9_probe(db9, db9_nargs);
 	db9_base[1] = db9_probe(db9_2, db9_nargs_2);
@@ -631,7 +631,7 @@
 	return -ENODEV;
 }
 
-void __exit db9_exit(void)
+static void __exit db9_exit(void)
 {
 	int i, j;
 
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/gamecon.c.old	2004-11-07 03:42:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/gamecon.c	2004-11-07 03:43:00.000000000 +0100
@@ -665,7 +665,7 @@
 	return gc;
 }
 
-int __init gc_init(void)
+static int __init gc_init(void)
 {
 	gc_base[0] = gc_probe(gc, gc_nargs);
 	gc_base[1] = gc_probe(gc_2, gc_nargs_2);
@@ -677,7 +677,7 @@
 	return -ENODEV;
 }
 
-void __exit gc_exit(void)
+static void __exit gc_exit(void)
 {
 	int i, j;
 
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/gf2k.c.old	2004-11-07 03:43:08.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/gf2k.c	2004-11-07 03:43:22.000000000 +0100
@@ -351,13 +351,13 @@
 	.disconnect =	gf2k_disconnect,
 };
 
-int __init gf2k_init(void)
+static int __init gf2k_init(void)
 {
 	gameport_register_device(&gf2k_dev);
 	return 0;
 }
 
-void __exit gf2k_exit(void)
+static void __exit gf2k_exit(void)
 {
 	gameport_unregister_device(&gf2k_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/grip.c.old	2004-11-07 03:43:31.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/grip.c	2004-11-07 03:43:43.000000000 +0100
@@ -414,13 +414,13 @@
 	.disconnect =	grip_disconnect,
 };
 
-int __init grip_init(void)
+static int __init grip_init(void)
 {
 	gameport_register_device(&grip_dev);
 	return 0;
 }
 
-void __exit grip_exit(void)
+static void __exit grip_exit(void)
 {
 	gameport_unregister_device(&grip_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/guillemot.c.old	2004-11-07 03:43:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/guillemot.c	2004-11-07 03:44:04.000000000 +0100
@@ -271,13 +271,13 @@
 	.disconnect =	guillemot_disconnect,
 };
 
-int __init guillemot_init(void)
+static int __init guillemot_init(void)
 {
 	gameport_register_device(&guillemot_dev);
 	return 0;
 }
 
-void __exit guillemot_exit(void)
+static void __exit guillemot_exit(void)
 {
 	gameport_unregister_device(&guillemot_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/interact.c.old	2004-11-07 03:44:19.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/interact.c	2004-11-07 03:44:33.000000000 +0100
@@ -299,13 +299,13 @@
 	.disconnect =	interact_disconnect,
 };
 
-int __init interact_init(void)
+static int __init interact_init(void)
 {
 	gameport_register_device(&interact_dev);
 	return 0;
 }
 
-void __exit interact_exit(void)
+static void __exit interact_exit(void)
 {
 	gameport_unregister_device(&interact_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/magellan.c.old	2004-11-07 03:44:43.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/magellan.c	2004-11-07 03:44:54.000000000 +0100
@@ -216,13 +216,13 @@
  * The functions for inserting/removing us as a module.
  */
 
-int __init magellan_init(void)
+static int __init magellan_init(void)
 {
 	serio_register_driver(&magellan_drv);
 	return 0;
 }
 
-void __exit magellan_exit(void)
+static void __exit magellan_exit(void)
 {
 	serio_unregister_driver(&magellan_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/sidewinder.c.old	2004-11-07 03:45:05.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/sidewinder.c	2004-11-07 03:45:20.000000000 +0100
@@ -765,13 +765,13 @@
 	.disconnect =	sw_disconnect,
 };
 
-int __init sw_init(void)
+static int __init sw_init(void)
 {
 	gameport_register_device(&sw_dev);
 	return 0;
 }
 
-void __exit sw_exit(void)
+static void __exit sw_exit(void)
 {
 	gameport_unregister_device(&sw_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/spaceball.c.old	2004-11-07 03:45:38.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/spaceball.c	2004-11-07 03:45:55.000000000 +0100
@@ -286,13 +286,13 @@
  * The functions for inserting/removing us as a module.
  */
 
-int __init spaceball_init(void)
+static int __init spaceball_init(void)
 {
 	serio_register_driver(&spaceball_drv);
 	return 0;
 }
 
-void __exit spaceball_exit(void)
+static void __exit spaceball_exit(void)
 {
 	serio_unregister_driver(&spaceball_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/spaceorb.c.old	2004-11-07 03:46:04.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/spaceorb.c	2004-11-07 03:46:15.000000000 +0100
@@ -230,13 +230,13 @@
  * The functions for inserting/removing us as a module.
  */
 
-int __init spaceorb_init(void)
+static int __init spaceorb_init(void)
 {
 	serio_register_driver(&spaceorb_drv);
 	return 0;
 }
 
-void __exit spaceorb_exit(void)
+static void __exit spaceorb_exit(void)
 {
 	serio_unregister_driver(&spaceorb_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/stinger.c.old	2004-11-07 03:46:24.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/stinger.c	2004-11-07 03:46:38.000000000 +0100
@@ -204,13 +204,13 @@
  * The functions for inserting/removing us as a module.
  */
 
-int __init stinger_init(void)
+static int __init stinger_init(void)
 {
 	serio_register_driver(&stinger_drv);
 	return 0;
 }
 
-void __exit stinger_exit(void)
+static void __exit stinger_exit(void)
 {
 	serio_unregister_driver(&stinger_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/tmdc.c.old	2004-11-07 03:46:59.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/tmdc.c	2004-11-07 03:47:11.000000000 +0100
@@ -367,13 +367,13 @@
 	.disconnect =	tmdc_disconnect,
 };
 
-int __init tmdc_init(void)
+static int __init tmdc_init(void)
 {
 	gameport_register_device(&tmdc_dev);
 	return 0;
 }
 
-void __exit tmdc_exit(void)
+static void __exit tmdc_exit(void)
 {
 	gameport_unregister_device(&tmdc_dev);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/turbografx.c.old	2004-11-07 03:47:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/turbografx.c	2004-11-07 03:47:42.000000000 +0100
@@ -77,7 +77,7 @@
 static int tgfx_buttons[] = { BTN_TRIGGER, BTN_THUMB, BTN_THUMB2, BTN_TOP, BTN_TOP2 };
 static char *tgfx_name = "TurboGraFX Multisystem joystick";
 
-struct tgfx {
+static struct tgfx {
 	struct pardevice *pd;
 	struct timer_list timer;
 	struct input_dev dev[7];
@@ -229,7 +229,7 @@
 	return tgfx;
 }
 
-int __init tgfx_init(void)
+static int __init tgfx_init(void)
 {
 	tgfx_base[0] = tgfx_probe(tgfx, tgfx_nargs);
 	tgfx_base[1] = tgfx_probe(tgfx_2, tgfx_nargs_2);
@@ -241,7 +241,7 @@
 	return -ENODEV;
 }
 
-void __exit tgfx_exit(void)
+static void __exit tgfx_exit(void)
 {
 	int i, j;
 
--- linux-2.6.10-rc1-mm3-full/drivers/input/joystick/warrior.c.old	2004-11-07 03:47:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/joystick/warrior.c	2004-11-07 03:48:09.000000000 +0100
@@ -216,13 +216,13 @@
  * The functions for inserting/removing us as a module.
  */
 
-int __init warrior_init(void)
+static int __init warrior_init(void)
 {
 	serio_register_driver(&warrior_drv);
 	return 0;
 }
 
-void __exit warrior_exit(void)
+static void __exit warrior_exit(void)
 {
 	serio_unregister_driver(&warrior_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/atkbd.c.old	2004-11-07 03:48:25.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/atkbd.c	2004-11-07 03:48:38.000000000 +0100
@@ -1096,13 +1096,13 @@
 }
 
 
-int __init atkbd_init(void)
+static int __init atkbd_init(void)
 {
 	serio_register_driver(&atkbd_drv);
 	return 0;
 }
 
-void __exit atkbd_exit(void)
+static void __exit atkbd_exit(void)
 {
 	serio_unregister_driver(&atkbd_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/lkkbd.c.old	2004-11-07 03:48:47.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/lkkbd.c	2004-11-07 03:48:59.000000000 +0100
@@ -719,14 +719,14 @@
 /*
  * The functions for insering/removing us as a module.
  */
-int __init
+static int __init
 lkkbd_init (void)
 {
 	serio_register_driver(&lkkbd_drv);
 	return 0;
 }
 
-void __exit
+static void __exit
 lkkbd_exit (void)
 {
 	serio_unregister_driver(&lkkbd_drv);
--- linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/newtonkbd.c.old	2004-11-07 03:49:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/newtonkbd.c	2004-11-07 03:50:38.000000000 +0100
@@ -66,7 +66,7 @@
 	char phys[32];
 };
 
-irqreturn_t nkbd_interrupt(struct serio *serio,
+static irqreturn_t nkbd_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct nkbd *nkbd = serio->private;
@@ -84,7 +84,7 @@
 
 }
 
-void nkbd_connect(struct serio *serio, struct serio_driver *drv)
+static void nkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct nkbd *nkbd;
 	int i;
@@ -133,7 +133,7 @@
 	printk(KERN_INFO "input: %s on %s\n", nkbd_name, serio->phys);
 }
 
-void nkbd_disconnect(struct serio *serio)
+static void nkbd_disconnect(struct serio *serio)
 {
 	struct nkbd *nkbd = serio->private;
 	input_unregister_device(&nkbd->dev);
@@ -141,7 +141,7 @@
 	kfree(nkbd);
 }
 
-struct serio_driver nkbd_drv = {
+static struct serio_driver nkbd_drv = {
 	.driver		= {
 		.name	= "newtonkbd",
 	},
@@ -151,13 +151,13 @@
 	.disconnect	= nkbd_disconnect,
 };
 
-int __init nkbd_init(void)
+static int __init nkbd_init(void)
 {
 	serio_register_driver(&nkbd_drv);
 	return 0;
 }
 
-void __exit nkbd_exit(void)
+static void __exit nkbd_exit(void)
 {
 	serio_unregister_driver(&nkbd_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/sunkbd.c.old	2004-11-07 03:50:50.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/sunkbd.c	2004-11-07 03:51:07.000000000 +0100
@@ -318,13 +318,13 @@
  * The functions for insering/removing us as a module.
  */
 
-int __init sunkbd_init(void)
+static int __init sunkbd_init(void)
 {
 	serio_register_driver(&sunkbd_drv);
 	return 0;
 }
 
-void __exit sunkbd_exit(void)
+static void __exit sunkbd_exit(void)
 {
 	serio_unregister_driver(&sunkbd_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/xtkbd.c.old	2004-11-07 03:51:40.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/keyboard/xtkbd.c	2004-11-07 03:52:22.000000000 +0100
@@ -65,7 +65,7 @@
 	char phys[32];
 };
 
-irqreturn_t xtkbd_interrupt(struct serio *serio,
+static irqreturn_t xtkbd_interrupt(struct serio *serio,
 	unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct xtkbd *xtkbd = serio->private;
@@ -88,7 +88,7 @@
 	return IRQ_HANDLED;
 }
 
-void xtkbd_connect(struct serio *serio, struct serio_driver *drv)
+static void xtkbd_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct xtkbd *xtkbd;
 	int i;
@@ -138,7 +138,7 @@
 	printk(KERN_INFO "input: %s on %s\n", xtkbd_name, serio->phys);
 }
 
-void xtkbd_disconnect(struct serio *serio)
+static void xtkbd_disconnect(struct serio *serio)
 {
 	struct xtkbd *xtkbd = serio->private;
 	input_unregister_device(&xtkbd->dev);
@@ -146,7 +146,7 @@
 	kfree(xtkbd);
 }
 
-struct serio_driver xtkbd_drv = {
+static struct serio_driver xtkbd_drv = {
 	.driver		= {
 		.name	= "xtkbd",
 	},
@@ -156,13 +156,13 @@
 	.disconnect	= xtkbd_disconnect,
 };
 
-int __init xtkbd_init(void)
+static int __init xtkbd_init(void)
 {
 	serio_register_driver(&xtkbd_drv);
 	return 0;
 }
 
-void __exit xtkbd_exit(void)
+static void __exit xtkbd_exit(void)
 {
 	serio_unregister_driver(&xtkbd_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/misc/pcspkr.c.old	2004-11-07 03:52:39.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/misc/pcspkr.c	2004-11-07 03:52:48.000000000 +0100
@@ -27,7 +27,7 @@
 static char pcspkr_phys[] = "isa0061/input0";
 static struct input_dev pcspkr_dev;
 
-spinlock_t i8253_beep_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t i8253_beep_lock = SPIN_LOCK_UNLOCKED;
 
 static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
--- linux-2.6.10-rc1-mm3-full/drivers/input/misc/uinput.c.old	2004-11-07 03:53:01.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/misc/uinput.c	2004-11-07 03:53:12.000000000 +0100
@@ -396,7 +396,7 @@
 	return retval;
 }
 
-struct file_operations uinput_fops = {
+static struct file_operations uinput_fops = {
 	.owner =	THIS_MODULE,
 	.open =		uinput_open,
 	.release =	uinput_close,
--- linux-2.6.10-rc1-mm3-full/drivers/input/mouse/alps.c.old	2004-11-07 03:53:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/mouse/alps.c	2004-11-07 03:53:53.000000000 +0100
@@ -30,7 +30,7 @@
 #define ALPS_MODEL_GLIDEPOINT	1
 #define ALPS_MODEL_DUALPOINT	2
 
-struct alps_model_info {
+static struct alps_model_info {
 	unsigned char signature[3];
 	unsigned char model;
 } alps_model_data[] = {
@@ -187,7 +187,7 @@
 	return PSMOUSE_GOOD_DATA;
 }
 
-int alps_get_model(struct psmouse *psmouse)
+static int alps_get_model(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
--- linux-2.6.10-rc1-mm3-full/drivers/input/mouse/psmouse-base.c.old	2004-11-07 03:54:03.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/mouse/psmouse-base.c	2004-11-07 03:54:16.000000000 +0100
@@ -954,14 +954,14 @@
 	}
 }
 
-int __init psmouse_init(void)
+static int __init psmouse_init(void)
 {
 	psmouse_parse_proto();
 	serio_register_driver(&psmouse_drv);
 	return 0;
 }
 
-void __exit psmouse_exit(void)
+static void __exit psmouse_exit(void)
 {
 	serio_unregister_driver(&psmouse_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/mouse/sermouse.c.old	2004-11-07 03:54:24.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/mouse/sermouse.c	2004-11-07 03:54:35.000000000 +0100
@@ -302,13 +302,13 @@
 	.disconnect	= sermouse_disconnect,
 };
 
-int __init sermouse_init(void)
+static int __init sermouse_init(void)
 {
 	serio_register_driver(&sermouse_drv);
 	return 0;
 }
 
-void __exit sermouse_exit(void)
+static void __exit sermouse_exit(void)
 {
 	serio_unregister_driver(&sermouse_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/mouse/vsxxxaa.c.old	2004-11-07 03:54:46.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/mouse/vsxxxaa.c	2004-11-07 03:54:59.000000000 +0100
@@ -558,14 +558,14 @@
 	.disconnect	= vsxxxaa_disconnect,
 };
 
-int __init
+static int __init
 vsxxxaa_init (void)
 {
 	serio_register_driver(&vsxxxaa_drv);
 	return 0;
 }
 
-void __exit
+static void __exit
 vsxxxaa_exit (void)
 {
 	serio_unregister_driver(&vsxxxaa_drv);
--- linux-2.6.10-rc1-mm3-full/drivers/input/mousedev.c.old	2004-11-07 03:55:11.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/mousedev.c	2004-11-07 03:55:22.000000000 +0100
@@ -590,7 +590,7 @@
 	return 0;
 }
 
-struct file_operations mousedev_fops = {
+static struct file_operations mousedev_fops = {
 	.owner =	THIS_MODULE,
 	.read =		mousedev_read,
 	.write =	mousedev_write,
--- linux-2.6.10-rc1-mm3-full/drivers/input/serio/ct82c710.c.old	2004-11-07 03:55:31.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/serio/ct82c710.c	2004-11-07 03:55:56.000000000 +0100
@@ -193,7 +193,7 @@
 	return serio;
 }
 
-int __init ct82c710_init(void)
+static int __init ct82c710_init(void)
 {
 	if (ct82c710_probe())
 		return -ENODEV;
@@ -215,7 +215,7 @@
 	return 0;
 }
 
-void __exit ct82c710_exit(void)
+static void __exit ct82c710_exit(void)
 {
 	serio_unregister_port(ct82c710_port);
 	platform_device_unregister(ct82c710_device);
--- linux-2.6.10-rc1-mm3-full/drivers/input/serio/i8042.c.old	2004-11-07 03:56:22.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/serio/i8042.c	2004-11-07 03:57:11.000000000 +0100
@@ -77,7 +77,7 @@
 
 #include "i8042.h"
 
-spinlock_t i8042_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t i8042_lock = SPIN_LOCK_UNLOCKED;
 
 struct i8042_values {
 	int irq;
@@ -845,7 +845,7 @@
 /*
  * Reset the controller.
  */
-void i8042_controller_reset(void)
+static void i8042_controller_reset(void)
 {
 	if (i8042_reset) {
 		unsigned char param;
@@ -870,7 +870,7 @@
  * able to talk to the hardware when rebooting.
  */
 
-void i8042_controller_cleanup(void)
+static void i8042_controller_cleanup(void)
 {
 	int i;
 
@@ -1073,7 +1073,7 @@
 	return serio;
 }
 
-int __init i8042_init(void)
+static int __init i8042_init(void)
 {
 	int i;
 	int err;
@@ -1125,7 +1125,7 @@
 	return 0;
 }
 
-void __exit i8042_exit(void)
+static void __exit i8042_exit(void)
 {
 	int i;
 
--- linux-2.6.10-rc1-mm3-full/include/linux/libps2.h.old	2004-11-07 03:57:35.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/linux/libps2.h	2004-11-07 03:57:44.000000000 +0100
@@ -40,7 +40,6 @@
 };
 
 void ps2_init(struct ps2dev *ps2dev, struct serio *serio);
-int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout);
 int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_schedule_command(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data);
--- linux-2.6.10-rc1-mm3-full/drivers/input/serio/libps2.c.old	2004-11-07 03:57:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/serio/libps2.c	2004-11-07 03:58:07.000000000 +0100
@@ -28,7 +28,6 @@
 MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(ps2_init);
-EXPORT_SYMBOL(ps2_sendbyte);
 EXPORT_SYMBOL(ps2_command);
 EXPORT_SYMBOL(ps2_schedule_command);
 EXPORT_SYMBOL(ps2_handle_ack);
@@ -52,7 +51,7 @@
  * ps2_sendbyte() can only be called from a process context
  */
 
-int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout)
+static int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout)
 {
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->nak = 1;
--- linux-2.6.10-rc1-mm3-full/drivers/input/serio/parkbd.c.old	2004-11-07 03:58:19.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/serio/parkbd.c	2004-11-07 03:58:40.000000000 +0100
@@ -167,7 +167,7 @@
 	return serio;
 }
 
-int __init parkbd_init(void)
+static int __init parkbd_init(void)
 {
 	int err;
 
@@ -191,7 +191,7 @@
 	return 0;
 }
 
-void __exit parkbd_exit(void)
+static void __exit parkbd_exit(void)
 {
 	parport_release(parkbd_dev);
 	serio_unregister_port(parkbd_port);
--- linux-2.6.10-rc1-mm3-full/drivers/input/serio/serio.c.old	2004-11-07 03:59:31.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/serio/serio.c	2004-11-07 03:59:41.000000000 +0100
@@ -58,7 +58,7 @@
 static LIST_HEAD(serio_driver_list);
 static unsigned int serio_no;
 
-struct bus_type serio_bus = {
+static struct bus_type serio_bus = {
 	.name =	"serio",
 };
 
--- linux-2.6.10-rc1-mm3-full/drivers/input/serio/serio_raw.c.old	2004-11-07 03:59:58.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/serio/serio_raw.c	2004-11-07 04:00:15.000000000 +0100
@@ -235,7 +235,7 @@
 	return 0;
 }
 
-struct file_operations serio_raw_fops = {
+static struct file_operations serio_raw_fops = {
 	.owner =	THIS_MODULE,
 	.open =		serio_raw_open,
 	.release =	serio_raw_release,
@@ -375,13 +375,13 @@
 	.manual_bind	= 1,
 };
 
-int __init serio_raw_init(void)
+static int __init serio_raw_init(void)
 {
 	serio_register_driver(&serio_raw_drv);
 	return 0;
 }
 
-void __exit serio_raw_exit(void)
+static void __exit serio_raw_exit(void)
 {
 	serio_unregister_driver(&serio_raw_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/touchscreen/gunze.c.old	2004-11-07 04:00:24.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/touchscreen/gunze.c	2004-11-07 04:00:36.000000000 +0100
@@ -172,13 +172,13 @@
  * The functions for inserting/removing us as a module.
  */
 
-int __init gunze_init(void)
+static int __init gunze_init(void)
 {
 	serio_register_driver(&gunze_drv);
 	return 0;
 }
 
-void __exit gunze_exit(void)
+static void __exit gunze_exit(void)
 {
 	serio_unregister_driver(&gunze_drv);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/input/tsdev.c.old	2004-11-07 04:00:51.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/input/tsdev.c	2004-11-07 04:00:59.000000000 +0100
@@ -265,7 +265,7 @@
 	return retval;
 }
 
-struct file_operations tsdev_fops = {
+static struct file_operations tsdev_fops = {
 	.owner =	THIS_MODULE,
 	.open =		tsdev_open,
 	.release =	tsdev_release,

