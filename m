Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbTINKNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 06:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTINKNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 06:13:34 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:22796 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262354AbTINKN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 06:13:26 -0400
Date: Sun, 14 Sep 2003 12:13:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20030914121323.B3371@pclin040.win.tue.nl>
References: <2F284368A@vcnet.vc.cvut.cz> <20030913205244.A3295@pclin040.win.tue.nl> <20030913214047.GF8973@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030913214047.GF8973@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Sat, Sep 13, 2003 at 11:40:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 11:40:47PM +0200, Petr Vandrovec wrote:

> From log it looks like that switch likes 0x41 a lot: it reports ID 0x41AB,
> it reports current scan set 0x41, and when we enable it, it returns spurious
> 0x41... And the last 0x41 is one which confuses everything.
> 
> Linux version 2.6.0-test5-c1283
> [...]
> drivers/usb/misc/usblcd.c: USBLCD Driver Version 1.04 (C) Adams IT Services http://www.usblcd.de
> drivers/usb/misc/usblcd.c: USBLCD support registered.
> mice: PS/2 mouse device common for all mice
> input: PC Speaker

Get keyboard controller command byte
> i8042.c: 20 -> i8042 (command) [0]
> i8042.c: 47 <- i8042 (return) [0]
47: XLATE, SYSF, MIE, KIE

> i8042.c: 60 -> i8042 (command) [0]
> i8042.c: 56 -> i8042 (parameter) [0]
Disable keyboard and keyboard interrupt

> i8042.c: d3 -> i8042 (command) [0]
> i8042.c: f0 -> i8042 (parameter) [0]
> i8042.c: 0f <- i8042 (return) [0]
> i8042.c: d3 -> i8042 (command) [0]
> i8042.c: 56 -> i8042 (parameter) [0]
> i8042.c: a9 <- i8042 (return) [0]
> i8042.c: d3 -> i8042 (command) [1]
> i8042.c: a4 -> i8042 (parameter) [1]
> i8042.c: 5b <- i8042 (return) [1]
> i8042.c: d3 -> i8042 (command) [1]
> i8042.c: 5a -> i8042 (parameter) [1]
> i8042.c: a5 <- i8042 (return) [1]
No special multiplexer in sight

> i8042.c: a7 -> i8042 (command) [1]
Disable mouse port

> i8042.c: 20 -> i8042 (command) [1]
> i8042.c: 76 <- i8042 (return) [1]
XLATE, ME, KE, SYSF, MIE

> i8042.c: a8 -> i8042 (command) [1]
Enable mouse port

> i8042.c: 20 -> i8042 (command) [1]
> i8042.c: 56 <- i8042 (return) [1]
XLATE, KE, SYSF, MIE

> i8042.c: 60 -> i8042 (command) [1]
> i8042.c: 74 -> i8042 (parameter) [1]
> i8042.c: 60 -> i8042 (command) [1]
> i8042.c: 54 -> i8042 (parameter) [1]
> i8042.c: 60 -> i8042 (command) [2]
> i8042.c: 56 -> i8042 (parameter) [2]
After changing our minds twice we set XLATE, KE, SYSF, MIE
(keyboard disabled, mouse enabled)

> i8042.c: d4 -> i8042 (command) [2]
> i8042.c: f2 -> i8042 (parameter) [2]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [5]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [6]
Read mouse ID. Get 0, as expected.

> i8042.c: 60 -> i8042 (command) [6]
> i8042.c: 54 -> i8042 (parameter) [6]
> i8042.c: 60 -> i8042 (command) [6]
> i8042.c: 56 -> i8042 (parameter) [6]
Again some nonsense changes. Set XLATE, KE, SYSF, MIE

> i8042.c: d4 -> i8042 (command) [7]
> i8042.c: f2 -> i8042 (parameter) [7]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [10]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [11]
Read mouse ID again. Get 0, as expected.

> i8042.c: d4 -> i8042 (command) [11]
> i8042.c: f6 -> i8042 (parameter) [11]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [15]
Set defaults.

> i8042.c: d4 -> i8042 (command) [15]
> i8042.c: e8 -> i8042 (parameter) [15]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [18]
> i8042.c: d4 -> i8042 (command) [18]
> i8042.c: 00 -> i8042 (parameter) [18]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [21]
> i8042.c: d4 -> i8042 (command) [21]
> i8042.c: e8 -> i8042 (parameter) [21]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [25]
> i8042.c: d4 -> i8042 (command) [25]
> i8042.c: 00 -> i8042 (parameter) [25]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [28]
> i8042.c: d4 -> i8042 (command) [28]
> i8042.c: e8 -> i8042 (parameter) [28]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [32]
> i8042.c: d4 -> i8042 (command) [32]
> i8042.c: 00 -> i8042 (parameter) [32]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [35]
> i8042.c: d4 -> i8042 (command) [35]
> i8042.c: e8 -> i8042 (parameter) [35]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [39]
> i8042.c: d4 -> i8042 (command) [39]
> i8042.c: 00 -> i8042 (parameter) [39]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [42]
> i8042.c: d4 -> i8042 (command) [42]
> i8042.c: e9 -> i8042 (parameter) [42]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [46]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [47]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [48]
> i8042.c: 28 <- i8042 (interrupt, aux, 12) [49]
Send the magic sequence e8 00 e8 00 e8 00 e8 00 e9
The middle byte of the reply does not have 47: no Touchpad

> i8042.c: d4 -> i8042 (command) [49]
> i8042.c: e8 -> i8042 (parameter) [49]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [53]
> i8042.c: d4 -> i8042 (command) [53]
> i8042.c: 03 -> i8042 (parameter) [53]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [56]
> i8042.c: d4 -> i8042 (command) [56]
> i8042.c: e6 -> i8042 (parameter) [56]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [60]
> i8042.c: d4 -> i8042 (command) [60]
> i8042.c: e6 -> i8042 (parameter) [60]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [63]
> i8042.c: d4 -> i8042 (command) [63]
> i8042.c: e6 -> i8042 (parameter) [63]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [67]
> i8042.c: d4 -> i8042 (command) [67]
> i8042.c: e9 -> i8042 (parameter) [67]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [70]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [71]
> i8042.c: 03 <- i8042 (interrupt, aux, 12) [72]
> i8042.c: 28 <- i8042 (interrupt, aux, 12) [74]
Send the magic sequence e8 03 e6 e6 e6 e9
No magic reaction

> i8042.c: d4 -> i8042 (command) [74]
> i8042.c: e8 -> i8042 (parameter) [74]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [77]
> i8042.c: d4 -> i8042 (command) [77]
> i8042.c: 00 -> i8042 (parameter) [77]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [81]
> i8042.c: d4 -> i8042 (command) [81]
> i8042.c: e6 -> i8042 (parameter) [81]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [84]
> i8042.c: d4 -> i8042 (command) [84]
> i8042.c: e6 -> i8042 (parameter) [84]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [87]
> i8042.c: d4 -> i8042 (command) [87]
> i8042.c: e6 -> i8042 (parameter) [87]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [91]
> i8042.c: d4 -> i8042 (command) [91]
> i8042.c: e9 -> i8042 (parameter) [91]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [94]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [95]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [97]
> i8042.c: 28 <- i8042 (interrupt, aux, 12) [98]
Send the magic sequence e8 00 e6 e6 e6 e9 (Identify Touchpad)
No magic reaction

> i8042.c: d4 -> i8042 (command) [98]
> i8042.c: f3 -> i8042 (parameter) [98]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [101]
> i8042.c: d4 -> i8042 (command) [101]
> i8042.c: c8 -> i8042 (parameter) [101]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [105]
> i8042.c: d4 -> i8042 (command) [105]
> i8042.c: f3 -> i8042 (parameter) [105]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [108]
> i8042.c: d4 -> i8042 (command) [108]
> i8042.c: 64 -> i8042 (parameter) [108]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [112]
> i8042.c: d4 -> i8042 (command) [112]
> i8042.c: f3 -> i8042 (parameter) [112]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [115]
> i8042.c: d4 -> i8042 (command) [115]
> i8042.c: 50 -> i8042 (parameter) [115]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [119]
Set sampling rate to 200, 100, 80

> i8042.c: d4 -> i8042 (command) [119]
> i8042.c: f2 -> i8042 (parameter) [119]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [122]
> i8042.c: 03 <- i8042 (interrupt, aux, 12) [123]
Now ID has become 03: we recognise Intellimouse

> i8042.c: d4 -> i8042 (command) [123]
> i8042.c: f3 -> i8042 (parameter) [123]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [127]
> i8042.c: d4 -> i8042 (command) [127]
> i8042.c: c8 -> i8042 (parameter) [127]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [130]
> i8042.c: d4 -> i8042 (command) [130]
> i8042.c: f3 -> i8042 (parameter) [130]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [134]
> i8042.c: d4 -> i8042 (command) [134]
> i8042.c: c8 -> i8042 (parameter) [134]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [137]
> i8042.c: d4 -> i8042 (command) [137]
> i8042.c: f3 -> i8042 (parameter) [137]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [141]
> i8042.c: d4 -> i8042 (command) [141]
> i8042.c: 50 -> i8042 (parameter) [141]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [144]
> i8042.c: d4 -> i8042 (command) [144]
> i8042.c: f2 -> i8042 (parameter) [144]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [148]
> i8042.c: 03 <- i8042 (interrupt, aux, 12) [149]
After set sampling rate 200,200,80 the ID is still 03:
Not an Explorer mouse

> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

> i8042.c: d4 -> i8042 (command) [149]
> i8042.c: f3 -> i8042 (parameter) [149]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [152]
> i8042.c: d4 -> i8042 (command) [152]
> i8042.c: 64 -> i8042 (parameter) [152]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [156]
Set sampling rate 100
> i8042.c: d4 -> i8042 (command) [156]
> i8042.c: f3 -> i8042 (parameter) [156]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [159]
> i8042.c: d4 -> i8042 (command) [159]
> i8042.c: c8 -> i8042 (parameter) [159]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [163]
Set sampling rate 200
> i8042.c: d4 -> i8042 (command) [163]
> i8042.c: e8 -> i8042 (parameter) [163]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [166]
> i8042.c: d4 -> i8042 (command) [166]
> i8042.c: 03 -> i8042 (parameter) [166]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [170]
Set resolution 3
> i8042.c: d4 -> i8042 (command) [170]
> i8042.c: e6 -> i8042 (parameter) [170]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [173]
Set scaling 1:1
> i8042.c: d4 -> i8042 (command) [173]
> i8042.c: ea -> i8042 (parameter) [173]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [176]
Set stream mode
> i8042.c: d4 -> i8042 (command) [176]
> i8042.c: f4 -> i8042 (parameter) [176]
> i8042.c: fa <- i8042 (interrupt, aux, 12) [180]
Mouse enable
> serio: i8042 AUX port at 0x60,0x64 irq 12

So far the mouse probing. Now the keyboard probing.
> i8042.c: 60 -> i8042 (command) [180]
> i8042.c: 46 -> i8042 (parameter) [180]
> i8042.c: 60 -> i8042 (command) [180]
> i8042.c: 47 -> i8042 (parameter) [180]
We change our mind once more and set XLATE, SYSF, MIE, KIE

> i8042.c: f2 -> i8042 (kbd-data) [180]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [183]
> i8042.c: ab <- i8042 (interrupt, kbd, 1) [184]
> i8042.c: 41 <- i8042 (interrupt, kbd, 1) [185]
Keyboard ID is as usual (translation of ab 83)

> i8042.c: ed -> i8042 (kbd-data) [185]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [188]
> i8042.c: 00 -> i8042 (kbd-data) [188]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [191]
Set LEDs

> i8042.c: f0 -> i8042 (kbd-data) [191]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [194]
> i8042.c: 02 -> i8042 (kbd-data) [194]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [196]
Set scancode set 2

> i8042.c: f0 -> i8042 (kbd-data) [196]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [199]
> i8042.c: 00 -> i8042 (kbd-data) [199]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [202]
> i8042.c: 41 <- i8042 (interrupt, kbd, 1) [203]
Read scancode set. Get 41 (41 is translation of 02)

> i8042.c: f4 -> i8042 (kbd-data) [203]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [206]
Keyboard enable

> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> i2c /dev entries driver module version 2.7.0 (20021208)
> i2c-i801 version 2.7.0 (20021208)
> i2c-piix4 version 2.7.0 (20021208)
> i8042.c: 41 <- i8042 (interrupt, kbd, 1) [207]

Surprise! An additional 41 nobody had asked for.
As a scancode this is the scancode for the F7 function key.

--------

> From log it looks like that switch likes 0x41 a lot: it reports ID 0x41AB,
> it reports current scan set 0x41, and when we enable it, it returns spurious
> 0x41... And the last 0x41 is one which confuses everything.

Yes. ID is OK. Scancode set is OK. But the final one is unexpected.

You say "confuses everything".
Is it not treated as a keypress for the F7 key?

Andries

