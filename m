Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbTFSAL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbTFSAJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:09:16 -0400
Received: from dsl-217-155-128-73.zen.co.uk ([217.155.128.73]:34985 "EHLO
	heart.pulsesol.com") by vger.kernel.org with ESMTP id S265648AbTFSAI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:08:27 -0400
Message-ID: <009a01c335f8$da220510$4c809bd9@PULSEDESKTOP>
From: "Antony Gelberg" <antony@antgel.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Promise RAID driver
Date: Thu, 19 Jun 2003 01:22:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Apologies if this is a little OT but I was hoping someone in here might be
able to give me a hand.

I'm doing a new Debian install on a PC with a Promise 20376 onboard SATA
RAID controller.  Promise have sent me a driver, which I built.

During the install, there is a point where it asks for any floppy-based
modules of this nature.  I've successfully loaded scsi_mod.o then the
Promise ft3xx.o.  (Also done it from the ash prompt to confirm that they
link ok.)  The message comes up from the driver recognising my controller
and drives.

Problem is, Debian still can't see the array, and the documentation for the
driver is pants.  I've had a look through the source but am at my limit of
comprehension.  There is a call to scsi_register(), but then I lose the
plot.

I've tried fdisk on
/dev/hda
/dev/sda (even though this has a major number 8)
/dev/ataraid/d0 (major number 114)

Each time I get: Unable to open /dev/whatever.

FWIW, I have noted the following: cat /proc/devices shows that the ft3xx
device registers itself as 254 (it's dynamic - I assume that they go down
from 254).  But an ls -l /dev/* shows no node with a major number of 254.

When I created one (/dev/raid) with mknod, I got messages complaining about
ioctl then a hang.  So this seems to confirm that it uses a SCSI device.  In
addition, it does call scsi_register.  It then sets (in the returned struct)
max_channel=0, max_id=1, max_lun=1.  I've tried poking about in the kernel
to see what this actually does but I'm out of my depth.

If anyone could give me a pointer (no pun intended), I'd be ever so
grateful.

(There is a driver in the kernel - this is for the earlier series (20276 not
20376), and will not work with this controller.)

Antony


