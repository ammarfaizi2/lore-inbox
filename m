Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263724AbUC3PY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUC3PY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:24:59 -0500
Received: from witte.sonytel.be ([80.88.33.193]:43483 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263724AbUC3PXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:23:18 -0500
Date: Tue, 30 Mar 2004 17:22:50 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-15?Q?Andr=E9_Hedrick?= <andre@linux-ide.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: [PATCH] Bogus LBA48 drives
Message-ID: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apparently some IDE drives (e.g. a pile of 80 GB ST380020ACE drives I have
access to) advertise to support LBA48, but don't, causing kernels that support
LBA48 (i.e. anything newer than 2.4.18, including 2.4.25 and 2.6.4) to fail on
them.  Older kernels (including 2.2.20 on the Debian woody CDs) work fine.

One problem with those drives is that the lba_capacity_2 field in their drive
identification is set to 0, making the IDE driver think the disk is 0 bytes
large. At first I tried modifying the driver to use lba_capacity if
lba_capacity_2 is set to 0, but this caused disk errors. So it looks like those
drives don't support the increased transfer size of LBA48 neither.

I added a workaround for these drives to both 2.4.25 and 2.6.4. I'll send
patches in follow-up emails.

BTW, this problem (incl. a small patch to fix it for 2.4.19, which doesn't work
on 2.4.25 anymore) was reported a while ago by JunHyeok Heo, cfr.
http://www.cs.helsinki.fi/linux/linux-kernel/2002-42/0312.html

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
