Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUBCUvU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUBCUvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:51:20 -0500
Received: from main.gmane.org ([80.91.224.249]:64426 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266143AbUBCUuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:50:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Juergen Stuber <stuber@loria.fr>
Subject: [PROBLEM] 2.6.2-rc1-bk1 Synaptics touchpad on IBM T30 not detected
Date: Tue, 03 Feb 2004 21:49:00 +0100
Message-ID: <86u127khxf.fsf@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: berthelemy-1-81-56-4-123.fbx.proxad.net
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/20.7 (gnu/linux)
Cancel-Lock: sha1:DiT62QB8hLpvIcz7bvMSln2vwXA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the touchpad works fine in 2.6.2-rc1 with the Synaptics XFree86 driver,
it isn't detected and doesn't show up in /proc/bus/input/devices
for 2.6.2-rc1-bk1 and later, psmouse is loaded in all cases.

The machine is an IBM Thinkpad T30 (2366-085G) with stick & touchpad,
both are set on automatic in the BIOS.

For 2.6.2-rc1 I see

Feb  3 19:55:48 freitag kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  3 19:55:48 freitag kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  3 19:55:48 freitag kernel: input: AT Translated Set 2 keyboard on isa0060/s
[...]
Feb  3 19:55:48 freitag kernel: Synaptics Touchpad, model: 1
Feb  3 19:55:48 freitag kernel:  Firmware: 5.9
Feb  3 19:55:48 freitag kernel:  Sensor: 44
Feb  3 19:55:48 freitag kernel:  new absolute packet format
Feb  3 19:55:48 freitag kernel:  Touchpad has extended capability bits
Feb  3 19:55:48 freitag kernel:  -> multifinger detection
Feb  3 19:55:48 freitag kernel:  -> palm detection
Feb  3 19:55:48 freitag kernel:  -> pass-through port
Feb  3 19:55:48 freitag kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Feb  3 19:55:48 freitag kernel: serio: Synaptics pass-through port at isa0060/serio1/input0


For 2.6.2-rc1-bk1 I see

Feb  3 20:34:12 freitag kernel: i8042.c: Detected active multiplexing controller, rev 10.12.
Feb  3 20:34:12 freitag kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Feb  3 20:34:12 freitag kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Feb  3 20:34:12 freitag kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Feb  3 20:34:12 freitag kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Feb  3 20:34:12 freitag kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  3 20:34:12 freitag kernel: input: AT Translated Set 2 keyboard on isa0060/serio0

and later, supposedly when psmouse is loaded, 4 times

Feb  3 20:34:12 freitag kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb  3 20:34:12 freitag kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.


Unloading psmouse kills the keyboard and produces four ß (0xdf)
and 8 unknown-key-messages.
Then loading the module produces another four 0xdf
and 4 unknown-key-messages and the keyboard works normally again.

% cat /proc/bus/input/devices 
I: Bus=0011 Vendor=0001 Product=0001 Version=ab54
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0 
B: EV=120003 
B: KEY=4 2000000 3802078 38405001 f2ffffdf ffefffff ffffffff fffffffe 
B: LED=7 

I: Bus=0003 Vendor=046d Product=c506 Version=1600
N: Name="Logitech USB Receiver"
P: Phys=usb-0000:00:1d.1-2.2/input0
H: Handlers=mouse0 event1 
B: EV=20007 
B: KEY=ffff0000 0 0 0 0 0 0 0 0 
B: REL=103 
B: LED=400 

% cat /proc/bus/input/handlers 
N: Number=0 Name=kbd
N: Number=1 Name=mousedev Minor=32
N: Number=2 Name=evdev Minor=64


Hope this helps

Jürgen

-- 
Jürgen Stuber <stuber@loria.fr>
http://www.loria.fr/~stuber/

