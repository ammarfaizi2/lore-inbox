Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbULNBJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbULNBJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 20:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULNBJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 20:09:15 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:13842 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261365AbULNBJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 20:09:11 -0500
Date: Tue, 14 Dec 2004 01:09:09 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-iops: Use platform-dependent port I/O operations
In-Reply-To: <58cb370e04121313393f00c37c@mail.gmail.com>
Message-ID: <Pine.LNX.4.58L.0412140039410.9181@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.58L.0412130227420.8571@blysk.ds.pg.gda.pl>
 <58cb370e04121313393f00c37c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> >  Given the contents of <asm-generic/ide_iops.h> and platform-specific
> > peculiarities (like address-dependent hardware byte lane swappers), I
> 
> Could you give some specific examples? Thanks.

 Well, you could have a look at the few options at the top of
<asm-mips/io.h>, but on second thoughts, as long as port I/O string
operations either use an unswapping address space or revert any swapping
that might have been done by hardware (either for data or for addresses),
they should work as is.  Unlike with memory-mapped I/O that should be
feasible, because port I/O is specific to ISA/EISA/PCI which are always
little-endian.

 Anyway, I still think the patch should go in for consistency.

> > believe ide-iops should use __ide_* for port I/O string operations,
> > similarly to __ide_mm_* that are already used for memory-mapped I/O ones.
> > 
> >  Please consider.
> 
> This patch looks quite OK but it breaks few archs which don't include
> <asm-generic/ide_iops.h> and don't define __ide_[in,out]* macros.

 I can have a look at it -- that is as trivial as copying missing
definitions from <asm-generic/ide_iops.h>.  I'm afraid I won't even be
able to perform compilation tests, though.

  Maciej
