Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTIMVmF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 17:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTIMVmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 17:42:04 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:33666 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262217AbTIMVky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 17:40:54 -0400
Date: Sat, 13 Sep 2003 23:40:47 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20030913214047.GF8973@vana.vc.cvut.cz>
References: <2F284368A@vcnet.vc.cvut.cz> <20030913205244.A3295@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913205244.A3295@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 08:52:44PM +0200, Andries Brouwer wrote:
> On Fri, Sep 12, 2003 at 08:33:24PM +0200, Petr Vandrovec wrote:
> 
> > Andries is already gathering info for this one. This problem (missed
> > key release) happens to me on all systems I have (Athlon + via, P3 + i440BX,
> > P4 + 845...), most often when I do alt+right-arrow for walking through
> > consoles (and for Andries: hitting key stops this, otherwise it 
> > endlessly switches all VTs around, and while kernel thinks that key
> > is down, keyboard actually does not generate any IRQs, so keyboard knows
> > that all keys are released).
> 
> OK. It seems to me the two main hypotheses are: (i) problem with timers,
> (ii) problem with keyboard.
> 
> In other words: could you (and/or anybody else who can reproduce this
> at will) change the #undef DEBUG in i8042.c to #define DEBUG, recreate
> the problem, and post or mail the resulting file with keystrokes?
> 
> [of course: cut away parts corresponding to login sequences etc.]
> 
> This will probably allow us to decide whether the missing key release
> was never sent by the keyboard, or was lost by the kernel.

Unfortunately I'm at home, while box is at work, so I could only reboot it,
and confirm that it happened again. Unfortunately I cannot go to the box
and hit any key to get some more data. But I'll enable this on my workstation,
and if I'll get some "unexpected keycode" or "keyboard reconnect" errors again,
I'll have more data in the hand.

>From log it looks like that switch likes 0x41 a lot: it reports ID 0x41AB,
it reports current scan set 0x41, and when we enable it, it returns spurious
0x41... And the last 0x41 is one which confuses everything.
						Thanks,
							Petr

Linux version 2.6.0-test5-c1283 (root@placatec) (gcc version 3.3.2 20030908 (Debian prerelease)) #5 SMP Sat Sep 13 23:11:05 CEST 2003
[...]
drivers/usb/misc/usblcd.c: USBLCD Driver Version 1.04 (C) Adams IT Services http://www.usblcd.de
drivers/usb/misc/usblcd.c: USBLCD support registered.
mice: PS/2 mouse device common for all mice
input: PC Speaker
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: 0f <- i8042 (return) [0]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: a9 <- i8042 (return) [0]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [1]
drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: 5b <- i8042 (return) [1]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: a5 <- i8042 (return) [1]
drivers/input/serio/i8042.c: a7 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 76 <- i8042 (return) [1]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 56 <- i8042 (return) [1]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [2]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [5]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [6]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [6]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [6]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [6]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [6]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [7]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [7]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [11]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [11]
drivers/input/serio/i8042.c: f6 -> i8042 (parameter) [11]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [15]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [15]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [15]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [18]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [18]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [18]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [21]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [21]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [21]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [25]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [25]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [25]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [28]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [28]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [28]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [32]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [32]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [32]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [35]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [35]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [35]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [39]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [39]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [39]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [42]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [42]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [42]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [46]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [47]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [48]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, aux, 12) [49]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [49]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [49]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [53]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [53]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [53]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [56]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [56]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [56]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [60]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [60]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [60]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [63]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [63]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [63]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [67]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [67]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [67]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [70]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [71]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, aux, 12) [72]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, aux, 12) [74]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [74]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [74]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [77]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [77]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [77]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [81]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [81]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [81]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [84]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [84]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [84]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [87]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [87]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [87]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [91]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [91]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [91]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [94]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [95]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [97]
drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, aux, 12) [98]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [98]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [98]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [101]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [101]
drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [101]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [105]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [105]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [105]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [108]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [108]
drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [108]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [112]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [112]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [112]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [115]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [115]
drivers/input/serio/i8042.c: 50 -> i8042 (parameter) [115]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [119]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [119]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [119]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [122]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, aux, 12) [123]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [123]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [123]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [127]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [127]
drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [127]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [130]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [130]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [130]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [134]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [134]
drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [134]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [137]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [137]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [137]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [141]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [141]
drivers/input/serio/i8042.c: 50 -> i8042 (parameter) [141]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [144]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [144]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [144]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [148]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, aux, 12) [149]
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
drivers/input/serio/i8042.c: d4 -> i8042 (command) [149]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [149]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [152]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [152]
drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [152]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [156]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [156]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [156]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [159]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [159]
drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [159]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [163]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [163]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [163]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [166]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [166]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [166]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [170]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [170]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [170]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [173]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [173]
drivers/input/serio/i8042.c: ea -> i8042 (parameter) [173]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [176]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [176]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [176]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [180]
serio: i8042 AUX port at 0x60,0x64 irq 12
drivers/input/serio/i8042.c: 60 -> i8042 (command) [180]
drivers/input/serio/i8042.c: 46 -> i8042 (parameter) [180]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [180]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [180]
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [180]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [183]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [184]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [185]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [185]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [188]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [188]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [191]
drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [191]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [194]
drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [194]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [196]
drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [196]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [199]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [199]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [202]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [203]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [203]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [206]
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
i2c-i801 version 2.7.0 (20021208)
i2c-piix4 version 2.7.0 (20021208)
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [207]
registering 1-0290
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
ACPI: (supports S0 S1 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 368k freed
Adding 1959920k swap on /dev/hde2.  Priority:-1 extents:1
Intel(R) PRO/1000 Network Driver - version 5.1.13-k2
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
