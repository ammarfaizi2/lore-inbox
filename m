Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318341AbSHEIlf>; Mon, 5 Aug 2002 04:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318342AbSHEIle>; Mon, 5 Aug 2002 04:41:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21215 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318341AbSHEIle>; Mon, 5 Aug 2002 04:41:34 -0400
Date: Mon, 5 Aug 2002 10:45:06 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: jbradford@dial.pipex.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] Re: 2.4.19 duplicate config entry
In-Reply-To: <200208042057.g74KvS3X000703@darkstar.example.net>
Message-ID: <Pine.NEB.4.44.0208051038140.27501-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002 jbradford@dial.pipex.com wrote:

> Hi,

Hi John,

> I've just noticed in 2.4.19, that:
>
> "Support for PCMCIA management for PC-style ports" appears twice in the configuration.
>
> I didn't notice it in 2.4.19-RC2, (the last version I compiled), but I might have missed it.
>
> By the way, I got a 2.4.18 tree, patched it to RC1, then used the incremental patches up to -final.
>
> The second instance is greyed-out in xconfig, and neither allows y, m or n to be selected.

it's at no time possible that more than one choice is available which
means it's harmless.

But you are right, it doesn't look good. IMHO the following more simple
(and semantically equivalent) solution should work and correct it:

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

> John.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

