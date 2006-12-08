Return-Path: <linux-kernel-owner+w=401wt.eu-S1761052AbWLHSyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761052AbWLHSyf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761056AbWLHSyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:54:35 -0500
Received: from mx1.suse.de ([195.135.220.2]:45647 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761047AbWLHSye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:54:34 -0500
Date: Fri, 8 Dec 2006 10:54:19 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Marcel Holtmann <marcel@holtmann.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] HID patches for 2.6.19
Message-ID: <20061208185419.GA6912@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some patches that move the HID code to a new directory allowing
it to be used by other kernel subsystems easier.

This patch was approved by Dmitry, Marcel and myself, and Andrew asked
that I get this to you now to make merges with other parts of our
respective queues easier.

Many thanks to Jiri for taking the time and respinning these patches
multiple times as the tree has changed over the past few days.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full set of patches will be sent to the linux-usb-devel mailing
list, if anyone wants to see them.

thanks,

greg k-h

 CREDITS                                          |    8 +
 drivers/Kconfig                                  |    2 +
 drivers/Makefile                                 |    1 +
 drivers/hid/Kconfig                              |   18 +
 drivers/hid/Makefile                             |   15 +
 drivers/hid/hid-core.c                           | 1003 +++++++++++++++
 drivers/{usb/input => hid}/hid-input.c           |  151 +--
 drivers/input/Makefile                           |    1 +
 drivers/usb/input/Kconfig                        |   21 +-
 drivers/usb/input/Makefile                       |    3 -
 drivers/usb/input/hid-core.c                     | 1415 +++++-----------------
 drivers/usb/input/hid-ff.c                       |    8 +-
 drivers/usb/input/hid-lgff.c                     |    7 +-
 drivers/usb/input/hid-pidff.c                    |   58 +-
 drivers/usb/input/hid-tmff.c                     |    5 +-
 drivers/usb/input/hid-zpff.c                     |    7 +-
 drivers/usb/input/hiddev.c                       |   37 +-
 drivers/usb/input/usbhid.h                       |   84 ++
 {drivers/usb/input => include/linux}/hid-debug.h |    0 
 {drivers/usb/input => include/linux}/hid.h       |   86 +-
 20 files changed, 1584 insertions(+), 1346 deletions(-)
 create mode 100644 drivers/hid/Kconfig
 create mode 100644 drivers/hid/Makefile
 create mode 100644 drivers/hid/hid-core.c
 rename drivers/{usb/input/hid-input.c => hid/hid-input.c} (88%)
 create mode 100644 drivers/usb/input/usbhid.h
 rename drivers/usb/input/hid-debug.h => include/linux/hid-debug.h (100%)
 rename drivers/usb/input/hid.h => include/linux/hid.h (86%)

---------------

Jiri Kosina (8):
      Generic HID layer - disable USB HID
      Generic HID layer - code split
      Generic HID layer - API
      Generic HID layer - USB API
      Generic HID layer - hiddev
      Generic HID layer - input and event reporting
      Generic HID layer - pb_fnmode
      Generic HID layer - build

