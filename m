Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSGQPam>; Wed, 17 Jul 2002 11:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSGQPam>; Wed, 17 Jul 2002 11:30:42 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:14211 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S315204AbSGQPak>; Wed, 17 Jul 2002 11:30:40 -0400
Date: Wed, 17 Jul 2002 17:33:36 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020717153336.GK14581@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020717095618.GD14581@tahoe.alcove-fr> <20020717120135.A12452@ucw.cz> <20020717101001.GE14581@tahoe.alcove-fr> <20020717140804.B12529@ucw.cz> <20020717132459.GF14581@tahoe.alcove-fr> <20020717154448.A19761@ucw.cz> <20020717135823.GG14581@tahoe.alcove-fr> <20020717162904.B19935@ucw.cz> <20020717145523.GJ14581@tahoe.alcove-fr> <20020717172235.A20474@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717172235.A20474@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 05:22:35PM +0200, Vojtech Pavlik wrote:

> > Argh, with this patch, the mouse still doesn't work but I also
> > lose the keyboard (but keyboard press/release events are
> > however present in the logs...)!
[...]
> Are you sure you didn't change the config? Because this really looks
> like if noone is actually even trying to probe. Which is quite
> impossible, unless CONFIG_KEYBOARD_ATKBD and CONFIG_MOUSE_PS2 are
> disabled.

Of course you're correct, I must have toggled something in the input
section (the i8042 entry probably) from Y to M and that probably
turned off the other settings. Sorry for that.

Anyway, let's start over:
	$ egrep "INPUT|MOUSE|KEYB|SERIO|8042" .config | grep -v ^#
	CONFIG_INPUT=y
	CONFIG_INPUT_KEYBDEV=y
	CONFIG_INPUT_MOUSEDEV=y
	CONFIG_INPUT_MOUSEDEV_PSAUX=y
	CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
	CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
	CONFIG_SERIO=y
	CONFIG_SERIO_I8042=y
	CONFIG_I8042_REG_BASE=60
	CONFIG_I8042_KBD_IRQ=1
	CONFIG_I8042_AUX_IRQ=12
	CONFIG_INPUT_KEYBOARD=y
	CONFIG_KEYBOARD_ATKBD=y
	CONFIG_INPUT_MOUSE=y
	CONFIG_MOUSE_PS2=y
	CONFIG_USB_HIDINPUT=y

The i8042 version used is the one you send me, plus the #if 0 surrounding
the aux probe code.

Result: keyboard works, mouse still doesn't.
...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: 23579136 sectors w/512KiB Cache, CHS=23392/16/63, UDMA(33)
 hda: [PTBL] [1467/255/63] hda1 hda2 hda3 < hda5 hda6 >
mice: PS/2 mouse device common for all mice
i8042.c: fa <- i8042 (flush, kbd) [0]
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 56 -> i8042 (parameter) [0]
i8042.c: a8 -> i8042 (command) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 56 -> i8042 (parameter) [0]
i8042.c: 60 -> i8042 (command) [1]
i8042.c: 56 -> i8042 (parameter) [1]
i8042.c: d4 -> i8042 (command) [1]
i8042.c: f6 -> i8042 (parameter) [1]
i8042.c: 60 -> i8042 (command) [1]
i8042.c: 56 -> i8042 (parameter) [1]
i8042.c: 60 -> i8042 (command) [73]
i8042.c: 54 -> i8042 (parameter) [73]
i8042.c: 60 -> i8042 (command) [73]
i8042.c: 56 -> i8042 (parameter) [73]
i8042.c: d4 -> i8042 (command) [73]
i8042.c: f5 -> i8042 (parameter) [73]
i8042.c: 60 -> i8042 (command) [74]
i8042.c: 56 -> i8042 (parameter) [74]
i8042.c: 60 -> i8042 (command) [145]
i8042.c: 54 -> i8042 (parameter) [145]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [145]
i8042.c: 44 -> i8042 (parameter) [145]
i8042.c: 60 -> i8042 (command) [145]
i8042.c: 45 -> i8042 (parameter) [145]
i8042.c: f6 -> i8042 (kbd-data) [146]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [148]
i8042.c: f2 -> i8042 (kbd-data) [149]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [151]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [155]
i8042.c: 60 -> i8042 (command) [155]
i8042.c: 44 -> i8042 (parameter) [155]
i8042.c: 60 -> i8042 (command) [155]
i8042.c: 45 -> i8042 (parameter) [155]
i8042.c: f5 -> i8042 (kbd-data) [156]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [158]
i8042.c: f2 -> i8042 (kbd-data) [158]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [161]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [166]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [171]
i8042.c: ea -> i8042 (kbd-data) [171]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [174]
i8042.c: f0 -> i8042 (kbd-data) [174]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [177]
i8042.c: 02 -> i8042 (kbd-data) [177]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [180]
i8042.c: f0 -> i8042 (kbd-data) [180]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [182]
i8042.c: 00 -> i8042 (kbd-data) [183]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [185]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [188]
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=11/1/2/ab02 NAME=AT Set 2 keyboard]
input.c: hotplug returned -2
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: f8 -> i8042 (kbd-data) [191]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [194]
i8042.c: ed -> i8042 (kbd-data) [194]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [197]
i8042.c: 00 -> i8042 (kbd-data) [198]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203]
i8042.c: f4 -> i8042 (kbd-data) [203]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [206]
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
