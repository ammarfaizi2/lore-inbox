Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269700AbTGOUo0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269702AbTGOUo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:44:26 -0400
Received: from ip45.usw1.rb1.pdx.nwlink.com ([207.202.132.45]:57221 "EHLO
	consumption.net") by vger.kernel.org with ESMTP id S269700AbTGOUoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:44:24 -0400
Date: Tue, 15 Jul 2003 13:59:17 -0700 (PDT)
From: crozierm@consumption.net
To: linux-kernel@vger.kernel.org
Subject: USB mouse "hang" with 2.5.75
Message-ID: <Pine.LNX.4.21.0307141151520.3036-100000@consumption.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm experiencing odd USB mouse behaviour with 2.5.75 & 2.6.0-test1.  Those
are the only 2.5.x flavors I've used on this particular computer, so I
don't know if this is something new.

While using the mouse normally, it will suddenly stop responding.  If I
cat /dev/input/mice and wiggle the mouse, nothing is returned.  No extra debug messages appear in the
syslog until I unplug the mouse and plug it back it, at which point
everything works normally.  I can't find specific steps to reproduce it,
but with persistent use I can usually get it to hang up within a minute or
two.

Also, if I leave XFree86 and go to the console, then switch back to
XFree86, the mouse is restored.  Because of this I thought it must be X,
but this has never happened with 2.4.x.

Below is usb debug logging and system info.  If I can provide any other
information, please respond to me directly, as I'm not on the list.

 -Michael

The mouse is a logitech optical usb mouse.  More info below in the usb
logging.

USB info:                                                                       
                                                                                
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)               
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)               
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)               
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)   

Syslog debugging when I unplug:

ehci_hcd 0000:00:1d.7: GetStatus port 5 status 001002 POWER sig=se0  CSC
hub 1-0:0: port 5, status 100, change 1, 12 Mb/s
hub 4-0:0: port 1, status 100, change 3, 12 Mb/s
usb 4-1: USB disconnect, address 5
usb 4-1: unregistering interfaces
usb 4-1: hcd_unlink_urb f72ced00 fail -22
usb 4-1: hcd_unlink_urb f72ce680 fail -22
usb 4-1: unregistering device
hub 4-0:0: port 1 enable change, status 100
drivers/usb/host/uhci-hcd.c: ff40: suspend_hc

syslogging when I plug back in:

ehci_hcd 0000:00:1d.7: GetStatus port 5 status 001403 POWER sig=k  CSC
CONNECT
hub 1-0:0: port 5, status 501, change 1, 480 Mb/s
hub 1-0:0: debounce: port 5: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:1d.7: port 5 low speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 5 status 003002 POWER OWNER sig=se0
CSC
drivers/usb/host/uhci-hcd.c: ff40: wakeup_hc
hub 4-0:0: port 1, status 301, change 1, 1.5 Mb/s
hub 4-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 4-0:0: new USB device on port 1, assigned address 6
usb 4-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-1: Product: USB Optical Mouse
usb 4-1: Manufacturer: Logitech
usb 4-1: usb_new_device - registering interface 4-1:0
hid 4-1:0: usb_device_probe
hid 4-1:0: usb_device_probe - got id
input: USB HID v1.10 Mouse [Logitech USB Optical Mouse] on
usb-0000:00:1d.2-1


Other system info:

Intel E7505 w/ xeon

Linux version 2.6.0-test1 (crozierm@dentaku) (gcc version 3.3.1 20030626
(Debian prerelease)) #6 SMP Tue Jul 15 12:12:40 PDT 2003



 -- 




