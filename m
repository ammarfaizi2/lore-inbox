Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTDUPTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTDUPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:19:22 -0400
Received: from franka.aracnet.com ([216.99.193.44]:41892 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261329AbTDUPTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:19:19 -0400
Date: Mon, 21 Apr 2003 08:31:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: gregkh@us.ibm.com
Subject: [Bug 606] Hang occurs at reboot
Message-ID: <26850000.1050939064@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


------- Additional Comments From m4341@abc.se  2003-04-21 02:30 -------
All three suggestions are tried, but I have located the problem to the ohci-hcd
module, since I also get a hang when I trie to unload that module. This is
currently only verified on the Vectra using the Kernel 2.5.68.

Dmesg info (partial):
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 00:0c.0: Lucent Microelectron USS-312 USB Controll
ohci-hcd 00:0c.0: irq 11, pci mem cd007000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ohci-hcd 00:0c.0: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver

lsmod info (minimalistic):
Module                  Size  Used by
binfmt_misc             9508  0 
parport_pc             15428  0 
parport                28992  1 parport_pc
hid                    41060  0 
ohci_hcd               13088  0 
usbcore                81364  4 hid,ohci_hcd


