Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTD1M7K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTD1M7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:59:10 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30975 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263568AbTD1M7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:59:09 -0400
Date: Mon, 28 Apr 2003 15:10:55 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Osamu Tomita <tomita@cinet.co.jp>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac2 fix new PIO handlers
In-Reply-To: <3EAC87CD.82C5F4A6@cinet.co.jp>
Message-ID: <Pine.SOL.4.30.0304281500500.25740-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Apr 2003, Osamu Tomita wrote:

> Hi,
>
> Bartlomiej Zolnierkiewicz wrote:
> >
> > Hi,
> >
> > During rewrite of bio walking patch to use rq->cbio instead
> > of rq->hard_bio I've realized I had screwed orig 2.5.66 patches :\
> >
> > I somehow forgot to update task_map_rq(), it should use
> > __bio_kmap_irq(rq->bio, current_idx, flags) instead of
> > bio_kmap_irq(rq->bio, flags). The result is that you get
> > bio corruption (-> data corruption) when using PIO multiple
> > with sectors multiply > 8 (PAGE_SIZE == bio_vec size).

Hmmm, not only > 8, also 3, 5.

> > Attached patch fixes it and fixes TASKFILE ioctl.
> >
> > Please apply to next -ac.
> Could you please tell me how to apply your patch. Aginst 2.5.62-ac2?
> I have a ext2 fs corruption problem at PIO mode on 2.5.67-ac2.

Did you use multi PIO? You can check with 'hdparm -m /dev/hdx'.
If yes this patch should fix the corruption.

> There is no problem on vanilla 2.5.67.
> I tryed the all patches below.
>  tf-ioctls-1.diff
>  tf-ioctls-2a.diff
>  tf-ioctls-2b.diff
>  tf-ioctls-3.diff
>  tf-ioctls-4.diff
>  tf-dio-1.diff
>  tf-dio-2.diff
>  tf-dio-3.diff
>  tf-dio-4.diff
>  masked-irq.diff
> They didn't solve problem.

No, they don't.

> This pio-fixes.diff can't be applied after them?
>
> Regards,
> Osamu Tomita

Could you please apply only pio_fixes.diff on top of the vanilla
2.5.67-ac2 and tell me if it solves the problem? It should.

Thanks,
--
Bartlomiej

