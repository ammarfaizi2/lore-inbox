Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267231AbTAKOep>; Sat, 11 Jan 2003 09:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267232AbTAKOep>; Sat, 11 Jan 2003 09:34:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:28300 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267231AbTAKOeo>;
	Sat, 11 Jan 2003 09:34:44 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 11 Jan 2003 15:43:27 +0100 (MET)
Message-Id: <UTC200301111443.h0BEhRZ06262.aeb@smtp.cwi.nl>
To: mochel@osdl.org
Subject: sysfs
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday evening I wrote a trivial utility fd ("find device")
that gives the contents of sysfs. Mostly in order to see what
name the memory stick card reader has today.

I wondered about several things.
Is there a description of the intended hierachy, so that one can
compare present facts with intention?

In /sysfs/devices I see
1:0:6:0  2:0:0:1  2:0:0:3  3:0:0:1  4:0:0:0  4:0:0:2   ide0  legacy  sys
2:0:0:0  2:0:0:2  3:0:0:0  3:0:0:2  4:0:0:1  ide-scsi  ide1  pci0
many SCSI devices and some subdirectories.
Would it not be better to have subdirectories scsiN just like ideN?
One can have SCSI hosts, even when presently no devices are connected.

There are links back and forth between block and bus, so that
/sysfs/block/sda/device points at devices/1:0:6:0 and
/sysfs/devices/1:0:6:0/block points at block/sda. Good.
In the case my device is a USB device I tend to first look
at VendorID and ProductID. But it seems there are no pointers
from /sysfs/block or /sysfs/devices to the usb device hierachy.

Now /sysfs/devices/pci0/00:07.2/usb1/1-2/1-2.4/1-2.4.4
is the fourth device on some USB hub, a card reader with
idVendor=057b, and it is the scsi host scsi2. But it does not
refer to scsi2, perhaps because the category scsi host is missing
in the hierarchy?

Andries
