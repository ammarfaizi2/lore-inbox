Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbTA0QjF>; Mon, 27 Jan 2003 11:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbTA0QjF>; Mon, 27 Jan 2003 11:39:05 -0500
Received: from hera.cwi.nl ([192.16.191.8]:28575 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267229AbTA0QjE>;
	Mon, 27 Jan 2003 11:39:04 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 27 Jan 2003 17:48:12 +0100 (MET)
Message-Id: <UTC200301271648.h0RGmCh27353.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, philipp.marek@bmlv.gv.at
Subject: Re: [PATCH] fs/partitions/msdos.c Guard against negative sizes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    u32 start = START_SECT(p)*sector_size;
    u32 size = NR_SECTS(p)*sector_size;
    And this looks as if it was calculated in bytes

But it is not. It converts hardware sector size units
to 512-byte units. For example, some MO disks use
2048-byte sectors, and also have the partition tables
in that unit.

    What about overflow?

More detailed checking of the table is certainly possible.

[But then, weird tables only occur when people fiddle with
the partition table themselves. Or when an accident happened.
I am not sure inhibiting access to partitions that look strange
is useful. It might make rescue operations difficult or impossible.]

    And btw, when can a partition that extends beyond the end
    be "allowed or even necessary"?

One reason is that "the end" is not well-defined. E.g.,
disk manufacturers invent jumpers that make the disk appear
smaller than it is in reality in order to avoid BIOS bugs.
See http://www.win.tue.nl/~aeb/linux/Large-Disk-11.html#ss11.3

In many cases the kernel option CONFIG_IDEDISK_STROKE will tell
the kernel to automatically fix up fake lengths. If that doesn't
work, a user mode utility may be needed to give the disk full size.
Since that utility is run after the kernel does the partition detection,
it is often easiest to let the last logical partition start just before
the fake end.

Andries
