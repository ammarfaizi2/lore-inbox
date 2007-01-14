Return-Path: <linux-kernel-owner+w=401wt.eu-S1751243AbXANWFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbXANWFr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 17:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbXANWFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 17:05:46 -0500
Received: from [169.222.10.252] ([169.222.10.252]:39491 "EHLO kernel.dk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751243AbXANWFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 17:05:46 -0500
Date: Mon, 15 Jan 2007 08:59:32 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Neil Brown <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc4-mm1 md problem
Message-ID: <20070114215932.GD5860@kernel.dk>
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com> <200701121652.46896.rjw@sisk.pl> <6bffcb0e0701120940i1775057bq31b289384c26d19c@mail.gmail.com> <6bffcb0e0701120958k5ac34460v645799f4629826d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0701120958k5ac34460v645799f4629826d8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12 2007, Michal Piotrowski wrote:
> On 12/01/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> >On 12/01/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> On Friday, 12 January 2007 14:33, Michal Piotrowski wrote:
> >> > My system hangs on this
> >> > 
> >http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/bug2.jpg
> >> > 
> >http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/mm-config
> >> >
> >> > Debug plan:
> >> > - revert md-* patches
> >> > - binary search
> >> >
> >> > Does someone have a better idea?
> >>
> >> Revert git-block.patch and related stuff?
> >
> >Indeed.
> >
> >GOOD
> >#
> >##git-sym2.patch
> >#git-scsi-target.patch
> >#git-scsi-target-fixup.patch
> >#
> >git-block.patch
> >git-block-fixup.patch
> >BAD
> >
> >git-block.patch it's huge patch.
> >
> >diffstat git-block.patch
> >[..]
> >drivers/md/bitmap.c             |    1
> > drivers/md/dm-emc.c             |    2
> > drivers/md/dm-table.c           |   14 -
> > drivers/md/dm.c                 |   18 -
> > drivers/md/dm.h                 |    1
> > drivers/md/linear.c             |   14 -
> > drivers/md/md.c                 |    3
> > drivers/md/multipath.c          |   32 --
> > drivers/md/raid0.c              |   17 -
> > drivers/md/raid1.c              |   70 -----
> > drivers/md/raid10.c             |   73 ------
> > drivers/md/raid5.c              |   60 ----
> >[..]
> >
> >I'll do a binary search through those files.
> >
> 
> That wasn't a good idea.
> 
> /mnt/md0/devel/linux-mm/drivers/md/raid1.c: In function 'unplug_slaves':
> /mnt/md0/devel/linux-mm/drivers/md/raid1.c:556: error:
> 'request_queue_t' has no member named 'unplug_fn'

You can't go throught he individual files and expect that to compile,
yet alone work. Fortunately I think I already fixed this last week,
unfortunately I think I forgot to push the #plug branch for #for-akpm so
that Andrew automatically picks it up...

-- 
Jens Axboe

