Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317780AbSFMROP>; Thu, 13 Jun 2002 13:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317781AbSFMROO>; Thu, 13 Jun 2002 13:14:14 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:57278 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317780AbSFMRON> convert rfc822-to-8bit; Thu, 13 Jun 2002 13:14:13 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-)
To: linux-kernel@vger.kernel.org
Subject: USB Problems with 2.4.19-pre10-ac2
Date: Thu, 13 Jun 2002 19:16:16 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206131916.16214.knobi@knobisoft.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 on connecting an Olympus 2100UZ camera via USB for use with gphoto2
I get the following messages from the kernel:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 18:05:42 Jun 13 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/2, assigned device number 2
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: USB new device connect on bus1/2, assigned device number 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)


 Suspicious are the "usb_control/bulk_msg: timeout" messages and the "not 
accepting" stuff. Same happens with the uhci.o module. The camera works with 
the 2.4.18-4GB kernel from SuSE8.0. So I suspect some problems with 
2.4.19-pre10-ac2. Unfortunatelly I cannot build 2.4.19-pre10 alone, due to 
compilation errors.

Any idea? System in question is based on the VIA KT333 chipset, with an 
xp2100+ CPU.

# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Subsystem: VIA Technologies, Inc. VT8367 [KT266]
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        Capabilities: [80] Power Management version 2

00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 
74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management 
NIC
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d000 [size=128]
        Memory at e7000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
        Subsystem: VIA Technologies, Inc.: Unknown device 3147
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 
8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 
[UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 
[UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 40)
        Subsystem: Realtek Semiconductor Co., Ltd.: Unknown device 4710
        Flags: medium devsel, IRQ 5
        I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0171 
(rev a3) (prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
        Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Memory at d8000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

Thanks
Martin
-- 
----------------------------------
Martin Knoblauch
knobi@knobisoft.de
http://www.knobisoft.de
