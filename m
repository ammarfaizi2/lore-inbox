Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVBZXZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVBZXZO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 18:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVBZXZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 18:25:14 -0500
Received: from elektron.ikp.physik.tu-darmstadt.de ([130.83.24.72]:36617 "EHLO
	elektron.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S261294AbVBZXZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 18:25:06 -0500
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16929.1350.119511.746325@hertz.ikp.physik.tu-darmstadt.de>
Date: Sun, 27 Feb 2005 00:24:54 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <Pine.LNX.4.58.0502261433431.25732@ppc970.osdl.org>
References: <20050226213459.GA21137@apps.cwi.nl>
	<16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
	<Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org>
	<Pine.LNX.4.58.0502261433431.25732@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

    Linus> On Sat, 26 Feb 2005, Linus Torvalds wrote:
    >>  Would it not make more sense to just sanity-check the size itself,
    >> and throw it out if the partition size (plus start) is bigger than
    >> the disk size?

    Linus> Something like this (TOTALLY UNTESTED AS USUAL!)?

Yes, no phantom partitions also with your approach.

    Linus> What does fdisk and other tools do on that disk? Just out of
    Linus> interest..

To be honest:
r50:~ # fdisk /dev/sda

Command (m for help): p

Disk /dev/sda: 65 MB, 65536000 bytes
17 heads, 33 sectors/track, 228 cylinders
Units = cylinders of 561 * 512 = 287232 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1         229       63981+   6  FAT16
Partition 1 has different physical/logical beginnings (non-Linux?):
     phys=(0, 1, 1) logical=(0, 1, 5)
Partition 1 has different physical/logical endings:
     phys=(125, 16, 33) logical=(228, 2, 26)
/dev/sda4         3512348     6003585   698791990+   0  Empty
Partition 4 has different physical/logical beginnings (non-Linux?):
     phys=(0, 0, 0) logical=(3512347, 6, 16)
Partition 4 has different physical/logical endings:
     phys=(0, 0, 0) logical=(6003584, 7, 6)
Partition 4 does not end on cylinder boundary.


-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
