Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUACWmE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264333AbUACWmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:42:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:15078 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264321AbUACWl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:41:59 -0500
X-Authenticated: #15238641
Date: Sat, 3 Jan 2004 23:42:43 +0100
From: Gregor Paul <pute@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6 USB-Mouse
Message-Id: <20040103234243.343cc843.pute@gmx.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all something to my system.
Mandrake 9.2 @ Kernel 2.6.0-1md (the one from the cooker but the problem consists even with a self-made Kernel from www.kernel.org)


I have a problem with 2.6 and my optical USB-Mouse.
I started my new 2.6 for the first time and my mandrake said by booting the kernel:
usbmouse removed     psaux added
The mouse was neither connected to PS/2 nor to the serial port.
My mouse didn't light anymore and that results that she isn't working.
So I connected my mouse on PS/2 and she works perfect, though that is no real solution for me because the light is on even if my computer is turned off. I checked my X-Configuration -> everything the same as 2.4.22

Section "InputDevice"
Identifier "Mouse1"
Driver "mouse"
Option "Protocol" "IMPS/2"
Option "Device" "/dev/usbmouse"
Option "ZAxisMapping" "5 6"
EndSection 

I started to modprobe some things.
modprobe usb-ohci
My mouse started to "shake" (didn't found a appropriate word ) when i move it on the usb -Port, but I know that I need uhci because I have a VIA Board.
[root@chello080110200043 gregor]# lspci -v|grep USB
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller 


This guy has (had) the same problem like me: 
http://kerneltrap.org/node/view/1620

I changed my modules.conf like the guy suggested:
 probeall usb-interface usb-uhci
to
probeall usb-interface uhci-hcd

Now a weird thing happened:
Only in one case, when I boot with PS/2 and change then to USB my mouse starts to move. She is shaking but she moves.
dmesg
hub 1-0:1.0: new USB device on port 2, assigned address 2

When I boot with USB-mouse my dmesg says:
usb 1.2:control timeout on ep0out
uhci_hcd 0000:00:11.2: Unlink after no-IRC? Different ACPI or APIC settings may help.

Please help me I'm really frustrated and in despair.
Thank you 


