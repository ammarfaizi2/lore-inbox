Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKIAf4>; Wed, 8 Nov 2000 19:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQKIAfp>; Wed, 8 Nov 2000 19:35:45 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:50215 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129171AbQKIAfk>; Wed, 8 Nov 2000 19:35:40 -0500
Message-ID: <3A09F158.910C925@linux.com>
Date: Wed, 08 Nov 2000 16:35:36 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [bug] usb-uhci locks up on boot half the time
Content-Type: multipart/mixed;
 boundary="------------5B48C2D9F677BE587E1AF21B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5B48C2D9F677BE587E1AF21B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ok, in test10, for every 2 out of 5 boots, this particular workstation
locks up hard as it reaches the following:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.242 $ time 15:53:47 Nov 8 2000
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 9
usb-uhci.c: Detected 2 ports
<locks here, hard reset required>

In test11, it locks up two lines earlier, right after 'enabled'

The normal sequence is:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.242 $ time 15:53:47 Nov  8 2000
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
usb.c: registered new driver dc2xx
usb.c: registered new driver dsbr100
usb.c: registered new driver usb-storage


It's a pII 300, not overclocked, ASUS P3BF motherboard.

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 7190
        Flags: bus master, medium devsel, latency 64
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03)
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: cb800000-cdefffff
        Prefetchable memory behind bridge: cff00000-cfffffff

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at b800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at b400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel

00:09.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c875 (rev 14)
        Subsystem: Diamond Multimedia Systems FirePort 40 Dual SCSI
Controller
        Flags: bus master, medium devsel, latency 144, IRQ 9
        I/O ports at b000 [size=256]
        Memory at cb000000 (32-bit, non-prefetchable) [size=256]
        Memory at ca800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c875 (rev 14)
        Subsystem: Diamond Multimedia Systems FirePort 40 Dual SCSI
Controller
        Flags: bus master, medium devsel, latency 144, IRQ 9
        I/O ports at a800 [size=256]
        Memory at ca000000 (32-bit, non-prefetchable) [size=256]
        Memory at c9800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet] (rev 11)
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at a400 [size=128]
        Memory at c9000000 (32-bit, non-prefetchable) [size=128]

00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W
[Millennium II]
        Subsystem: Matrox Graphics, Inc.: Unknown device 051b
        Flags: medium devsel, IRQ 10
        Memory at ce000000 (32-bit, prefetchable) [disabled] [size=16M]
        Memory at c8800000 (32-bit, non-prefetchable) [disabled]
[size=16K]
        Memory at c8000000 (32-bit, non-prefetchable) [disabled]
[size=8M]
        Expansion ROM at cdff0000 [disabled] [size=64K]

00:0c.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: Voyetra Technologies: Unknown device 6003
        Flags: bus master, slow devsel, latency 32, IRQ 11
        Memory at c7800000 (32-bit, non-prefetchable) [size=4K]
        Memory at c7000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

00:0d.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
[Boomerang]
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at a000 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c)
        Subsystem: ATI Technologies Inc: Unknown device 4742
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 11
        Memory at cc000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at d800 [size=256]
        Memory at cb800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at cffe0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0


# cat /proc/interrupts
           CPU0
  0:      37974          XT-PIC  timer
  1:         16          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        735          XT-PIC  eth0
  8:          0          XT-PIC  rtc
  9:       6135          XT-PIC  sym53c8xx, sym53c8xx, usb-uhci, acpi
 13:          0          XT-PIC  fpu
 15:         61          XT-PIC  ide1
NMI:          0
ERR:          0

# grep "^CONFIG.*USB" /boot/config
CONFIG_VIDEO_CPIA_USB=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=y
CONFIG_USB_DC2XX=y
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_DSBR=y
CONFIG_USB_HID=y


--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------5B48C2D9F677BE587E1AF21B
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------5B48C2D9F677BE587E1AF21B--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
