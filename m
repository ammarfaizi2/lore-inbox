Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261935AbSIYHjt>; Wed, 25 Sep 2002 03:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbSIYHjs>; Wed, 25 Sep 2002 03:39:48 -0400
Received: from 62-190-218-65.pdu.pipex.net ([62.190.218.65]:7684 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261935AbSIYHjs>; Wed, 25 Sep 2002 03:39:48 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209250749.g8P7nmiT000178@darkstar.example.net>
Subject: Re: hdparm -Y hangup
To: davidsen@tmr.com (Bill Davidsen)
Date: Wed, 25 Sep 2002 08:49:48 +0100 (BST)
Cc: padraig.brady@corvil.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020924170534.19732B-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Sep 24, 2002 05:06:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Hrm, OK thanks for the info. Perhaps it should be removed
> > > from hdparm or a (DANGEROUS) put beside the description
> > > until it's fixed.
> > 
> > The person to contact would be Mark Lord, the hdparm maintainer, (see the
> > hdparm manual page for his E-Mail address).
> 
> Rather than have Mark Lord set the option DANGEROUS (it shouldn't be)
> perhaps it could be made to work more than once... Odd problem, is
> something not getting set or cleared when the drive is spun up the first
> time?

With my Maxtor disk connected to a PIIX3 IDE interface and stock kernel 2.4.19, I get this behavior:

# hdparm -Y /dev/hda

Disk sleeps

# find

No disk activity - it doesn't wake up.  It doesn't work once for me, it always hangs on the first attempt.

So, I try dmesg on another console - no new output.

# hdparm -w /dev/hda

Performs a device reset, and the disk spins up.

# dmesg

hda: ide_set_handler: handler not null; c0181050
hda: dma_intr: status=0xd0 { Busy }
hda: DMA disabled
hda: ide_set_handler: handler not null; old=c0181050, new=c017b160
bug: kernel timer added twice at c017afe1.
hda: ide_set_handler: handler not null; old=c017b160, new=c017b160
ide0: reset: success

Obviously, if you're going to try to repeat this, sync the disk beforehand, because I assume that a device reset will loose data in the disk's write cache.

John.
