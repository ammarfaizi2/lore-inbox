Return-Path: <linux-kernel-owner+w=401wt.eu-S932351AbXALRkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbXALRkg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbXALRkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:40:36 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:30797 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351AbXALRkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:40:35 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RNhz0uuQbbBHX8syLJj1T/9TXJH/wtJ6O1O2zQSkvo41ub6VCAzSV0n8ZxJUgUveD2GLu/9WNReETZ2n8E1ntqd3A0R3asdnPTESAPujTnKGcpL2fLPDTUyoBAfwu6BXpfgYc8qFJ6lte2wiIgQbdOcL/vAVF9+U9pgY3v1gb/k=
Message-ID: <6bffcb0e0701120940i1775057bq31b289384c26d19c@mail.gmail.com>
Date: Fri, 12 Jan 2007 18:40:29 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.20-rc4-mm1 md problem
Cc: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Neil Brown" <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>, "Jens Axboe" <axboe@suse.de>
In-Reply-To: <200701121652.46896.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
	 <200701121652.46896.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, 12 January 2007 14:33, Michal Piotrowski wrote:
> > My system hangs on this
> > http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/bug2.jpg
> > http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/mm-config
> >
> > Debug plan:
> > - revert md-* patches
> > - binary search
> >
> > Does someone have a better idea?
>
> Revert git-block.patch and related stuff?

Indeed.

GOOD
#
##git-sym2.patch
#git-scsi-target.patch
#git-scsi-target-fixup.patch
#
git-block.patch
git-block-fixup.patch
BAD

git-block.patch it's huge patch.

diffstat git-block.patch
[..]
drivers/md/bitmap.c             |    1
 drivers/md/dm-emc.c             |    2
 drivers/md/dm-table.c           |   14 -
 drivers/md/dm.c                 |   18 -
 drivers/md/dm.h                 |    1
 drivers/md/linear.c             |   14 -
 drivers/md/md.c                 |    3
 drivers/md/multipath.c          |   32 --
 drivers/md/raid0.c              |   17 -
 drivers/md/raid1.c              |   70 -----
 drivers/md/raid10.c             |   73 ------
 drivers/md/raid5.c              |   60 ----
[..]

I'll do a binary search through those files.

>
> Greetings,
> Rafael

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
