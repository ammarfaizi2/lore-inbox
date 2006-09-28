Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161328AbWI1WJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161328AbWI1WJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161329AbWI1WJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:09:39 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:212 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S1161328AbWI1WJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:09:38 -0400
Date: Fri, 29 Sep 2006 00:08:52 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Greg KH <gregkh@suse.de>, Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.18
Message-ID: <20060928220852.GA24043@aepfle.de>
References: <20060927200626.GA10018@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060927200626.GA10018@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, Greg KH wrote:

> Alan Stern:

>       usbcore: remove usb_suspend_root_hub

This change between -git8 and -git9 makes my keyboard unhappy:

@@ -16,7 +16,7 @@
 htab_address                  = 0xc00000007c000000
 htab_hash_mask                = 0x3ffff
 -----------------------------------------------------
-Linux version 2.6.18-g5-g01d883d4 (olaf@g5) (gcc version 4.1.0 (SUSE Linux)) #56 SMP Fri Sep 29 00:01:23 CEST 2006
+Linux version 2.6.18-g5-g02c399ee (olaf@g5) (gcc version 4.1.0 (SUSE Linux)) #55 SMP Thu Sep 28 23:58:26 CEST 2006
 [boot]0012 Setup Arch
 Entering add_active_range(0, 0, 524288) 0 entries of 256 used
 Found U4-PCIE PCI host bridge.  Firmware bus number: 0->255
@@ -256,28 +256,13 @@
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 Freeing unused kernel memory: 204k freed
-ohci_hcd 0001:01:0b.1: wakeup
 ieee1394: Host added: ID:BUS[0-01:1023]  GUID[001451fffea8daae]
-usb 3-1: new full speed USB device using ohci_hcd and address 2
 windfarm: CPUs control loops started.
-usb 3-1: configuration #1 chosen from 1 choice
-hub 3-1:1.0: USB hub found
-hub 3-1:1.0: 3 ports detected
-usb 3-1.2: new low speed USB device using ohci_hcd and address 3
-usb 3-1.2: configuration #1 chosen from 1 choice
-input: Mitsumi Electric Apple Optical USB Mouse as /class/input/input0
-input: USB HID v1.10 Mouse [Mitsumi Electric Apple Optical USB Mouse] on usb-0001:01:0b.1-1.2
 sat 0 partition c8: c8 6 2 7f ff 2 ff 1 fb bf 0 41 0 20 0 0 0 7 89 37 0 a0 0 0
-usb 3-1.3: new full speed USB device using ohci_hcd and address 4
-usb 3-1.3: configuration #1 chosen from 1 choice
-input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input1
-input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:01:0b.1-1.3
-input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input2
-input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:01:0b.1-1.3
-ioctl32(showconsole:718): Unknown cmd fd(0) cmd(40045432){00} arg(ffe1bb18) on /dev/console
+ioctl32(showconsole:712): Unknown cmd fd(0) cmd(40045432){00} arg(ffff8b18) on /dev/console
 sat 0 partition c4: c4 4 1 7f 22 11 e0 e6 ff 55 7b 12 ec 11 0 0
 Adding 1048568k swap on /dev/sdb3.  Priority:-1 extents:1 across:1048568k
-ioctl32(showconsole:745): Unknown cmd fd(0) cmd(40045432){00} arg(ffe6daa8) on /dev/console (deleted)
+ioctl32(showconsole:739): Unknown cmd fd(0) cmd(40045432){00} arg(ff9d7aa8) on /dev/console (deleted)
 sat 0 partition c9: c9 6 2 7f ff 2 ff 1 fb bf 0 41 0 20 0 0 0 7 89 37 0 a0 0 0
 sat 0 partition c5: c5 4 1 7f 22 11 e0 e6 ff 55 7b 12 ec 11 0 0
 windfarm: Backside control loop started.


git-bisect start
# good: [cdb8355add9b1d87ecfcb58b12879897dc1e3e36] Merge branch 'release' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6
git-bisect good cdb8355add9b1d87ecfcb58b12879897dc1e3e36
# bad: [a77c64c1a641950626181b4857abb701d8f38ccc] Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6
git-bisect bad a77c64c1a641950626181b4857abb701d8f38ccc
# good: [14acdcd32160767d7f2fa00803d2d764d3e3373a] USB: usb/input/usbmouse.c: whitespace cleanup
git-bisect good 14acdcd32160767d7f2fa00803d2d764d3e3373a
# good: [8aca23103c2ed2cf158adbe92f4f17ee69463d1a] Make PC300 WAN driver compile again
git-bisect good 8aca23103c2ed2cf158adbe92f4f17ee69463d1a
# bad: [a5c66e4b2418278786a025a5bd9625f485b2087a] USB: ftdi-elan: client driver for ELAN Uxxx adapters
git-bisect bad a5c66e4b2418278786a025a5bd9625f485b2087a
# bad: [1ee95216c0db6305c047a90b0822e2f1d2d5acdc] USB: fix __must_check warnings in drivers/usb/host/
git-bisect bad 1ee95216c0db6305c047a90b0822e2f1d2d5acdc
# bad: [592fbbe4bc339399d363dd55f0391e0623400706] USB: fix root-hub resume when CONFIG_USB_SUSPEND is not set
git-bisect bad 592fbbe4bc339399d363dd55f0391e0623400706
# good: [645daaab0b6adc35c1838df2a82f9d729fdb1767] usbcore: add autosuspend/autoresume infrastructure
git-bisect good 645daaab0b6adc35c1838df2a82f9d729fdb1767
# bad: [02c399ee45a54987c152fe5f627ed949bb55f187] usbcore: remove usb_suspend_root_hub
git-bisect bad 02c399ee45a54987c152fe5f627ed949bb55f187
# good: [01d883d44a1ca8dc77486635d428cba63e7fdadf] usbcore: non-hub-specific uses of autosuspend
git-bisect good 01d883d44a1ca8dc77486635d428cba63e7fdadf

