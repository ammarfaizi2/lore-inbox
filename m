Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264131AbRFDHIS>; Mon, 4 Jun 2001 03:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264132AbRFDHIK>; Mon, 4 Jun 2001 03:08:10 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:32009 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S264131AbRFDHH7>; Mon, 4 Jun 2001 03:07:59 -0400
Date: Mon, 4 Jun 2001 03:07:56 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5-ac7 usb-uhci appears twice in /proc/interrupts
Message-ID: <Pine.LNX.4.33.0106040258200.2088-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I don't know, maybe it's Ok, but it looks confusing - usb-uhci is listed
twice on the same IRQ 9.

# cat /proc/interrupts
           CPU0
  0:      82287          XT-PIC  timer
  1:       2624          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci, usb-uhci
 10:        781          XT-PIC  eth0
 11:          0          XT-PIC  eth1
 12:        900          XT-PIC  PS/2 Mouse
 14:      17434          XT-PIC  ide0
 15:          9          XT-PIC  ide1
NMI:          0
LOC:      82250
ERR:         15

.config is here: http://www.red-bean.com/~proski/linux/config

In short, all USB stuff is compiled as modules.

# CONFIG_USB_UHCI is not set
CONFIG_USB_UHCI_ALT=m
# CONFIG_USB_OHCI is not set

It's a brand new VIA motherboard, so I don't know whether the problem
existed in the earlier kernels or not (if it's a problem).

It looks like that the motherboard has two USB controllers:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
00:08.0 Ethernet controller: 3Com Corporation 3c900 10BaseT [Boomerang]
00:09.0 Ethernet controller: Bridgecom, Inc: Unknown device 0985 (rev 11)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c)

-- 
Regards,
Pavel Roskin

