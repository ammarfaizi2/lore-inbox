Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbTHTVGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbTHTVGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:06:20 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:15114 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S262204AbTHTVFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:05:03 -0400
Subject: [PATCH] 2.6.0-test3 zoran driver update
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@odsl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061414594.1320.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 20 Aug 2003 23:23:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus/Andrew,

This is a patch for the video4linux unified zoran driver that has been
in the kernel since 2.4.5 or so. I've send it in a few times before but
it didn't go in yet (Alan promised to look into it, but he's on
sabbatical now, so I'll have to bug someone else :p). Could this patch
be considered please?
It fixes compile issues in the current 2.6.0-test3 unified zoran driver
(current one doesn't compile at all), and also updates its version to
what we have in CVS. This adds support for new cards (e.g. LML33R10 from
LinuxMediaLabs and DC30+ from Pinnacle), fixes bugs in cards that were
already supported and generally improves capture reliability. Changes
per file (in detail) are given below.

http://mjpeg.sf.net/driver-zoran/linux-zoran-driver.patch.gz contains
the patch. Uncompressed size is 740kB, compressed size is 164 kB (so no
attaching here). MD5SUM is 96e4c566c9786f07b26707f2155145ee.

Please consider this. Waiting longer won't fix the broken driver that's
currently in your tree. :).

Thanks,
Ronald

----- detailed changes -----

Changes for each relevant part:
i2c-id.h:
add some new IDs for new i2c drivers

pci_ids.h:
add PCI IDs for each of the supported cards if it has any

saa7111.c, saa7110.c, adv7175.c, bt819.c, saa7185.c, bt856.c:
update to whatever we've got in our CVS. For most, these are just
"easiness" fixes that either add some better debug output, or that make
maintainance for both 2.6.x and 2.4.x simpler for me. There's also some
specific changes. E.g., in saa7110.c, we enable the VCR mode bits so we
get a better image from VCR input. In all of them, we make debugging an
insmod option rather than a compile-time option (this makes debugging
for users a *lot* easier). Point is that I just want our latest CVS in
here. Maintainance is going to be a personal horror-story if it's not.

vpx3220.c, saa7114.c, adv7170.c:
new i2c ones (for respectively DC10/DC30, LML33R10 and again LML33R10)

zr36067.c:
removed, the driver is now spread over multiple source files.

zoran*.[ch], zr36057.h
spread-out source files. Also fixes lots of bugs, can't even start
naming them all, you don't want that, neither do I. Just assume that it
works better than it used to - it does.
Nice things that aren't in the old driver: much more stable, supports
DC30+, supports LML33R10, has proper locking/semaphores, supports
multiple opens without races now, adapted to new i2c subsystem, v4l2
support, Xv (hardware-scaled) overlay support, and a lot more.
Oh, and this one actually compiles.

videocodec.[ch], zr360{16,50,60}.[ch]:
new sublayer for the driver to unify how we handle the zr36060 chip
(DC10(+)/LML33/LML33R10/Buz) and the zr36050/zr36016 (DC30(+)).

MAINTAINERS:
add me as maintainer (I am).

Kconfig:
add new cards, plus improve the descriptions.

Makefile:
d'oh.

Zoran:
documentation update.

Others:
I don't think there are any.

Greg has gone over the i2c changes a long time ago, he agreed on all of
them. Gerd is supposed to take care of the v4l part, he has never
complained about any of them. Stability is good, we've fixed most issues
(there's still some out there, but nothing serious), lots better than in
the old driver. Also, the cards work much better than with the old
driver.

In short, I think this is worth applying, even though it's a huge beast.

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

