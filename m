Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276938AbRJKVIQ>; Thu, 11 Oct 2001 17:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276934AbRJKVIG>; Thu, 11 Oct 2001 17:08:06 -0400
Received: from [206.135.119.95] ([206.135.119.95]:22020 "EHLO foozle.jmd")
	by vger.kernel.org with ESMTP id <S276930AbRJKVHv>;
	Thu, 11 Oct 2001 17:07:51 -0400
Date: Thu, 11 Oct 2001 16:06:40 -0500
From: "Jeremy M. Dolan" <jmd@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Joystick problems with 2.4.12, Configure.help patch
Message-ID: <20011011160640.A218@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 2 axis 6 button analog (ns558) gamepad. With 2.4.7,
everything is fine, as long as I pass js=gamepad, it detects the 2
axis and 6 buttons.

With 2.4.12, with js=gamepad, the kernel message SAYS it detects 2
axis and 6 buttons, however when I use it (for example, with the jstest
program), the two axis and buttons 4/5 don't register. The first four
(0-3) buttons are fine. If I reboot to 2.4.7 they all are fine, so it
is software.

I've also tried it with the bitfield method... I came up with 12531
decimal, which also says it detects 2 axis and 6 buttons, but same
effect, the axis and last two buttons don't work. Tried compiling it
in to the kernel, and as modules, no help. Tried js=auto, which thinks
the pad is 4 axis 4 buttons... none of the 4 axis work, but the 4
buttons do. With 2.4.7 and autodetect, it also thought there were 4
axis/4 buttons, but the first two axis worked fine, and the second two
were affected by the last two buttons. Also tried js=gamepad8 and
js=2btn, neither got the axis working.

Also, please check this Configure.help patch in, or something similar.
I've installed four 2.4 kernels, and *all* four on the first try I've
left out INPUT_JOYDEV because it says it's only for USB.

--- Configure.help.old  Thu Oct 11 14:32:58 2001
+++ Configure.help      Thu Oct 11 14:39:16 2001
@@ -11172,6 +11172,9 @@
   Say Y here if you want to enable any of the USB HID options in the
   USB support section which require Input core support.
 
+  This is also required for joysticks and gamepads which use classic
+  ISA (and serial? PCI?) gameports.
+
   Otherwise, say N.
 
 Keyboard support
@@ -11215,8 +11218,8 @@
 
 Joystick support
 CONFIG_INPUT_JOYDEV
-  Say Y here if you want your USB HID joystick or gamepad to be
-  accessible as char device 13:0+ - /dev/input/jsX device. 
+  Say Y here if you want your joystick or gamepad to be accessible 
+  as char device 13:0+ - /dev/input/jsX device. 
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).


Cc me on replies, thanks.

-- 
Jeremy M. Dolan <mailto:jmd@pobox.com> <http://turbogeek.org/>
PGP: 1024D/DC433DEE 494C 7A6E 19FB 026A 1F52  E0D5 5C5D 6228 DC43 3DEE
