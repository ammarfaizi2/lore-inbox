Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271201AbTHLWvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 18:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271204AbTHLWvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 18:51:03 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:56593 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271201AbTHLWvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 18:51:01 -0400
Date: Wed, 13 Aug 2003 00:50:57 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries Brouwer <aebr@win.tue.nl>, Jan Niehusmann <jan@gondor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030813005057.A1863@pclin040.win.tue.nl>
References: <20030806150335.GA5430@gondor.com> <20030807110641.GA31809@gondor.com> <20030807211236.GA5637@win.tue.nl> <20030810205513.GA6337@gondor.com> <20030810231955.A16852@pclin040.win.tue.nl> <20030810213450.GA7050@gondor.com> <20030810235834.A16865@pclin040.win.tue.nl> <20030810221020.GA7832@gondor.com> <20030811003343.A16918@pclin040.win.tue.nl> <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Aug 12, 2003 at 04:36:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 04:36:08PM +0100, Alan Cox wrote:
> On Sul, 2003-08-10 at 23:33, Andries Brouwer wrote:
> >         if (drive->addressing == 1)             /* 48-bit LBA */
> >                 return lba_48_rw_disk(drive, rq, (unsigned long long) block);
> >         if (drive->select.b.lba)                /* 28-bit LBA */
> >                 return lba_28_rw_disk(drive, rq, (unsigned long) block);
> >         return chs_rw_disk(drive, rq, (unsigned long) block);
> > 
> > with checking the size of block.
> > And init_idedisk_capacity() does not check addressing.

> It should also issue LBA28 if the size of th range and the end block
> fall under the LBA28 limit because thst saves you valuable I/O time.
> 
> Jens had patches for that but I don't know where they went in 2.6

That is something different. The patches I gave (I gave patches didnt I?)
limit the total capacity for large disks if the controller doesnt speak lba48.

That is necessary to avoid very unpleasant surprises.

But saving some time during I/O, yes, maybe I suggested Jens what to do
and he did it. Hmm. I don't see the code anymore.
Google(Jens Andries rq_lba48) gives the patch.
Ah, I see. His patch went in - I see Changeset 1.1046.31.30 if that
means anything, - and Bartlomiej asked for it to be reverted again.
So, Jens's patches are lost for the moment. Must remember to resurrect them.

