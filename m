Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264263AbSIQP1u>; Tue, 17 Sep 2002 11:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264265AbSIQP1u>; Tue, 17 Sep 2002 11:27:50 -0400
Received: from mailout.nordcom.net ([213.168.202.90]:30441 "HELO
	mailout.nordcom.net") by vger.kernel.org with SMTP
	id <S264263AbSIQP1t>; Tue, 17 Sep 2002 11:27:49 -0400
Date: Tue, 17 Sep 2002 17:32:46 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.2] Add ALi 5451 gameport support to joy-pci.c
Message-ID: <Pine.LNX.4.44.0209171727050.1349-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

This patch adds support for the gameport found in ALi 5451 chips to
drivers/char/joystick/joy-pci.c. It's basically the same as the 2.4-ac
patch I sent last week - just adds the PCI id to the driver and the
chip name to the help texts. The gameport itself works just like the
one found on Trident 4DWave cards.

Doesn't really touch any code, so I think this is okay for inclusion
in 2.2., right? It works on my machine.

Diff against 2.2.22


diff -ruN linux-2.2.22/Documentation/Configure.help mod-2.2.22/Documentation/Configure.help
--- linux-2.2.22/Documentation/Configure.help	Tue Sep 17 16:18:33 2002
+++ mod-2.2.22/Documentation/Configure.help	Tue Sep 17 17:19:43 2002
@@ -11700,12 +11700,13 @@
   joystick or gamepad connected to it. For more information on how to
   use the driver please read Documentation/joystick.txt
 
-Trident 4DWave and Aureal Vortex gameport
+Trident 4DWave/Aureal Vortex/ALi 5451 gameport
 CONFIG_JOY_PCI
   Say Y here if you have a Trident 4DWave DX/NX or Aureal Vortex 1/2
-  card and want to use its gameport in its enhanced digital mode
-  with and ordinary analog joystick. For more information on how to
-  use the driver please read Documentation/joystick.txt
+  card or an ALi 5451 chip on your motherboard and want to use its
+  gameport in its enhanced digital mode with an ordinary analog
+  joystick. For more information on how to use the driver please read
+  Documentation/joystick.txt
 
 Magellan and Space Mouse
 CONFIG_JOY_MAGELLAN
diff -ruN linux-2.2.22/drivers/char/joystick/Config.in mod-2.2.22/drivers/char/joystick/Config.in
--- linux-2.2.22/drivers/char/joystick/Config.in	Tue Jan  4 19:12:14 2000
+++ mod-2.2.22/drivers/char/joystick/Config.in	Tue Sep 17 17:20:08 2002
@@ -16,7 +16,7 @@
    dep_tristate '  ThrustMaster DirectConnect' CONFIG_JOY_THRUSTMASTER $CONFIG_JOYSTICK
    dep_tristate '  Creative Labs Blaster' CONFIG_JOY_CREATIVE $CONFIG_JOYSTICK
    dep_tristate '  PDPI Lightning 4 card' CONFIG_JOY_LIGHTNING $CONFIG_JOYSTICK
-   dep_tristate '  Trident 4DWave and Aureal Vortex gameport' CONFIG_JOY_PCI $CONFIG_JOYSTICK
+   dep_tristate '  Trident 4DWave/Aureal Vortex/ALi 5451 gameport' CONFIG_JOY_PCI $CONFIG_JOYSTICK
    dep_tristate '  Magellan and Space Mouse' CONFIG_JOY_MAGELLAN $CONFIG_JOYSTICK
    dep_tristate '  SpaceTec SpaceOrb 360 and SpaceBall Avenger' CONFIG_JOY_SPACEORB $CONFIG_JOYSTICK
    dep_tristate '  SpaceTec SpaceBall 4000 FLX' CONFIG_JOY_SPACEBALL $CONFIG_JOYSTICK
diff -ruN linux-2.2.22/drivers/char/joystick/joy-pci.c mod-2.2.22/drivers/char/joystick/joy-pci.c
--- linux-2.2.22/drivers/char/joystick/joy-pci.c	Sun Sep 15 15:50:06 2002
+++ mod-2.2.22/drivers/char/joystick/joy-pci.c	Tue Sep 17 16:23:20 2002
@@ -129,6 +129,8 @@
 	js_pci_vortex_init, js_pci_vortex_cleanup, "Aureal Vortex1" },
  { PCI_VENDOR_ID_AUREAL,  0x0002, 0x40000, 0x2a00c, 0x2880c, 0x28808, 0x28810, 4, 0x1fff,
 	js_pci_vortex_init, js_pci_vortex_cleanup, "Aureal Vortex2" },
+ { PCI_VENDOR_ID_AL,      0x5451, 0x10000, 0x00044, 0x00030, 0x00031, 0x00034, 2, 0xffff,
+	js_pci_4dwave_init, js_pci_4dwave_cleanup, "ALi 5451" },
  { 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL }};
 
 /*


