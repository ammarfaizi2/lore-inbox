Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTDFGar (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 01:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbTDFGar (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 01:30:47 -0500
Received: from srv1.mail.cv.net ([167.206.112.40]:30703 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id S262839AbTDFGaq (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 01:30:46 -0500
Date: Sun, 06 Apr 2003 01:42:18 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Subject: Driver for PLX9052 based PCMCIA-to-PCI bridges
X-X-Sender: proski@localhost.localdomain
To: linux-kernel@vger.kernel.org
Cc: David Hinds <dhinds@sonic.net>
Message-id: <Pine.LNX.4.51.0304060011390.11914@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have written a driver for PLX9052 based PCMCIA-to-PCI bridges commonly
used in "PCI wireless cards" that consist of a PCMCIA wireless card and a
PCMCIA-to-PCI bridge.

Such "PCI" cards cost almost as much as PCMCIA cards, so the cost of the
bridge is essentially zero.  It's important to have support for hardware
that people can get almost for free.

Due to limitations of the chip, this driver doesn't support relocation of
memory or I/O windows.  It turns out some PCMCIA drivers really don't like
it (in particular pcnet-cs), so essentially this driver is just another
way to support PLX-based wireless cards that are already supported by
orinoco_plx.  The only upshot is that it's possible to swap cards without
doing anything with the driver.

However, if there is enough interest, the driver can be improved to
support more cards.  In particular, I think it's possible to put a memory
window after the CIS within the same PCI memory resource.

It's also important to have a driver that cannot relocate memory and I/O
(i.e. the one that uses io_offset and SS_CAP_STATIC_MAP).  There are
already two such drivers in the 2.4 tree: au1000_generic and
sa1100_generic.  They both are for embedded hardware.  Having a driver for
PC would make it easy to fix incompatible card drivers.

Since io_offset is used, this driver cannot be used with pcmcia-cs
drivers.

The driver and the documentation are here:
http://www.red-bean.com/~proski/plx9052/

-- 
Regards,
Pavel Roskin
