Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbWGKHmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWGKHmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWGKHmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:42:43 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:61002 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965250AbWGKHmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:42:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GfuPQkdRlrwja8C4P4yfw0vg8QBsIqoSWD6jXXaQ4R3AUut9YcBLQRmmEe/mcDDjimnmVZ/V7LY3+pzq0fVs/+LhsbbayM0oViEvZ15lnNA8B0kLQqotzkcCvHCsYnXnCMrc8IQ7oamtyG3xHC4oBOVNdRKAKxqINFUDI0t0KRM=
Message-ID: <4dccc9070607110042r78aeb843gb7b23d70505dfcec@mail.gmail.com>
Date: Tue, 11 Jul 2006 13:12:42 +0530
From: "Srinivas Ganji" <srinivasganji.linux@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: Spinlock Related Debug Messages in Block Driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060711071753.GS5210@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4dccc9070607102303v380281adp3943e1d58fad8d0@mail.gmail.com>
	 <20060711071753.GS5210@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Jens Axboe <axboe@suse.de> wrote:
> On Tue, Jul 11 2006, Srinivas Ganji wrote:
> > Dear All,
> >
> > I implemented the sample block driver for the removable devices and
> > the code contains no statements related to the spin lock except a lock
> > to the blk_init_queue API as shown below.
> >
> > spinlock_t qlock;
> > gDisk->blkqueue = blk_init_queue(do_my_request, &gDisk->qlock);
> >
> > The kernel version is 2.6.10.
> >
> > Everything works fine but when I try to copy a file of huge size
> > (about 100MB), the following debug messages are getting displayed on
> > the console:
> >
> > Fc3: drivers/block/ll_rw_blk.c: 2351: spin_lock already locked by the
> > drivers.
> > Fc3: drivers/block/ll_rw_blk.c: 2468: spin_unlock not locked by the drivers.
> >
> > In spite of these debug messages; the file is getting copied successfully.
> > I studied the Block driver 16th chapter in LDD third edition.
> >
> > Can any one provide a pointer to these debug messages. Do I need to
> > implement any patches for the kernel.
>
> You need to initialize the lock passed to blk_init_queue() first. See eg
> spin_lock_init(), or one of the static initializers
> (SPIN_LOCK_UNLOCKED).
>
> --
> Jens Axboe

Dear Jen,

Thanks for  your reply.
I used the spin_lock_init API before blk_init_queue API. Even though I
got the error.

Is there any other reason for gertting the error messages?

Thanks and Regards,
Srinivas G
