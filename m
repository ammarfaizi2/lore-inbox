Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292748AbSBZT0V>; Tue, 26 Feb 2002 14:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292749AbSBZT0L>; Tue, 26 Feb 2002 14:26:11 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:28891 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S292748AbSBZT0D>; Tue, 26 Feb 2002 14:26:03 -0500
Message-Id: <200202261838.LAA23194@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Vojtech Pavlik <vojtech@ucw.cz>
Subject: [PATCH] 2.5.5-dj1, small fix in drivers/input/gameport/Config.in
Date: Tue, 26 Feb 2002 12:24:15 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking through the Config.in files in 2.5.5-dj1 for missing
help texts in Config.help, I found that in drivers/input/gameport
we have both CONFIG_GAMEPORT_EMU10K1 and CONFIG_INPUT_EMU10K1,
and perhaps only one of these is needed.

Here is a snippet from the drivers/input/gameport/Makefile:

obj-$(CONFIG_GAMEPORT_CS614X)   += cs614x.o
obj-$(CONFIG_GAMEPORT_EMU10K1)  += emu10k1-gp.o
obj-$(CONFIG_GAMEPORT_FM801)    += fm801-gp.o

There is no help text for CONFIG_INPUT_EMU10K1, but there is
one for CONFIG_GAMEPORT_EMU10K1 in drivers/input/gameport/Config.help.
However, drivers/input/gameport/Config.in prompts for a setting for
CONFIG_INPUT_EMU10K1.

The following micro-patch is proposed:

Steven

--- linux-2.5.5-dj1/drivers/input/gameport/Config.in.orig       Tue Feb 26 12:01:38 2002
+++ linux-2.5.5-dj1/drivers/input/gameport/Config.in    Tue Feb 26 12:02:09 2002
@@ -13,7 +13,7 @@

 dep_tristate '  Classic ISA and PnP gameport support' CONFIG_GAMEPORT_NS558 $CONFIG_GAMEPORT
 dep_tristate '  PDPI Lightning 4 gamecard support' CONFIG_GAMEPORT_L4 $CONFIG_GAMEPORT
-dep_tristate '  SB Live and Audigy gameport support' CONFIG_INPUT_EMU10K1 $CONFIG_GAMEPORT
+dep_tristate '  SB Live and Audigy gameport support' CONFIG_GAMEPORT_EMU10K1 $CONFIG_GAMEPORT
 dep_tristate '  Aureal Vortex and Vortex 2 gameport support' CONFIG_GAMEPORT_VORTEX $CONFIG_GAMEPORT
 dep_tristate '  ForteMedia FM801 gameport support' CONFIG_GAMEPORT_FM801 $CONFIG_GAMEPORT
 dep_tristate '  Crystal SoundFusion  gameport support' CONFIG_GAMEPORT_CS461x $CONFIG_GAMEPORT
