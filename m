Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbRAEDwy>; Thu, 4 Jan 2001 22:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRAEDwf>; Thu, 4 Jan 2001 22:52:35 -0500
Received: from foobar.napster.com ([64.124.41.10]:59919 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S130614AbRAEDwW>; Thu, 4 Jan 2001 22:52:22 -0500
Message-ID: <3A5544EF.CF41B6A8@napster.com>
Date: Thu, 04 Jan 2001 19:52:15 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jerdfelt@valinux.com
CC: usb@in.tum.de, linux-kernel@vger.kernel.org
Subject: USB problems with 2.4.0: USBDEVFS_BULK failed
Content-Type: multipart/mixed;
 boundary="------------2BAB3D84A20E45D218F3A651"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2BAB3D84A20E45D218F3A651
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Alright, this is driving me nuts. I have a Canon S20 digital camera
hooked up to a Sony XG series laptop via the USB port and am using s10sh
to access it. s10sh uses libusb 0.1.1, but I've also tried it using
libusb 0.1.2 without any luck. libusb uses usbfs to access to the device
from userspace. 

The last time it worked was around 2.4.0test10, but might have been
test9. test12, prerelease and 2.4.0 final all fail.

I've compiled the uhci driver with debugging. The log starts before I
send the file transfer request to the camera and ends after the camera
blows up and disconnects itself. This was done using 2.4.0 final.

I have also included a protocol dump from s10sh, recorded during a
second attempt. It looks like s10sh might strip header bytes from the
log, but it should help somewhat.

Now as far as I can tell, we submit a bulk transfer request and start
reading. We want to read 2872 bytes (44 @ 64 bytes, 1 @ 56 bytes). We
read off 44 @ 64 bytes, but for some reason don't read off the last 56
bytes and a babble is detected.


Jordan
--------------2BAB3D84A20E45D218F3A651
Content-Type: text/plain; charset=us-ascii;
 name="kern.log.after"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kern.log.after"

Jan  4 18:06:29 u2 kernel: klogd 1.3-3#33.1, log source = /proc/kmsg started.
Jan  4 18:06:29 u2 kernel: Inspecting /boot/System.map-2.4.0
Jan  4 18:06:29 u2 kernel: Loaded 13430 symbols from /boot/System.map-2.4.0.
Jan  4 18:06:29 u2 kernel: Symbols match kernel version 2.4.0.
Jan  4 18:06:29 u2 kernel: Loaded 145 symbols from 6 modules.
Jan  4 18:06:32 u2 kernel: usb-uhci.c: search_dev_ep:
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduling cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_control start
Jan  4 18:06:32 u2 kernel: usb-uhci.c: Allocated qh @ c43809e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_control end
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduled with ret: 0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: interrupt
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:8 status:38000007 mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:32 status:3800001f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:32 status:3800001f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:32 status:3800001f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:22 status:38000015 mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:0 status:190007ff mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_clean_transfer: No more bulks for urb cf2cfba0, qh c43809e0, bqh 00000000, nqh 00000000
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink qh c43809e0, pqh c4380720, nxqh c43806e0, to 043806e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: (end) urb cf2cfba0, wanted len 118, len 118 status 0 err 0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: dequeued urb: cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380e20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380de0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ee0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: search_dev_ep:
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduling cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_bulk_urb: urb cf2cfba0, old 00000000, pipe c0008280, len 64
Jan  4 18:06:32 u2 kernel: usb-uhci.c: Allocated qh @ c4380aa0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_bulk: qh c4380aa0 bqh 00000001 nqh c02595f2
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduled with ret: 0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: interrupt
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3900003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_clean_transfer: No more bulks for urb cf2cfba0, qh c4380aa0, bqh 00000000, nqh 00000000
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink qh c4380aa0, pqh c43806e0, nxqh c4380660, to 04380660
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: (end) urb cf2cfba0, wanted len 64, len 64 status 0 err 0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: dequeued urb: cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380e60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380d60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ea0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380d20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380f20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380da0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: search_dev_ep:
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduling cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_bulk_urb: urb cf2cfba0, old 00000000, pipe c0008280, len 2872
Jan  4 18:06:32 u2 kernel: usb-uhci.c: Allocated qh @ c43809e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_bulk: qh c43809e0 bqh 00000001 nqh c02595f2
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduled with ret: 0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: interrupt
Jan  4 18:06:32 u2 kernel: usb-uhci.c: interrupt, status 3, frame# 1648
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:64 status:3800003f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_clean_transfer: No more bulks for urb cf2cfba0, qh c43809e0, bqh 00000000, nqh 00000000
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink qh c43809e0, pqh c43806e0, nxqh c4380660, to 04380660
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: (end) urb cf2cfba0, wanted len 2872, len 2872 status ffffffe0 err 1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: dequeued urb: cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ee0
Jan  4 18:06:32 u2 kernel: usbdevfs: USBDEVFS_BULK failed dev 2 ep 0x81 len 2872 ret -32
Jan  4 18:06:32 u2 kernel: usb-uhci.c: interrupt
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380da0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380f20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380d20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ea0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380d60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380e60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380de0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380e20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380be0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380a60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380a20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ce0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ca0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380c60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380c20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380b60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ae0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380b20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380f60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380fa0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f120
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f160
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f1a0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f1e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f220
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f260
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f2a0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f2e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f320
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f360
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f3a0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f3e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f420
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f460
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f4a0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f4e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f520
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f560
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f5a0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f5e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f620
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f660
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f6a0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c2a5f6e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: search_dev_ep:
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduling cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_control start
Jan  4 18:06:32 u2 kernel: usb-uhci.c: Allocated qh @ c43809e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_control end
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduled with ret: 0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: interrupt
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:8 status:38000007 mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:32 status:3800001f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:32 status:3800001f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:32 status:3800001f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:18 status:38000011 mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:0 status:190007ff mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_clean_transfer: No more bulks for urb cf2cfba0, qh c43809e0, bqh 00000000, nqh 00000000
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink qh c43809e0, pqh c4380720, nxqh c43806e0, to 043806e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: (end) urb cf2cfba0, wanted len 114, len 114 status 0 err 0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: dequeued urb: cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: search_dev_ep:
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduling cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduled with ret: -32
Jan  4 18:06:32 u2 kernel: usbdevfs: USBDEVFS_BULK failed dev 2 ep 0x81 len 84 ret -32
Jan  4 18:06:32 u2 kernel: usb-uhci.c: search_dev_ep:
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduling cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_control start
Jan  4 18:06:32 u2 kernel: usb-uhci.c: Allocated qh @ c4380c20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_submit_control end
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduled with ret: 0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: interrupt
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:8 status:38000007 mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:32 status:3800001f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:32 status:3800001f mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:32 status:3800001f mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:22 status:38000015 mapped:0 toggle:0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: len:0 status:190007ff mapped:0 toggle:1
Jan  4 18:06:32 u2 kernel: usb-uhci.c: uhci_clean_transfer: No more bulks for urb cf2cfba0, qh c4380c20, bqh 00000000, nqh 00000000
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink qh c4380c20, pqh c4380720, nxqh c43806e0, to 043806e0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: process_transfer: (end) urb cf2cfba0, wanted len 118, len 118 status 0 err 0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: dequeued urb: cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380fa0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380f60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380b20
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ae0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380ba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: unlink td @ c4380b60
Jan  4 18:06:32 u2 kernel: usb-uhci.c: search_dev_ep:
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduling cf2cfba0
Jan  4 18:06:32 u2 kernel: usb-uhci.c: submit_urb: scheduled with ret: -32
Jan  4 18:06:32 u2 kernel: usbdevfs: USBDEVFS_BULK failed dev 2 ep 0x81 len 64 ret -32
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub INT complete: port1: 8a port2: 80 data: 2
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub: adr:  1 cmd(8): 00a3 0000 0001 0004
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub stat port1: 8a port2: 80
Jan  4 18:06:42 u2 kernel: hub.c: port 1 connection change
Jan  4 18:06:42 u2 kernel: hub.c: port 1, portstatus 100, change 3, 12 Mb/s
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub: adr:  1 cmd(8): 0123 0010 0001 0000
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub stat port1: 88 port2: 80
Jan  4 18:06:42 u2 kernel: usb.c: USB disconnect on device 2
Jan  4 18:06:42 u2 kernel: usb.c: kusbd: /sbin/hotplug remove 2
Jan  4 18:06:42 u2 kernel: usb.c: kusbd policy returned 0xfffffffe
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub: adr:  1 cmd(8): 00a3 0000 0002 0004
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub stat port1: 88 port2: 80
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub: adr:  1 cmd(8): 00a0 0000 0000 0004
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub stat port1: 88 port2: 80
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub INT complete: port1: 88 port2: 80 data: 2
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub: adr:  1 cmd(8): 00a3 0000 0001 0004
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub stat port1: 88 port2: 80
Jan  4 18:06:42 u2 kernel: hub.c: port 1 enable change, status 100
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub: adr:  1 cmd(8): 0123 0011 0001 0000
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub stat port1: 80 port2: 80
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub: adr:  1 cmd(8): 00a3 0000 0002 0004
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub stat port1: 80 port2: 80
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub: adr:  1 cmd(8): 00a0 0000 0000 0004
Jan  4 18:06:42 u2 kernel: usb-uhci.c: Root-Hub stat port1: 80 port2: 80

--------------2BAB3D84A20E45D218F3A651
Content-Type: text/plain; charset=us-ascii;
 name="s10sh.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s10sh.log"

[Canon PowerShot S20] D:\dcim\102canon> getall
WRITE CONTROL MSG, value 10, size 118: OK
DATA: (118 bytes)
00000000: 36 00 00 00 02 02 00 00 00 00 00 00 00 00 00 00 - 6...............
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000040: 02 00 00 00 01 00 00 11 36 00 00 00 01 00 00 00 - ........6.......
00000050: 00 00 00 00 00 14 00 00 44 3A 5C 64 63 69 6D 5C - ........D:\dcim\
00000060: 31 30 32 63 61 6E 6F 6E 5C 49 4D 47 5F 30 32 36 - 102canon\IMG_026
00000070: 34 2E 4A 50 47 00                               - 4.JPG.

USB READ: OK (40)
DATA: (64 bytes)
00000000: 00 00 00 00 02 03 38 5F 0B 00 00 00 00 00 00 00 - ......8_........
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................

Getting D:\dcim\102canon\IMG_0264.JPG, 745272 bytes
0------------------25------------------50------------------75----------------100USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.USB READ: FAILED (FFFFFFFF)
USB READ: FAILED (FFFFFFFF)
.
Downloaded in 1 seconds, 745272 bytes/s

WRITE CONTROL MSG, value 10, size 114: OK
DATA: (114 bytes)
00000000: 32 00 00 00 01 02 00 00 00 00 00 00 00 00 00 00 - 2...............
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000040: 02 00 00 00 0E 00 00 11 32 00 00 00 01 00 00 00 - ........2.......
00000050: 00 00 00 00 44 3A 5C 64 63 69 6D 5C 31 30 32 63 - ....D:\dcim\102c
00000060: 61 6E 6F 6E 5C 49 4D 47 5F 30 32 36 34 2E 4A 50 - anon\IMG_0264.JP
00000070: 47 00                                           - G.

USB READ: FAILED (FFFFFFFF)

WRITE CONTROL MSG, value 10, size 118: OK
DATA: (118 bytes)
00000000: 36 00 00 00 02 02 00 00 00 00 00 00 00 00 00 00 - 6...............
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 - ................
00000040: 02 00 00 00 01 00 00 11 36 00 00 00 01 00 00 00 - ........6.......
00000050: 00 00 00 00 00 14 00 00 44 3A 5C 64 63 69 6D 5C - ........D:\dcim\
00000060: 31 30 32 63 61 6E 6F 6E 5C 49 4D 47 5F 30 32 36 - 102canon\IMG_026
00000070: 35 2E 4A 50 47 00                               - 5.JPG.

USB READ: FAILED (FFFFFFFF)
malloc: Cannot allocate memory

--------------2BAB3D84A20E45D218F3A651--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
