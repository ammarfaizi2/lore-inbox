Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUALCK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 21:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUALCK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 21:10:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35541 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265218AbUALCKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 21:10:55 -0500
Date: Mon, 12 Jan 2004 03:10:52 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andreas Haumer <andreas@xss.co.at>,
       David Hinds <dahinds@users.sourceforge.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: [2.4 patch] simplify PARPORT_PC_PCMCIA dependencies
Message-ID: <20040112021052.GG9677@fs.tum.de>
References: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet> <3FF2EAB3.1090001@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF2EAB3.1090001@xss.co.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 04:26:43PM +0100, Andreas Haumer wrote:

> Hi!

Hi Andreas!

>...
> Here's a first report:
>...
>    - Double (but deactivated) entry in config dialog for
>      + "Parallel port support" / "Support for PCMCIA management for PC-stype ports"
>...

Thanks for this report.

The patch below fixes this issue, and as a side effect it's also a great 
simplification (while remaining semantically equivalent with the 
original dependencies).

cu
Adrian

--- linux-2.4.25-pre4-full/drivers/parport/Config.in.old	2004-01-12 02:51:25.000000000 +0100
+++ linux-2.4.25-pre4-full/drivers/parport/Config.in	2004-01-12 03:00:50.000000000 +0100
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
+      dep_tristate '    Support for PCMCIA management for PC-style ports' CONFIG_PARPORT_PC_PCMCIA $CONFIG_PCMCIA $CONFIG_PARPORT_PC $CONFIG_HOTPLUG
    fi
    if [ "$CONFIG_ARM" = "y" ]; then
       dep_tristate '  Archimedes hardware' CONFIG_PARPORT_ARC $CONFIG_PARPORT
