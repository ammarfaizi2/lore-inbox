Return-Path: <linux-kernel-owner+w=401wt.eu-S932177AbXALR60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbXALR60 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXALR60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:58:26 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:20917 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177AbXALR6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:58:25 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sqkwTOgWbUbqSzUleg/tr9cWVGfN+5QrWUwnC4Oo44cQPsfL1XYcoD0UnWBJnFdk39dpRsItt9Erq+UpVf+7tUDNlSQDFFjffDonmxq6fuWRv4Qp53xi44nkON3jx9anC5xGy3TvNpk7PivcxQxu0Bnosm5mZXqixsXfJTHC63s=
Message-ID: <6bffcb0e0701120958k5ac34460v645799f4629826d8@mail.gmail.com>
Date: Fri, 12 Jan 2007 18:58:22 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.20-rc4-mm1 md problem
Cc: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Neil Brown" <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>,
       "Jens Axboe" <jens.axboe@oracle.com>, "Jens Axboe" <axboe@kernel.dk>
In-Reply-To: <6bffcb0e0701120940i1775057bq31b289384c26d19c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
	 <200701121652.46896.rjw@sisk.pl>
	 <6bffcb0e0701120940i1775057bq31b289384c26d19c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 12/01/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, 12 January 2007 14:33, Michal Piotrowski wrote:
> > > My system hangs on this
> > > http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/bug2.jpg
> > > http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/mm-config
> > >
> > > Debug plan:
> > > - revert md-* patches
> > > - binary search
> > >
> > > Does someone have a better idea?
> >
> > Revert git-block.patch and related stuff?
>
> Indeed.
>
> GOOD
> #
> ##git-sym2.patch
> #git-scsi-target.patch
> #git-scsi-target-fixup.patch
> #
> git-block.patch
> git-block-fixup.patch
> BAD
>
> git-block.patch it's huge patch.
>
> diffstat git-block.patch
> [..]
> drivers/md/bitmap.c             |    1
>  drivers/md/dm-emc.c             |    2
>  drivers/md/dm-table.c           |   14 -
>  drivers/md/dm.c                 |   18 -
>  drivers/md/dm.h                 |    1
>  drivers/md/linear.c             |   14 -
>  drivers/md/md.c                 |    3
>  drivers/md/multipath.c          |   32 --
>  drivers/md/raid0.c              |   17 -
>  drivers/md/raid1.c              |   70 -----
>  drivers/md/raid10.c             |   73 ------
>  drivers/md/raid5.c              |   60 ----
> [..]
>
> I'll do a binary search through those files.
>

That wasn't a good idea.

/mnt/md0/devel/linux-mm/drivers/md/raid1.c: In function 'unplug_slaves':
/mnt/md0/devel/linux-mm/drivers/md/raid1.c:556: error:
'request_queue_t' has no member named 'unplug_fn'

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
