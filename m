Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264978AbUELFcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbUELFcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 01:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbUELFcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 01:32:24 -0400
Received: from fmr04.intel.com ([143.183.121.6]:30870 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264978AbUELFcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 01:32:22 -0400
Message-Id: <200405120532.i4C5WCF25908@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Cache queue_congestion_on/off_threshold
Date: Tue, 11 May 2004 22:32:11 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQ2m1knKuI+GyGUQ/2vuwEjqRbhuwBRVpWg
In-Reply-To: <20040510143024.GF14403@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Jens Axboe wrote on Monday, May 10, 2004 7:30 AM
> > >
> > > Actually, with the good working batching we might get away with killing
> > > freereq completely. Have you tested that (if not, could you?)
> >
> > Sorry, I'm clueless on "good working batching".  If you could please give
> > me some pointers, I will definitely test it.
>
> Something like this.
>
> --- linux-2.6.6/drivers/block/ll_rw_blk.c~	2004-05-10 16:23:45.684726955 +0200
> +++ linux-2.6.6/drivers/block/ll_rw_blk.c	2004-05-10 16:29:04.333792268 +0200
> @@ -2138,8 +2138,8 @@
>
>  static int __make_request(request_queue_t *q, struct bio *bio)
>  {
> -	struct request *req, *freereq = NULL;
>  	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
> +	struct request *req;
>  	sector_t sector;
>
>
> [snip] ...

I'm still working on this.  With this patch, several processes stuck
in "D" state and never finish.  Suspect it's the barrier thing, it
jumps through blk_plug_device() and might goof up the queue afterwards.

- Ken


