Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262994AbSJGL6g>; Mon, 7 Oct 2002 07:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262998AbSJGL6g>; Mon, 7 Oct 2002 07:58:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60358 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262994AbSJGL6f>; Mon, 7 Oct 2002 07:58:35 -0400
Date: Mon, 7 Oct 2002 14:04:08 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-parport@torque.net>
cc: linux-kernel@vger.kernel.org, <jbradford@dial.pipex.com>
Subject: Re: [patch] simplify the Config.in for CONFIG_PARPORT_PC_PCMCIA
In-Reply-To: <Pine.NEB.4.44.0210071208400.8340-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.NEB.4.44.0210071358020.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ups, just noticed that my last patch wasn't correct: dep_tristate ignores
dependencies with an empty value ($%&#$!) and since there are
architectures that do define neither CONFIG_HOTPLUG nor CONFIG_PCMCIA the
following is the correct patch:


--- drivers/parport/Config.in.old	Mon Aug  5 10:32:28 2002
+++ drivers/parport/Config.in	Mon Aug  5 10:40:03 2002
@@ -24,12 +24,8 @@
          bool '    Use FIFO/DMA if available (EXPERIMENTAL)' CONFIG_PARPORT_PC_FIFO
          bool '    SuperIO chipset support (EXPERIMENTAL)' CONFIG_PARPORT_PC_SUPERIO
       fi
-      if [ "$CONFIG_HOTPLUG" = "y" -a "$CONFIG_PCMCIA" != "n" ]; then
-         if [ "$CONFIG_PARPORT_PC" = "y" ]; then
-            dep_tristate '    Support for PCMCIA management for PC-style ports' CONFIG_PARPORT_PC_PCMCIA $CONFIG_PCMCIA
-         else
-            dep_tristate '    Support for PCMCIA management for PC-style ports' CONFIG_PARPORT_PC_PCMCIA $CONFIG_PARPORT_PC
-         fi
+      if [ "$CONFIG_HOTPLUG" = "y" ]; then
+         dep_tristate '    Support for PCMCIA management for PC-style ports' CONFIG_PARPORT_PC_PCMCIA $CONFIG_PCMCIA $CONFIG_PARPORT_PC
       fi
    fi
    if [ "$CONFIG_ARM" = "y" ]; then


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

