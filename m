Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269700AbTGULrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269706AbTGULrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:47:17 -0400
Received: from port-212-202-170-48.reverse.qdsl-home.de ([212.202.170.48]:14474
	"EHLO schillernet.dyndns.org") by vger.kernel.org with ESMTP
	id S269700AbTGULrO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:47:14 -0400
Date: Mon, 21 Jul 2003 14:02:11 +0200 (CEST)
Message-Id: <20030721.140211.1025212529.rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Lars Kuhtz <kuhtz@informatik.hu-berlin.de>
Subject: 2.4.21 and 2.6.0-test1 USB subsystem problem with HID mouse and
 ohci
From: Rene Rebe <rene.rebe@gmx.net>
X-Mailer: Mew version 3.3rc2 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

we experience a problem with a new USB mouse and the ohci driver, in
all recent kernels:

In both 2.4.x and 2.5.x the other USB devices work normally - until
the mouse is plugged in. Plugging in the mouse causes all usb-devices
to stop to work.  Removing the mouse does not change anything. The
usb-devices stay nonfunctional. This is the same for 2.4.21 and 2.4.69
kernel's independently if I use uhci or usb-uhci (under 2.4.21).

Under 2.4.x it is possible to rmmod the usb modules and reload them to
get the devices, except the mouse, to normal function (if the mouse it
not present - if the mouse is present during boot or module load the
usb-subsystem is unfunctional - until the mouse is unplugged and the
modules reloaded) . But in e.g 2.5.69 removing the module causes
modprobe -r / rmmod to hang in such a way that even killing with -9
does not work.

(For some strange reason the BIOS USB PS/2 emulation works fine for
this mouse under Linux-2.5.69 - events come out of /dev/misc/psaux -
until of course the USB modules are loaded).

Although the log is from kernel version 2.5.71 - it still appears with
kernel 2.6.0-test1.

Other USB mices work normally - and this moused also does work on
Windows systems and on some 2.5/6 system with usb-ohci (on a SiS
chipset).

The logmessages of the usb-system follow:

Jun 23 19:34:32 calvin kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Jun 23 19:34:32 calvin kernel: uhci-hcd 0000:00:04.2: VIA Technologies, In USB
Jun 23 19:34:32 calvin kernel: uhci-hcd 0000:00:04.2: irq 9, io base 0000d400
Jun 23 19:34:32 calvin kernel: Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
Jun 23 19:34:32 calvin kernel: uhci-hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
Jun 23 19:34:32 calvin kernel: drivers/usb/host/uhci-hcd.c: detected 2 ports
Jun 23 19:34:32 calvin kernel: usb usb1: Product: VIA Technologies, In USB
Jun 23 19:34:32 calvin kernel: usb usb1: Manufacturer: Linux 2.5.71 uhci-hcd
Jun 23 19:34:32 calvin kernel: usb usb1: SerialNumber: 00:04.2
Jun 23 19:34:32 calvin kernel: hub 1-0:0: USB hub found
Jun 23 19:34:32 calvin kernel: hub 1-0:0: 2 ports detected
Jun 23 19:34:32 calvin kernel: uhci-hcd 0000:00:04.3: VIA Technologies, In USB (#2)
Jun 23 19:34:32 calvin kernel: uhci-hcd 0000:00:04.3: irq 9, io base 0000d000
Jun 23 19:34:32 calvin kernel: uhci-hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
Jun 23 19:34:32 calvin kernel: drivers/usb/host/uhci-hcd.c: detected 2 ports
Jun 23 19:34:32 calvin kernel: usb usb2: Product: VIA Technologies, In USB (#2)
Jun 23 19:34:32 calvin kernel: usb usb2: Manufacturer: Linux 2.5.71 uhci-hcd
Jun 23 19:34:32 calvin kernel: usb usb2: SerialNumber: 00:04.3
Jun 23 19:34:32 calvin kernel: hub 2-0:0: USB hub found
Jun 23 19:34:32 calvin kernel: hub 2-0:0: 2 ports detected
Jun 23 19:34:33 calvin kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
Jun 23 19:34:33 calvin kernel: hub 1-0:0: new USB device on port 1, assigned address 2
Jun 23 19:34:33 calvin kernel: hub 1-1:0: USB hub found
Jun 23 19:34:33 calvin kernel: hub 1-1:0: 5 ports detected
Jun 23 19:34:33 calvin kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
Jun 23 19:34:33 calvin kernel: hub 1-0:0: new USB device on port 2, assigned address 3
Jun 23 19:34:36 calvin kernel: usb 1-2: Product: ELSA Modem Board
Jun 23 19:34:36 calvin kernel: usb 1-2: Manufacturer: Lucent Technologies, Inc.
Jun 23 19:34:37 calvin kernel: drivers/usb/class/cdc-acm.c: ttyACM0: USB ACM device
Jun 23 19:34:38 calvin kernel: hub 1-1:0: debounce: port 3: delay 100ms stable 4 status 0x101
Jun 23 19:34:38 calvin kernel: hub 1-1:0: new USB device on port 3, assigned address 4
Jun 23 19:34:38 calvin kernel: usb 1-1.3: Product: Kyocera Mita FS-1010
Jun 23 19:34:38 calvin kernel: usb 1-1.3: Manufacturer: Kyocera Mita
Jun 23 19:34:38 calvin kernel: usb 1-1.3: SerialNumber: XAL1Z37546
Jun 23 19:34:39 calvin kernel: hub 1-1:0: debounce: port 4: delay 100ms stable 4 status 0x101
Jun 23 19:34:39 calvin kernel: hub 1-1:0: new USB device on port 4, assigned address 5
Jun 23 19:34:39 calvin kernel: input: USB HID v1.00 Keyboard [046a:0001] on usb-00:04.2-1.4
Jun 23 19:34:52 calvin login(pam_unix)[307]: session opened for user root by LOGIN(uid=0)
Jun 23 19:34:52 calvin login[307]: ROOT LOGIN  on `vc/2'
Jun 23 19:54:04 calvin -- MARK --
Jun 23 19:57:57 calvin kernel: hub 1-1:0: debounce: port 2: delay 100ms stable 4 status 0x301
Jun 23 19:57:57 calvin kernel: hub 1-1:0: new USB device on port 2, assigned address 6
Jun 23 19:57:57 calvin kernel: usb 1-1.2: Product: Cypress Ultra Mouse
Jun 23 19:57:57 calvin kernel: usb 1-1.2: Manufacturer: Cypress Semi.
Jun 23 19:57:57 calvin kernel: [c64782d0] link (064781b2) element (064790c0)
Jun 23 19:57:57 calvin kernel:  Element != First TD
Jun 23 19:57:57 calvin kernel:   0: [c6479090] link (064790c0) e3 LS Length=7 MaxLen=7 DT0 EndPt=0 Dev=6, PID=2d(SETUP) (buf=06470100)
Jun 23 19:57:57 calvin kernel:   1: [c64790c0] link (064790f0) e3 LS Stalled Babble Length=0 MaxLen=0 DT1 EndPt=0 Dev=6, PID=69(IN) (buf=06470120)
Jun 23 19:57:57 calvin kernel:   2: [c64790f0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=6, PID=e1(OUT) (buf=00000000)
Jun 23 19:57:57 calvin kernel: 
Jun 23 19:57:57 calvin kernel: drivers/usb/input/hid-core.c: ctrl urb status -75 received
Jun 23 19:58:02 calvin kernel: drivers/usb/core/message.c: usb_control/bulk_msg: timeout

Just tell us if you need any other information or specially compiled
debug mode to track down this problem.

Sincerely yours,
  René Rebe

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene.rebe@gmx.net
http://www.rocklinux.org http://www.rocklinux.org/people/rene       
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene

