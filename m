Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274070AbRIXRYq>; Mon, 24 Sep 2001 13:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274071AbRIXRYh>; Mon, 24 Sep 2001 13:24:37 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:15115 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S274070AbRIXRY2>; Mon, 24 Sep 2001 13:24:28 -0400
Date: Mon, 24 Sep 2001 16:22:44 -0100 (GMT+1)
From: Dave Jones <davej@suse.de>
X-X-Sender: <davej@noodles.codemonkey.org.uk>
To: <carstenl@mips.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] SAA9730 compilation fix.
Message-ID: <Pine.LNX.4.33.0109241614150.22455-100000@noodles.codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 The SAA9730 appears to be mips only, as it includes files
from asm/ which are only present in mips/ and mips64/
The patch below makes this only show up on the menu for mips32,

I didn't spot a define_bool CONFIG_MIPS64 or the likes, so
it probably needs improving if the driver works on mips64 too.

Also, the driver seems to support being built as a module, but
the config option was a bool.

regards,

Dave.

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .

diff -urN --exclude-from=/home/davej/.exclude linux-dj/drivers/net/Config.in linux-test/drivers/net/Config.in
--- linux-dj/drivers/net/Config.in	Mon Sep 24 00:36:27 2001
+++ linux-test/drivers/net/Config.in	Mon Sep 24 16:10:09 2001
@@ -191,8 +191,8 @@
       if [ "$CONFIG_OBSOLETE" = "y" ]; then
 	 dep_bool '    Zenith Z-Note support (EXPERIMENTAL)' CONFIG_ZNET $CONFIG_ISA
       fi
-      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	 bool '    Philips SAA9730 Ethernet support (EXPERIMENTAL)' CONFIG_LAN_SAA9730
+      if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_MIPS" = "y" ]; then
+	 dep_tristate '    Philips SAA9730 Ethernet support (EXPERIMENTAL)' CONFIG_LAN_SAA9730 $CONFIG_MIPS
       fi
    fi
    bool '  Pocket and portable adapters' CONFIG_NET_POCKET

