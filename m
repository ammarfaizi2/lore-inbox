Return-Path: <linux-kernel-owner+w=401wt.eu-S1750897AbXAKQy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbXAKQy3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbXAKQy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:54:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49651 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbXAKQy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:54:28 -0500
Date: Thu, 11 Jan 2007 12:01:51 -0500 (EST)
Message-Id: <20070111.120151.71083168.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: Re: [RFC PATCH 3/3] blk_end_request: caller change
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
In-Reply-To: <20070111083430.GD11203@kernel.dk>
References: <20070110.180859.78702215.k-ueda@ct.jp.nec.com>
	<20070111083430.GD11203@kernel.dk>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, 11 Jan 2007 09:34:31 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> > +static int cdrom_newpc_intr_dma_callback(void *arg)
> > +{
> > +	void **argv = (void **)arg;
> > +	struct request *rq = (struct request *)*argv++;
> > +	ide_drive_t *drive = (ide_drive_t *)argv++;
> > +	spinlock_t *ide_lock = (spinlock_t *)argv;
> > +
> > +	rq->data_len = 0;
> > +
> > +	cdrom_newpc_intr_callback_common(rq, drive, ide_lock);
> > +
> > +	return 0;
> > +}
> 
> And this is why, down right horrible. The callback should be correctly
> typed, pass down a request pointer ALWAYS.

OK.  I think everything such callbacks need can be obtained through
struct request.  (e.g. ide_drive_t can get by rq->q->queuedata and
ide_lock can get by rq->q->queue_lock.)
So I'll change the callback to pass a pointer to the request
instead of void *.

Thanks,
Kiyoshi Ueda

