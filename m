Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUBTNiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUBTMt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:49:57 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:50248 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261190AbUBTMrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:47:02 -0500
Date: Fri, 20 Feb 2004 13:46:44 +0100
Message-Id: <200402201246.i1KCkinQ004235@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 401] M68k configuration
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update M68k configuration logic:
  - Introduce CONFIG_MMU_MOTOROLA and CONFIG_MMU_SUN3
  - Move Sun-3 config selection to the top since all other platforms conflict
    with it
  - Sun-3 implies MMU_SUN3
  - All other platforms imply MMU_MOTOROLA
  - Sun-3 implies M68020
  - Sun-3x implies M68030
  - Sun-3 kernels cannot support 68030, 68040, or 68060

--- linux-2.6.3/arch/m68k/Kconfig	2004-02-01 20:53:38.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/Kconfig	2004-02-01 17:30:34.000000000 +0100
@@ -70,8 +77,21 @@
 	  To compile this driver as modules, choose M here: the
 	  modules will be called pcmcia_core and ds.
 
+config SUN3
+	bool "Sun3 support"
+	select M68020
+	select MMU_SUN3 if MMU
+	help
+	  This option enables support for the Sun 3 series of workstations
+	  (3/50, 3/60, 3/1xx, 3/2xx systems). Enabling this option requires 
+	  that all other hardware types must be disabled, as Sun 3 kernels 
+	  are incompatible with all other m68k targets (including Sun 3x!).  
+
+	  If you don't want to compile a kernel exclusively for a Sun 3, say N.
+
 config AMIGA
 	bool "Amiga support"
+	depends on !MMU_SUN3
 	help
 	  This option enables support for the Amiga series of computers. If
 	  you plan to use this kernel on an Amiga, say Y here and browse the
@@ -79,6 +99,7 @@
 
 config ATARI
 	bool "Atari support"
+	depends on !MMU_SUN3
 	help
 	  This option enables support for the 68000-based Atari series of
 	  computers (including the TT, Falcon and Medusa). If you plan to use
@@ -109,6 +130,7 @@
 
 config MAC
 	bool "Macintosh support"
+	depends on !MMU_SUN3
 	help
 	  This option enables support for the Apple Macintosh series of
 	  computers (yes, there is experimental support now, at least for part
@@ -129,12 +151,14 @@
 
 config APOLLO
 	bool "Apollo support"
+	depends on !MMU_SUN3
 	help
 	  Say Y here if you want to run Linux on an MC680x0-based Apollo
 	  Domain workstation such as the DN3500.
 
 config VME
 	bool "VME (Motorola and BVM) support"
+	depends on !MMU_SUN3
 	help
 	  Say Y here if you want to build a kernel for a 680x0 based VME
 	  board.  Boards currently supported include Motorola boards MVME147,
@@ -171,6 +195,7 @@
 
 config HP300
 	bool "HP9000/300 support"
+	depends on !MMU_SUN3
 	help
 	  This option enables support for the HP9000/300 series of
 	  workstations. Support for these machines is still very experimental.
@@ -187,30 +212,20 @@
 
 config SUN3X
 	bool "Sun3x support"
+	depends on !MMU_SUN3
+	select M68030
 	help
 	  This option enables support for the Sun 3x series of workstations.
-	  Be warned that this support is very experimental. You will also want
-	  to say Y to 68030 support and N to the other processors below.
+	  Be warned that this support is very experimental.
 	  Note that Sun 3x kernels are not compatible with Sun 3 hardware.
 	  General Linux information on the Sun 3x series (now discontinued)
 	  is at <http://www.angelfire.com/ca2/tech68k/sun3.html>.
 
 	  If you don't want to compile a kernel for a Sun 3x, say N.
 
-config SUN3
-	bool "Sun3 support"
-	help
-	  This option enables support for the Sun 3 series of workstations
-	  (3/50, 3/60, 3/1xx, 3/2xx systems). Enabling this option requires 
-	  that all other hardware types must be disabled, as Sun 3 kernels 
-	  are incompatible with all other m68k targets (including Sun 3x!).  
-	  Also, you will want to say Y to 68020 support and N to the other 
-	  processors below.
-
-	  If you don't want to compile a kernel exclusively for a Sun 3, say N.
-
 config Q40
 	bool "Q40/Q60 support"
+	depends on !MMU_SUN3
 	help
 	  The Q40 is a Motorola 68040-based successor to the Sinclair QL
 	  manufactured in Germany.  There is an official Q40 home page at
@@ -238,6 +245,7 @@
 
 config M68030
 	bool "68030 support"
+	depends on !MMU_SUN3
 	help
 	  If you anticipate running this kernel on a computer with a MC68030
 	  processor, say Y. Otherwise, say N. Note that a MC68EC030 will not
@@ -245,6 +253,7 @@
 
 config M68040
 	bool "68040 support"
+	depends on !MMU_SUN3
 	help
 	  If you anticipate running this kernel on a computer with a MC68LC040
 	  or MC68040 processor, say Y. Otherwise, say N. Note that an
@@ -253,6 +262,7 @@
 
 config M68060
 	bool "68060 support"
+	depends on !MMU_SUN3
 	help
 	  If you anticipate running this kernel on a computer with a MC68060
 	  processor, say Y. Otherwise, say N.
@@ -249,6 +264,14 @@
 	  If you anticipate running this kernel on a computer with a MC68060
 	  processor, say Y. Otherwise, say N.
 
+config MMU_MOTOROLA
+	bool
+	depends on MMU && !MMU_SUN3
+	default y
+
+config MMU_SUN3
+	bool
+
 config M68KFPU_EMU
 	bool "Math emulation support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
