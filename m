Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUEGUza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUEGUza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUEGUza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:55:30 -0400
Received: from ee.oulu.fi ([130.231.61.23]:54418 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263772AbUEGUzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:55:23 -0400
Date: Fri, 7 May 2004 23:55:17 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: linux-kernel@vger.kernel.org
cc: danlee@informatik.uni-freiburg.de, b-gruber@gmx.de,
       Mikael Hakali <mhakali@telia.com>
Subject: [PATCH] SERIO_USERDEV: direct userspace access to mouse/keyboard
 psaux serial ports
Message-ID: <Pine.GSO.4.58.0405072348120.21057@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Download:
wget http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.5-userdev.20040507.patch

This is the first public release of the patch, but it has been already
tested by a few people, so it should be stable.

I hope to get some more testers, and if no serious bugs are found, I really
would like this to get included into the mainstream kernel.

Snippet from the documentation:

SERIO_USERDEV - Direct serial input device access for userspace

This driver provides direct access from usespace into PS/2 (or psaux)
serial ports used usually for input devices such as mouses and keyboards.

The code is part of the serio module. It can be enabled or disabled
from kernel configuration
    Device Drivers -> Input device support -> User space driver support
if serial i/o support is enabled.

All available devices will be registered as miscellaneous
devices with major 10, minor dynamically allocated. The devices
with their minors will be listed in /proc/misc with isa0060/serio0
for keyboard and the rest for pointing devices. If devfs is enabled,
the device files will be created as /dev/misc/isa0060/serio*.

The created devices which are connected to a mouse can be usually
used in place of /dev/psaux which was used in 2.4.x kernels.
Therefore, you could do (if devfs is enabled):
    ln -s /dev/misc/isa0060/serio1 /dev/psaux
(or some other device) and run mouse drivers such as gpm and XFree86
just as with 2.4.x kernel.

Features:
- Both read and write support to all PS/2 ports. With active multiplexing,
  there will be five serial ports up to isa0060/serio4.
- Multiple readers supported, each reader will get copy of the complete stream.
  Write locking supported via special ioctl calls.

