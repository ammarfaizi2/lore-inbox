Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262987AbSJGLg5>; Mon, 7 Oct 2002 07:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262988AbSJGLg5>; Mon, 7 Oct 2002 07:36:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48071 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262987AbSJGLg4>; Mon, 7 Oct 2002 07:36:56 -0400
Date: Mon, 7 Oct 2002 13:42:30 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-parport@torque.net>
cc: linux-kernel@vger.kernel.org, <jbradford@dial.pipex.com>,
       "Steven W. Dover" <swdlinunx@earthlink.net>
Subject: [patch] simplify the Config.in for CONFIG_PARPORT_PC_PCMCIA
Message-ID: <Pine.NEB.4.44.0210071208400.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the current Config.in code for CONFIG_PARPORT_PC_PCMCIA in both
2.4.20-pre9 and 2.5.40 has the disadvantage that "make xconfig" shows two
entries for this option (it's harmless since at most one of them is
selectable at any time). The patch below fixes this. It does an
semantically equivalent transformation with the positive side effect that
it's now more simple.

--- linux/drivers/parport/Config.in.old	2002-10-07 13:21:26.000000000 +0200
+++ linux/drivers/parport/Config.in	2002-10-07 13:35:31.000000000 +0200
@@ -24,13 +24,7 @@
          bool '    Use FIFO/DMA if available (EXPERIMENTAL)' CONFIG_PARPORT_PC_FIFO
          bool '    SuperIO chipset support (EXPERIMENTAL)' CONFIG_PARPORT_PC_SUPERIO
       fi
-      if [ "$CONFIG_HOTPLUG" = "y" -a "$CONFIG_PCMCIA" != "n" ]; then
-         if [ "$CONFIG_PARPORT_PC" = "y" ]; then
-            dep_tristate '    Support for PCMCIA management for PC-style ports' CONFIG_PARPORT_PC_PCMCIA $CONFIG_PCMCIA
-         else
-            dep_tristate '    Support for PCMCIA management for PC-style ports' CONFIG_PARPORT_PC_PCMCIA $CONFIG_PARPORT_PC
-         fi
-      fi
+      dep_tristate '    Support for PCMCIA management for PC-style ports' CONFIG_PARPORT_PC_PCMCIA $CONFIG_HOTPLUG $CONFIG_PCMCIA $CONFIG_PARPORT_PC
    fi
    if [ "$CONFIG_ARM" = "y" ]; then
       dep_tristate '  Archimedes hardware' CONFIG_PARPORT_ARC $CONFIG_PARPORT

Please apply
Adrian


