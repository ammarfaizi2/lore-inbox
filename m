Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269583AbUJAJVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbUJAJVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 05:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUJAJVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 05:21:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51108 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269583AbUJAJVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 05:21:18 -0400
Date: Fri, 1 Oct 2004 11:18:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Borislav Petkov <petkov@uni-muenster.de>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: 2.6.9-rc2-mm4
Message-ID: <20041001091825.GC3008@suse.de>
References: <20040929214637.44e5882f.akpm@osdl.org> <200409301825.41124.bzolnier@elka.pw.edu.pl> <200409302346.35214.petkov@uni-muenster.de> <200410010130.51769.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410010130.51769.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01 2004, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 30 September 2004 23:46, Borislav Petkov wrote:
> > On Thursday 30 September 2004 18:25, Bartlomiej Zolnierkiewicz wrote:
> > > On Thursday 30 September 2004 17:32, Borislav Petkov wrote:
> > > > On Thursday 30 September 2004 14:52, Bartlomiej Zolnierkiewicz wrote:
> > > > > On Thursday 30 September 2004 06:46, Andrew Morton wrote:
> > > > > > ide broke :(   Maybe Bart's bk tree?
> > > > >
> > > > > no, disk works just fine ;)  If it is my tree I will happilly fix it.
> > > > >
> > > > > Borislav, could you apply only these patches from -mm4 and retest?
> > > > >
> > > > > linus.patch
> > > > > bk-ide-dev.patch
> > > > >
> > > > > > Begin forwarded message:
> > > > > >
> > > > > > Date: Wed, 29 Sep 2004 12:43:35 +0200
> > > > > > From: Borislav Petkov <petkov@uni-muenster.de>
> > > > > > To: Andrew Morton <akpm@osdl.org>
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Subject: Re: 2.6.9-rc2-mm4
> > > > > >
> > > > > >
> > > > > > <snip>
> > > > > >
> > > > > > Hello,
> > > > > >  I've already posted about problems with audio extraction but it went
> > > > > > unnoticed. Here's a recount: When I attempt to read an audio cd into
> > > > > > wavs with cdda2wav, the process starts but after a while the
> > > > > > completion meter freezes and klogd says "hdc: lost interrupt" and
> > > > > > cdda2wav hangs itself. Disabling DMA doesn't help as well as the boot
> > > > > > option "pci=routeirq" too. Older kernels like 2.6.7 do not show such
> > > > > > behavior and there audio extraction runs fine. Sysinfo attached.
> > > > > >
> > > > > > Regards,
> > > > > > Boris.
> > > >
> > > > Hi people,
> > > >
> > > >  well, I've applied the above patches but no change - same "hdc: lost
> > > > interrupt" message. 2.6.9-rc3 behaves the same, as expected.
> > >
> > > Well, if 2.6.9-rc3 fails then it is not my tree...
> > >
> > > Please find kernel version which introduces this bug.
> > >
> > 
> > Just compiled 2.6.8.1 and tested audio extraction. The bug is there.
> > After that, reran the test with 2.6.7. Everything went fine. So it must have 
> > been between 2.6.7 and 2.6.8.1 when the bug got introduced. Any additional 
> > debugging options in the ATA/IDE cd driver i could turn on so that I could 
> > get more verbose messages while executing cdda2wav?
> 
> I'm not aware of any.  Jens?

I don't see any changes that could impact this from 2.6.7 to 2.6.8. We
tightened the dma alignment (from 4 to 32 bytes), but should not cause
problems going in that direction. Unless the other path is buggy, of
course.

Does dma make a difference? Please try 2.6.9-rc3 as well.

-- 
Jens Axboe

