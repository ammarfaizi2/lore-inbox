Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269163AbTB0FFR>; Thu, 27 Feb 2003 00:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269164AbTB0FFR>; Thu, 27 Feb 2003 00:05:17 -0500
Received: from MTJ-HS-031.montrose.net ([65.169.6.40]:16964 "EHLO
	tenax.loup.net") by vger.kernel.org with ESMTP id <S269163AbTB0FFQ>;
	Thu, 27 Feb 2003 00:05:16 -0500
Date: Wed, 26 Feb 2003 22:13:38 -0700
Message-Id: <200302270513.h1R5DcG23996@flux.loup.net>
From: Mike Hayward <hayward@loup.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 corrupt file system, 2.4.20 Makefile problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running 2.4.19 for quite awhile, but today it locked up, had
to be hard rebooted, and trashed my ext3 file system.  Something about
a seemingly infinite number of Duplicate/Bad Blocks from fsck even
though the hard drive is fine.  I assumed with the journal the file
system would be rock solid, but ...  I'm hoping 2.4.20 proves more
stable; has anyone else seen 2.4.19 trash the hard drive?

2.4.20 doesn't build on my RH7.2 box which uses gcc 2.96 due to a mod
to the Makefile which I just undid and subsequently compiled just
fine.  Without said line, stdarg.h (which isn't part of the linux
kernel includes) is not found since -nostdinc probably removes *all*
include directories not explicitly specified, including:
/usr/lib/gcc-lib/i386-redhat-linux/2.96/include

---New make line---
kbuild_2_4_nostdinc    := -nostdinc -iwithprefix include

---Old make line---
kbuild_2_4_nostdinc     := -nostdinc $(shell $(CC) -print-search-dirs
| sed -ne 's/install: \(.*\)/-I \1include/gp')

If stdarg.h doesn't belong in the kernel distribution, perhaps the
configure or make process could do some checking to make sure the
appropriate include directory for stdarg.h is included in that
variable?

- Mike
