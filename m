Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267089AbTGOKaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267096AbTGOKaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:30:10 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:29913 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S267089AbTGOKaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:30:05 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1: Synaptics driver makes touchpad unusable
Date: Tue, 15 Jul 2003 12:44:53 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200307151244.53276.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new synaptics driver doesn't work with Dell Latitude Touchpad, it doesn't 
work any /dev/input/event?|mouse? and /dev/psaux neither (altough the same 
configuration worked at least until 2.5.70).

I tried with gpm and the X's synaptics driver from 
http://w1.894.telia.com/~u89404340/touchpad/index.html (as indicated in the 
kernel documentation) and none worked, although "cat < /dev/input/event0" 
showed garbage every time I touched the touchpad (no pun intended) iff evdev 
was loaded.

$ dmesg
...
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1
 Firware: 5.9
 180 degree mounted touchpad
 Sensor: 37
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
...


$ cat /proc/bus/input/devices
I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="Synaptics Synaptics TouchPad"
P: Phys=isa0060/serio4/input0
H: Handlers=event0
B: EV=1b
B: KEY=670000 0 0 0 0 0 0 0 0
B: ABS=1000003
B: MSC=4

I: Bus=0011 Vendor=0001 Product=0002 Version=ab83
N: Name="AT Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event1
B: EV=120003
B: KEY=4 2000000 c061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe
B: LED=7

$ cat /proc/bus/input/handlers
N: Number=0 Name=kbd
N: Number=1 Name=mousedev Minor=32
N: Number=2 Name=evdev Minor=64


Hope this helps.

Regards,

-- 
  ricardo galli       GPG id C8114D34
