Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTEZKUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 06:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbTEZKUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 06:20:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17538 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264334AbTEZKUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 06:20:41 -0400
Date: Mon, 26 May 2003 12:32:45 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <3ED1A664.1020307@pobox.com>
Message-ID: <Pine.SOL.4.30.0305261217020.12542-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Jeff Garzik wrote:

> Linus Torvalds wrote:
> > On Mon, 26 May 2003, Jeff Garzik wrote:
> >
> >>Just to echo some comments I said in private, this driver is _not_
> >>a replacement for drivers/ide.  This is not, and has never been,
> >>the intention.  In fact, I need drivers/ide's continued existence,
> >>so that I may have fewer boundaries on future development.
> >
> >
> > Just out of interest, is there any _point_ to this driver? I can
> > appreciate the approach, but I'd like to know if it does anything (at all)
> > better than the native IDE driver? Faster? Anything?
>
>
> Direction:  SATA is much more suited to SCSI, because otherwise you wind
> up re-creating all the queueing and error handling mess that SCSI
> already does for you.  The SATA2 host controllers coming out soon do
> full host-side TCQ, not the dain-bramaged ATA TCQ bus-release stuff.
> Doing SATA2 devel in drivers/ide will essentially be re-creating the
> SCSI mid-layer.

And now you are recreating ATA in SCSI ;-).

Don't get me wrong: I like idea very much, but why you can't
share common code between drivers/ide and your ATA-SCSI.

> Modularity:  drivers/ide has come a long way.  It needed to be turned
> "inside out", and that's what Alan did.  But there's still a lot of code
> that needs to be factored out/about, before hotplugging and device model
> stuff is sane.

Its getting close.

> Legacy-free:  Because I don't have to worry about legacy host
> controllers, I can ignore limitations drivers/ide cannot.  In
> drivers/ide, each host IO (PIO/MMIO) is done via function pointer.  If
> your arch has a mach_vec, more function pointers.  Mine does direct
> calls to the asm/io.h functions in faster.  So, ATA command submission
> is measureably faster.

I think it is simply wrong, you should use function pointers.
You can have ie. two PCI hosts, one using PIO and one using MMIO.

"measureably faster", I doubt.
IO operations are REALLY slow when compared to CPU cycles.

> sysfs:  James and co are putting time into getting scsi sysfs right.  I
> would rather ride their coattails, and have my driver Just Work with
> sysfs and the driver model.

No big deal here, ATA will get it too.

> PIO data transfer is faster and more scheduler-friendly, since it polls
> from a kernel thread.

CPU polling is faster than IRQs?

> And for specifically Intel SATA, drivers/ide flat out doesn't work (even
> though it claims to).

So fix it ;-).

> So, I conclude:  faster, smaller, and better future direction.  IMO, of
> course :)

And right now ugly and incomplete.
IMO, of course ;-).

Regards,
--
Bartlomiej

> 	Jeff
>
>
>
> (the following is somewhat comparing apples to oranges, but I like doing
> it nonetheless)

social engineering removed


