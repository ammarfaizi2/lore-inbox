Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271262AbTHMAVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271264AbTHMAVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:21:14 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50414 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271262AbTHMAVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:21:11 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Date: Wed, 13 Aug 2003 02:21:26 +0200
User-Agent: KMail/1.5
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Niehusmann <jan@gondor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030806150335.GA5430@gondor.com> <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk> <20030813005057.A1863@pclin040.win.tue.nl>
In-Reply-To: <20030813005057.A1863@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308130221.26305.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 of August 2003 00:50, Andries Brouwer wrote:
> On Tue, Aug 12, 2003 at 04:36:08PM +0100, Alan Cox wrote:
> > On Sul, 2003-08-10 at 23:33, Andries Brouwer wrote:
> > >         if (drive->addressing == 1)             /* 48-bit LBA */
> > >                 return lba_48_rw_disk(drive, rq, (unsigned long long)
> > > block); if (drive->select.b.lba)                /* 28-bit LBA */ return
> > > lba_28_rw_disk(drive, rq, (unsigned long) block); return
> > > chs_rw_disk(drive, rq, (unsigned long) block);
> > >
> > > with checking the size of block.
> > > And init_idedisk_capacity() does not check addressing.
> >
> > It should also issue LBA28 if the size of th range and the end block
> > fall under the LBA28 limit because thst saves you valuable I/O time.
> >
> > Jens had patches for that but I don't know where they went in 2.6
>
> That is something different. The patches I gave (I gave patches didnt I?)
> limit the total capacity for large disks if the controller doesnt speak
> lba48.

No, you didn't.  You gave some whining and patch sketch. :-)

> That is necessary to avoid very unpleasant surprises.
>
> But saving some time during I/O, yes, maybe I suggested Jens what to do
> and he did it. Hmm. I don't see the code anymore.
> Google(Jens Andries rq_lba48) gives the patch.
> Ah, I see. His patch went in - I see Changeset 1.1046.31.30 if that
> means anything, - and Bartlomiej asked for it to be reverted again.
> So, Jens's patches are lost for the moment. Must remember to resurrect
> them.

...when taskfile IO is the only IO path not earlier.

Jan, did removing offending lines from pdc202xx_old.c help?

--bartlomiej

