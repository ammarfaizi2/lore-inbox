Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270666AbTGUR1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270705AbTGUR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:27:14 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:35342 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S270666AbTGURZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:25:08 -0400
Subject: [patch/2.6.0-test1] Update for Unified Zoran Driver
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Gerd Knorr <kraxel@bytesex.org>,
       LKML <linux-kernel@vger.kernel.org>,
       MJPEG developers <mjpeg-developer@lists.sf.net>,
       Laurent Pinchart <laurent.pinchart@skynet.be>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Message-Id: <1058810136.2652.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 21 Jul 2003 19:55:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've put up an update for the unified linux zoran driver on
http://mjpeg.sourceforge.net/driver-zoran/linux-zoran-driver.patch.gz.
MD5SUM is ecc58905498afb804d8d97a9a369cbc6, size is 164kB (compressed)
or 736kB (uncompressed). Obviously, I didn't attach it for this reason.
It's main purpose is to fix the compilation failure of the driver in any
recent 2.5.x/2.6.x kernel. Apart from that, it's also a total rewrite.
;).

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
Gerd/Alan, can one of you please take care of this if Linus
forgets/ignores it? Oh, and Greg, you'll probably want to apply these
new IDs to your i2c tree, too.

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

