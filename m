Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWIPJhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWIPJhg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 05:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWIPJhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 05:37:36 -0400
Received: from mx02.qsc.de ([213.148.130.14]:13264 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S964829AbWIPJhf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 05:37:35 -0400
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCODE
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: USB device stopped working -  can't set config #1, error -71
Date: Sat, 16 Sep 2006 11:37:14 +0200
User-Agent: KMail/1.9.4
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609161137.14307.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi all, with the latest kernels (definetly 2.6.17 and
	1.6.8-rc*, I do now know off hand when this started) I can not access
	some (I think all USB 1) scanners via my SANE/Avision backend: usb 3-1:
	new full speed USB device using uhci_hcd and address 2 usb 3-1:
	configuration #1 chosen from 1 choice usb 3-1: can't set config #1,
	error -71 [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

with the latest kernels (definetly 2.6.17 and 1.6.8-rc*, I do now know off 
hand when this started) I can not access some (I think all USB 1) scanners 
via my SANE/Avision backend:

usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: can't set config #1, error -71

write(2, "attach: opening libusb:003:002\n", 31) = 31
open("/proc/bus/usb/003/002", O_RDWR)   = 4
ioctl(4, USBDEVFS_SETCONFIGURATION, 0xbfc10c74) = -1 EPROTO (Protocol error)
close(4)                                = 0
fstat64(2, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 1), ...}) = 0
write(2, "[avision] ", 10)              = 10
write(2, "attach: open failed (Invalid arg"..., 39) = 39

Currently this is on an x86 Apple MacBook:

Bus 005 Device 002: ID 05ac:1000 Apple Computer
Bus 005 Device 001: ID 0000:0000 Virtual Hub
Bus 004 Device 002: ID 05ac:8240 Apple Computer
Bus 004 Device 001: ID 0000:0000 Virtual Hub
Bus 003 Device 001: ID 0000:0000 Virtual Hub
Bus 002 Device 002: ID 05ac:0218 Apple Computer
Bus 002 Device 001: ID 0000:0000 Virtual Hub
Bus 001 Device 009: ID 05ac:020c Apple Computer
Bus 001 Device 008: ID 046d:c00c Logitech Inc. Optical Wheel Mouse
Bus 001 Device 007: ID 05ac:1003 Apple Computer
Bus 001 Device 004: ID 05ac:8300 Apple Computer
Bus 001 Device 002: ID 05e3:0606 Genesys Logic, Inc.
Bus 001 Device 001: ID 0000:0000 Virtual Hub

While this simple lsusb is enough to trigger the issue:

usb 3-1: new full speed USB device using uhci_hcd and address 3
usb 3-1: configuration #1 chosen from 1 choice
usb 3-1: can't set config #1, error -71

And the affected devices do not appear in the lsusb output.

Btw: I saw a patch related to usb1 devics behind usb2 hubs, but
I think it made no difference here.

Btw2: I also do not see the standard bluetooth USB HCI that is suppost to be 
in the MacBook and that is listed and works fine in OS X.

Yours,

-- 
  René Rebe - ExactCODE - Berlin (Europe / Germany)
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
  +49 (0)30 / 255 897 45
