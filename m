Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUJaKPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUJaKPY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUJaKPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:15:17 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:63313 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261530AbUJaKDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:39 -0500
Date: Sun, 31 Oct 2004 11:03:38 +0100
Message-Id: <200410311003.i9VA3cUD009591@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 480] HP300 config
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HP300 configuration updates from Kars de Jong:
  - Updated help for CONFIG_HP300
  - DIO support defaults to y
  - HP DCA support depends on SERIAL_8250
  - Added HP APCI option
  - Removed HP DCA from SERIAL_CONSOLE dependencies

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/Kconfig	2004-04-05 15:09:00.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/Kconfig	2004-07-14 13:17:55.000000000 +0200
@@ -187,17 +187,19 @@
 	  drivers for SCSI, Ethernet and serial ports later on.
 
 config HP300
-	bool "HP9000/300 support"
+	bool "HP9000/300 and HP9000/400 support"
 	depends on !MMU_SUN3
 	help
-	  This option enables support for the HP9000/300 series of
-	  workstations. Support for these machines is still very experimental.
-	  If you plan to try to use the kernel on such a machine say Y here.
+	  This option enables support for the HP9000/300 and HP9000/400 series
+	  of workstations. Support for these machines is still somewhat
+	  experimental. If you plan to try to use the kernel on such a machine
+	  say Y here.
 	  Everybody else says N.
 
 config DIO
 	bool "DIO bus support"
 	depends on HP300
+	default y
 	help
 	  Say Y here to enable support for the "DIO" expansion bus used in
 	  HP300 machines. If you are using such a system you almost certainly
@@ -586,11 +588,18 @@
 
 config HPDCA
 	tristate "HP DCA serial support"
-	depends on DIO
+	depends on DIO && SERIAL_8250
 	help
 	  If you want to use the internal "DCA" serial ports on an HP300
 	  machine, say Y here.
 
+config HPAPCI
+	tristate "HP APCI serial support"
+	depends on HP300 && SERIAL_8250 && EXPERIMENTAL
+	help
+	  If you want to use the internal "APCI" serial ports on an HP400
+	  machine, say Y here.
+
 config MVME147_SCC
 	bool "SCC support for MVME147 serial ports"
 	depends on MVME147
@@ -627,7 +636,7 @@
 
 config SERIAL_CONSOLE
 	bool "Support for serial port console"
-	depends on (AMIGA || ATARI || MAC || HP300 || SUN3 || SUN3X || VME || APOLLO) && (ATARI_MFPSER=y || ATARI_SCC=y || ATARI_MIDI=y || MAC_SCC=y || AMIGA_BUILTIN_SERIAL=y || GVPIOEXT=y || MULTIFACE_III_TTY=y || HPDCA=y || SERIAL=y || MVME147_SCC || SERIAL167 || MVME162_SCC || BVME6000_SCC || DN_SERIAL)
+	depends on (AMIGA || ATARI || MAC || SUN3 || SUN3X || VME || APOLLO) && (ATARI_MFPSER=y || ATARI_SCC=y || ATARI_MIDI=y || MAC_SCC=y || AMIGA_BUILTIN_SERIAL=y || GVPIOEXT=y || MULTIFACE_III_TTY=y || SERIAL=y || MVME147_SCC || SERIAL167 || MVME162_SCC || BVME6000_SCC || DN_SERIAL)
 	---help---
 	  If you say Y here, it will be possible to use a serial port as the
 	  system console (the system console is the device which receives all

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
