Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUDPK3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 06:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUDPK3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 06:29:35 -0400
Received: from hal-5.inet.it ([213.92.5.24]:15785 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S262932AbUDPK3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 06:29:11 -0400
Date: Fri, 16 Apr 2004 12:29:03 +0200
From: Mattia Dongili <dongili@supereva.it>
To: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [2.6.5] problems with synaptics/psmouse/atkbd
Message-ID: <20040416102903.GA1790@inferi.kami.home>
Mail-Followup-To: vojtech@suse.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.5-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please could you Cc me as I'm not subscribed to linux-kernel]

Hi,

I'm having problems (since 2.6.3 now trying with 2.6.5).
Main symptom is that my synaptics touchpad isn't detected after a cold
boot. After a warm boot it's detected correctly though.
In the cold boot case I have some weird behaviours loading psmouse:
[...]
 psmouse_probe(): Probing mouse
 psmouse_probe(): sending 0xa5
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
 psmouse_probe(): Probing mouse
 psmouse_probe(): sending 0xa5
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
 psmouse_probe(): Probing mouse
 psmouse_probe(): sending 0xa5
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
 psmouse_probe(): Probing mouse
 psmouse_probe(): sending 0xa5
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.

but XFree86 is not running! (I also added some further debug printks in
psmouse_probe and psmouse_extensions but the latter is never reached)

unloading psmouse also disables the keyboard and prints a flood of 
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.

this is /proc/bus/input/devices without synaptics touchpad

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0 
B: EV=120003 
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe 
B: LED=7 

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
H: Handlers=kbd event1 
B: EV=40001 
B: SND=6 

I: Bus=0010 Vendor=104d Product=0000 Version=0000
N: Name="Sony VAIO Jog Dial"
P: Phys=
H: Handlers=mouse0 event2 
B: EV=7 
B: KEY=40000 0 0 0 0 0 0 0 0 
B: REL=100 

I: Bus=0003 Vendor=046d Product=c001 Version=0410
N: Name="Logitech USB Mouse"
P: Phys=usb-0000:00:1d.1-1/input0
H: Handlers=mouse1 event3 
B: EV=f 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=103 
B: ABS=100 0 

after a warm boot it adds:

I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse2 event4 
B: EV=b 
B: KEY=6420 0 670000 0 0 0 0 0 0 0 0 
B: ABS=11000003 

and this is the relevant part of dmesg:
...
 psmouse_probe(): Probing mouse
 psmouse_probe(): sending 0xa5
 psmouse_probe(): has an extended protocol?
 psmouse_extensions(): Going to probe Synaptics
  psmouse_extensions(): Synaptics seems to be here
usb 2-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.1-1
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 37
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
  psmouse_extensions(): Synaptics inited!
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
...

any help/patch to spot the problem? Need more info?
thanks in advance
-- 
mattia
:wq!
Hodie decimo sexto Kalendas Maias MMDCCLVII ab urbe condita est
