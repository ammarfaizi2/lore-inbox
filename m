Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTHYOYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTHYOYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:24:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6860 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261797AbTHYOYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:24:19 -0400
Date: Mon, 25 Aug 2003 16:24:07 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andries Brouwer <aebr@win.tue.nl>
Subject: Re: Trying to run 2.6.0-test3
Message-ID: <20030825142407.GC6179@ucw.cz>
References: <138e01c364ab$15b6c2b0$1aee4ca5@DIAMONDLX60> <1061141113.21878.76.camel@dhcp23.swansea.linux.org.uk> <151801c36577$10e4f5a0$1aee4ca5@DIAMONDLX60> <20030818110026.GA29405@ucw.cz> <003601c36972$a6835940$78ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003601c36972$a6835940$78ee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 09:29:53PM +0900, Norman Diamond wrote:
> "Vojtech Pavlik" <vojtech@suse.cz> replied to me with the program evtest.c.
> 
> > > Hirofumi Ogawa posted a patch for the yen-sign pipe key on 2003.07.23
> > > for test1 but his patch still didn't get into test3.
> >
> > It will get into 2.6 sooner or later.
> >
> > > On a PS/2 keyboard that
> > > seems to be the only key with any problem.
> > >
> > > Yesterday when I finally tried a USB keyboard and found that the
> > > backslash underbar has the same problem, maybe I was the first person to
> > > even try a Japanese USB keyboard in 2.6, and maybe no one at all tried
> > > some number of 2.5 series kernels.
> >
> > If you can find out what input event the key generates (using the evtest
> > program attached), then please tell me, and I'll fix in the same way as
> > the yen key was fixed.
> >
> > > As mentioned, usually I can only spend one day a week
> > > testing 2.6.
> 
> For this test, I used a laptop with a built-in emulated PS/2 keyboard and
> mouse, and plugged in a USB keyboard.  I do not dare yet to try 2.6.0-testN
> on a small-size desktop which depends entirely on USB.  The small-size
> desktop provides BIOS emulation of a PS/2 keyboard from boot until the OS
> detects USB devices.  It does not provide any emulation of an i8042 chip.
> (Windows NT4 blue-screens if I forget to disable its i8042 driver.)  It
> does not have PS/2 ports.

Don't fear, go ahead, 2.6 should work fine without an i8042.

> Back to the laptop used in this test.  Since the built-in emulated PS/2
> keyboard had some "?" events, I ran evtest on all devices.  Sorry this
> is still 2.6.0-test3.  I wanted to finish this test before experimenting
> with 2.6.0-test4.  I already patched the 2.6.0-test3 keyboard map, so the
> yen-sign pipe key produces input in both X11 and text consoles.  The USB
> problem is with the yen-sign or-bar key, which seems to produce events
> properly, and which produces correct input under X11, but produces no
> input to a plain text console.  I wonder what needs patching for this.

The default keymap. Patch was already created by somebody, I'll
include it soon.

> In a plain text console, in the built-in emulated PS/2 keyboard, both the
> yen-sign or-bar and backslash underbar keys are working because of the
> patch.  But in the USB keyboard, the yen-sign or-bar key is working while
> the backslash underbar key yields no input.
> 
> First, here are results of running evtest under X11.
> 
> The emulated PS/2 mouse looks fine.
> 
> ndiamond@diamondpana:~/linux-pavlik-evtest> evtest /dev/input/event0
> Input driver version is 1.0.0
> Input device ID: bus 0x11 vendor 0x2 product 0x1 version 0x29
> Input device name: "PS/2 Logitech Mouse"

> Event: time 1061637735.598896, type 2 (Relative), code 1 (Y), value 1
> Event: time 1061637735.634618, type 2 (Relative), code 0 (X), value 1
> Event: time 1061637737.806503, type 1 (Key), code 273 (RightBtn), value 0
> Event: time 1061637739.053020, type 1 (Key), code 272 (LeftBtn), value 1
> 
> Here is the emulated PS/2 keyboard.  I did not try all keys.  In fact I
> cannot try a number of keys which appear in the list but don't exist.
> I did try the ones which are frequently mishandled, yen-sign or-bar and
> backslash underbar.
> 
> ndiamond@diamondpana:~/linux-pavlik-evtest> evtest /dev/input/event1
> Input driver version is 1.0.0
> Input device ID: bus 0x11 vendor 0x1 product 0x2 version 0xab02
> Input device name: "AT Set 2 keyboard"
>   Event type 20 (Repeat)
> 
> [Here is yen-sign or-bar:]
> Event: time 1061638812.315540, type 1 (Key), code 183 (International3), value 1

> [Here is backslash underbar:]
> Event: time 1061638897.294886, type 1 (Key), code 89 (F14), value 1

This one should probably be Intl1 and not F14. Scancode collission
between japanese keyboards and some old keyboard.

We will never be able to create a scancode->keycode table that matches
all existing keyboards. This is why these tables can be changed from
userspace via ioctls.

> Here is the external USB keyboard.  I did not try all keys.  In fact I
> cannot try a number of keys which appear in the list but don't exist.
> (Though the keyboard which I sent to Mike Fabian might really have some
> of these, among its ton of funny extra buttons.)  I did try the ones
> which are frequently mishandled, yen-sign or-bar and backslash underbar.  
> 
> ndiamond@diamondpana:~/linux-pavlik-evtest> evtest /dev/input/event2
> Input driver version is 1.0.0
> Input device ID: bus 0x3 vendor 0x409 product 0x14 version 0x100
> Input device name: "NEC 109 JPN USB KBD/M"
> 
> [Here is yen-sign or-bar:]
> Event: time 1061639164.238590, type 1 (Key), code 183 (International3), value 1
> [Here is backslash underbar:]
> Event: time 1061639230.403570, type 1 (Key), code 181 (International1), value 1
> 
> Next I switched to a text-mode console and tested the same two keyboards.
> The key codes seem to be the same.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
