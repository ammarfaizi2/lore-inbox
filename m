Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbUBXMpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 07:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbUBXMpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 07:45:52 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:47942 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262242AbUBXMpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 07:45:22 -0500
Date: Tue, 24 Feb 2004 13:45:14 +0100
Message-Id: <200402241245.i1OCjEM8019836@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 416] M68k Macintosh driver config
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update Macintosh driver config logic:
  - Move remaining Mac/m68k-specific logic from arch/m68k/Kconfig to
    drivers/macintosh/Kconfig
  - Fixup Mac/m68k conflicts

--- linux-2.6.3/arch/m68k/Kconfig	2004-02-15 11:47:08.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/Kconfig	2004-02-19 17:03:18.000000000 +0100
@@ -550,80 +550,6 @@
 	tristate "Macintosh serial support"
 	depends on MAC
 
-config ADB
-	bool "Apple Desktop Bus (ADB) support"
-	depends on MAC
-	help
-	  Apple Desktop Bus (ADB) support is for support of devices which
-	  are connected to an ADB port.  ADB devices tend to have 4 pins.
-	  If you have an Apple Macintosh prior to the iMac, or a
-	  "Blue and White G3", you probably want to say Y here.  Otherwise
-	  say N.
-
-config ADB_MACII
-	bool "Include Mac II ADB driver"
-	depends on ADB
-	help
-	  Say Y here if want your kernel to support Macintosh systems that use
-	  the Mac II style ADB.  This includes the II, IIx, IIcx, SE/30, IIci,
-	  Quadra 610, Quadra 650, Quadra 700, Quadra 800, Centris 610 and
-	  Centris 650.
-
-config ADB_MACIISI
-	bool "Include Mac IIsi ADB driver"
-	depends on ADB
-	help
-	  Say Y here if want your kernel to support Macintosh systems that use
-	  the Mac IIsi style ADB.  This includes the IIsi, IIvi, IIvx, Classic
-	  II, LC, LC II, LC III, Performa 460, and the Performa 600.
-
-config ADB_CUDA
-	bool "Include CUDA ADB driver"
-	depends on ADB
-	help
-	  This provides support for CUDA based Power Macintosh systems.  This
-	  includes most OldWorld PowerMacs, the first generation iMacs, the
-	  Blue&White G3 and the Yikes G4 (PCI Graphics).  All later models
-	  should use CONFIG_ADB_PMU instead.
-
-	  If unsure say Y.
-
-config ADB_IOP
-	bool "Include IOP (IIfx/Quadra 9x0) ADB driver"
-	depends on ADB
-	help
-	  The I/O Processor (IOP) is an Apple custom IC designed to provide
-	  intelligent support for I/O controllers.  It is described at
-	  <http://www.angelfire.com/ca2/dev68k/iopdesc.html> to enable direct
-	  support for it, say 'Y' here.
-
-config ADB_PMU68K
-	bool "Include PMU (Powerbook) ADB driver"
-	depends on ADB
-	help
-	  Say Y here if want your kernel to support the m68k based Powerbooks.
-	  This includes the PowerBook 140, PowerBook 145, PowerBook 150,
-	  PowerBook 160, PowerBook 165, PowerBook 165c, PowerBook 170,
-	  PowerBook 180, PowerBook, 180c, PowerBook 190cs, PowerBook 520,
-	  PowerBook Duo 210, PowerBook Duo 230, PowerBook Duo 250,
-	  PowerBook Duo 270c, PowerBook Duo 280 and PowerBook Duo 280c.
-
-config INPUT_ADBHID
-	bool "Use input layer for ADB devices"
-	depends on MAC && INPUT=y
-	---help---
-	  Say Y here if you want to have ADB (Apple Desktop Bus) HID devices
-	  such as keyboards, mice, joysticks, or graphic tablets handled by
-	  the input layer.  If you say Y here, make sure to say Y to the
-	  corresponding drivers "Keyboard support" (CONFIG_INPUT_KEYBDEV),
-	  "Mouse Support" (CONFIG_INPUT_MOUSEDEV) and "Event interface
-	  support" (CONFIG_INPUT_EVDEV) as well.
-
-	  If you say N here, you still have the option of using the old ADB
-	  keyboard and mouse drivers.
-
-	  If unsure, say Y.
-
 config MAC_HID
 	bool
 	depends on INPUT_ADBHID
@@ -643,18 +603,6 @@
 
 	  If unsure, say Y here.
 
-config MAC_EMUMOUSEBTN
-	bool "Support for mouse button 2+3 emulation"
-	depends on INPUT_ADBHID
-	help
-	  This provides generic support for emulating the 2nd and 3rd mouse
-	  button with keypresses.  If you say Y here, the emulation is still
-	  disabled by default.  The emulation is controlled by these sysctl
-	  entries:
-	  /proc/sys/dev/mac_hid/mouse_button_emulation
-	  /proc/sys/dev/mac_hid/mouse_button2_keycode
-	  /proc/sys/dev/mac_hid/mouse_button3_keycode
-
 config ADB_KEYBOARD
 	bool "Support for ADB keyboard (old driver)"
 	depends on MAC && !INPUT_ADBHID
--- linux-2.6.3/drivers/macintosh/Kconfig	2004-02-15 11:10:28.000000000 +0100
+++ linux-m68k-2.6.3/drivers/macintosh/Kconfig	2004-02-15 12:04:21.000000000 +0100
@@ -1,16 +1,66 @@
 
 menu "Macintosh device drivers"
 
+config ADB
+	bool "Apple Desktop Bus (ADB) support"
+	depends on MAC || PPC_PMAC
+	help
+	  Apple Desktop Bus (ADB) support is for support of devices which
+	  are connected to an ADB port.  ADB devices tend to have 4 pins.
+	  If you have an Apple Macintosh prior to the iMac, an iBook or
+	  PowerBook, or a "Blue and White G3", you probably want to say Y
+	  here.  Otherwise say N.
+
+config ADB_MACII
+	bool "Include Mac II ADB driver"
+	depends on ADB && MAC
+	help
+	  Say Y here if want your kernel to support Macintosh systems that use
+	  the Mac II style ADB.  This includes the II, IIx, IIcx, SE/30, IIci,
+	  Quadra 610, Quadra 650, Quadra 700, Quadra 800, Centris 610 and
+	  Centris 650.
+
+config ADB_MACIISI
+	bool "Include Mac IIsi ADB driver"
+	depends on ADB && MAC
+	help
+	  Say Y here if want your kernel to support Macintosh systems that use
+	  the Mac IIsi style ADB.  This includes the IIsi, IIvi, IIvx, Classic
+	  II, LC, LC II, LC III, Performa 460, and the Performa 600.
+
+config ADB_IOP
+	bool "Include IOP (IIfx/Quadra 9x0) ADB driver"
+	depends on ADB && MAC
+	help
+	  The I/O Processor (IOP) is an Apple custom IC designed to provide
+	  intelligent support for I/O controllers.  It is described at
+	  <http://www.angelfire.com/ca2/dev68k/iopdesc.html> to enable direct
+	  support for it, say 'Y' here.
+
+config ADB_PMU68K
+	bool "Include PMU (Powerbook) ADB driver"
+	depends on ADB && MAC
+	help
+	  Say Y here if want your kernel to support the m68k based Powerbooks.
+	  This includes the PowerBook 140, PowerBook 145, PowerBook 150,
+	  PowerBook 160, PowerBook 165, PowerBook 165c, PowerBook 170,
+	  PowerBook 180, PowerBook, 180c, PowerBook 190cs, PowerBook 520,
+	  PowerBook Duo 210, PowerBook Duo 230, PowerBook Duo 250,
+	  PowerBook Duo 270c, PowerBook Duo 280 and PowerBook Duo 280c.
+
 # we want to change this to something like CONFIG_SYSCTRL_CUDA/PMU
 config ADB_CUDA
-	bool "Support for CUDA based PowerMacs"
-	depends on PPC_PMAC && !PPC_PMAC64
+	bool "Support for CUDA based Macs and PowerMacs"
+	depends on (ADB || PPC_PMAC) && !PPC_PMAC64
 	help
-	  This provides support for CUDA based Power Macintosh systems.  This
-	  includes most OldWorld PowerMacs, the first generation iMacs, the
-	  Blue&White G3 and the "Yikes" G4 (PCI Graphics).  All later models
-	  should use CONFIG_ADB_PMU instead.  It is safe to say Y here even if
-	  your machine doesn't have a CUDA.
+	  This provides support for CUDA based Macintosh and Power Macintosh
+	  systems.  This includes many m68k based Macs (Color Classic, Mac TV,
+	  Performa 475, Performa 520, Performa 550, Performa 575,
+	  Performa 588, Quadra 605, Quadra 630, Quadra/Centris 660AV, and
+	  Quadra 840AV), most OldWorld PowerMacs, the first generation iMacs,
+	  the Blue&White G3 and the "Yikes" G4 (PCI Graphics).  All later
+	  models should use CONFIG_ADB_PMU instead.  It is safe to say Y here
+	  even if your machine doesn't have a CUDA.
 
 	  If unsure say Y.
 
@@ -81,19 +131,9 @@
 	  This driver is obsolete. Use CONFIG_SERIAL_PMACZILOG in
 	  "Character devices --> Serial drivers --> PowerMac z85c30" option.
 
-config ADB
-	bool "Apple Desktop Bus (ADB) support"
-	depends on PPC_PMAC
-	help
-	  Apple Desktop Bus (ADB) support is for support of devices which
-	  are connected to an ADB port.  ADB devices tend to have 4 pins.
-	  If you have an Apple Macintosh prior to the iMac, an iBook or
-	  PowerBook, or a "Blue and White G3", you probably want to say Y
-	  here.  Otherwise say N.
-
 config ADB_MACIO
 	bool "Include MacIO (CHRP) ADB driver"
-	depends on ADB && PPC_PMAC && !PPC_PMAC64
+	depends on ADB && PPC_CHRP && !PPC_PMAC64
 	help
 	  Say Y here to include direct support for the ADB controller in the
 	  Hydra chip used on PowerPC Macintoshes of the CHRP type.  (The Hydra
@@ -151,6 +191,6 @@
 
 config ANSLCD
 	bool "Support for ANS LCD display"
-	depends on ADB_CUDA
+	depends on ADB_CUDA && PPC_PMAC
 
 endmenu

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
