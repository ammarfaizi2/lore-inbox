Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbUCABKe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbUCABKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:10:34 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:60114 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262211AbUCABKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:10:24 -0500
Date: Mon, 1 Mar 2004 02:10:21 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-usb-users@lists.sourceforge.net
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.3/2.6.4-rc1/2.6-BK USB lockups with USB 1.1 scanner?
Message-ID: <20040301011021.GA3947@merlin.emma.line.org>
Mail-Followup-To: linux-usb-users@lists.sourceforge.net,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an Epson 1650 scanner (USB 1.1) and an Asus A7V600-X mainboard
with VIA KT600 chip set (which has a truckload of UCHI/EHCI ports), I'm
using sane-backends 1.0.13 with libusb (0.1.6a, came with SuSE 8.2; I
also tried SuSE 9.0's libusb 0.1.8beta).

With Linux 2.4 from BK (post-2.4.25) and FreeBSD 5-CURRENT, the scanner
works flawlessly, with recent Linux 2.6 BK tree versions (some days old
up to recent versions after the 2.6.4-rc1 tag), I'm getting scanner and
USB port lockups and processes that sometimes do not recover from their
"D"eep sleep process state, often right when starting the preview scan.

A different board, a Gigabyte 7ZXR with Via KT133 chipset and Linux
2.6.2 was fine with the same user-space, but is not available at the
moment.

I've tried toggling the enforced bandwidth allocation for USB devices,
it didn't help the situation either way.

Syslog from post-2.6.3 BK before 2.6.4-rc1 (fasten seat belts, this is
debugging stuff with long lines), followed by lspci -v excerpt:

I'm willing to help with further debugging, please send directions (URL
pointers are fine).

03:15:51 kernel: usb 3-1: usb_disable_device nuking non-ep0 URBs
03:15:51 kernel: usb 3-1: unregistering interface 3-1:1.0
03:15:51 kernel: drivers/usb/core/usb.c: usb_hotplug
03:15:51 kernel: No module symbols loaded - kernel modules not enabled. 
03:15:51 kernel: usb 3-1: registering 3-1:1.0 (config #1, interface 0)
03:15:51 kernel: drivers/usb/core/usb.c: usb_hotplug
03:15:51 kernel: usb 3-1: usb_disable_device nuking non-ep0 URBs
03:15:51 kernel: usb 3-1: unregistering interface 3-1:1.0
03:15:51 kernel: drivers/usb/core/usb.c: usb_hotplug
03:15:51 kernel: usb 3-1: registering 3-1:1.0 (config #1, interface 0)
03:15:51 kernel: drivers/usb/core/usb.c: usb_hotplug
03:15:53 kernel: usb 3-1: usb_disable_device nuking non-ep0 URBs
03:15:53 kernel: usb 3-1: unregistering interface 3-1:1.0
03:15:53 kernel: drivers/usb/core/usb.c: usb_hotplug
03:15:53 kernel: usb 3-1: registering 3-1:1.0 (config #1, interface 0)
03:15:53 kernel: drivers/usb/core/usb.c: usb_hotplug
03:15:55 kernel: uhci_hcd 0000:00:10.1: uhci_result_control: failed with status 440000
03:15:55 kernel: [c61bb2a0] link (061bb1e2) element (061d42c0)
03:15:55 kernel:   0: [c61d42c0] link (061d4300) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=01d3f7c0)
03:15:55 kernel:   1: [c61d4300] link (061d4340) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0d8bc000)
03:15:55 kernel:   2: [c61d4340] link (061d4380) e3 SPD Active Length=0 MaxLen=0 DT0 EndPt=0 Dev=2, PID=69(IN) (buf=0d8bc008)
03:15:55 kernel:   3: [c61d4380] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
03:15:55 kernel: 
03:15:55 kernel: usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
03:15:55 /etc/hotplug/usb.agent[15664]: cannot get config descriptor 0, Value too large for defined data type (75)
03:15:55 kernel: uhci_hcd 0000:00:10.1: uhci_result_control: failed with status 500000
03:15:55 kernel: [c61bb240] link (061bb1e2) element (061d40c0)
03:15:55 kernel:  Element != First TD
03:15:55 kernel:   0: [c61d4040] link (061d4080) e3 Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=01d3f7c0)
03:15:55 kernel:   1: [c61d4080] link (061d40c0) e3 Length=7 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0d8bc000)
03:15:55 kernel:   2: [c61d40c0] link (061d4100) e3 Stalled Babble Length=0 MaxLen=0 DT0 EndPt=0 Dev=2, PID=69(IN) (buf=0d8bc008)
03:15:55 kernel:   3: [c61d4100] link (061bb2d2) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
03:15:55 kernel: --Queued QH's:
03:15:55 kernel: [c61bb2d0] link (061bb1e2) element (061d4140)
03:15:55 kernel:   0: [c61d4140] link (061d43c0) e3 Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=05505640)
03:15:55 kernel:   1: [c61d43c0] link (061d4400) e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0dd72000)
03:15:55 kernel:   2: [c61d4400] link (061d4440) e3 SPD Active Length=0 MaxLen=0 DT0 EndPt=0 Dev=2, PID=69(IN) (buf=0dd72008)
03:15:55 kernel:   3: [c61d4440] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)
03:15:55 kernel: 
03:15:55 kernel: usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -75
03:15:55 kernel: usb 3-1: control timeout on ep0in
03:16:00 last message repeated 2 times
03:16:25 kernel: usb 3-1: bulk timeout on ep1out

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at 9000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at 8800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at 8400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at 8000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Flags: bus master, medium devsel, latency 32, IRQ 21
        Memory at eb800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2



-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
