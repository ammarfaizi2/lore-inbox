Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUCKMRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUCKMRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:17:36 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:20130 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261207AbUCKMRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:17:32 -0500
Subject: Re: [PATCH] backing dev unplugging
From: Christophe Saout <christophe@saout.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       thornber@redhat.com
In-Reply-To: <20040310124507.GU4949@suse.de>
References: <20040310124507.GU4949@suse.de>
Content-Type: text/plain
Message-Id: <1079007445.26633.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 13:17:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 10.03.2004 schrieb Jens Axboe um 13:45:

> diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-rc2-mm1/drivers/md/dm-crypt.c linux-2.6.4-rc2-mm1-plug/drivers/md/dm-crypt.c
> --- /opt/kernel/linux-2.6.4-rc2-mm1/drivers/md/dm-crypt.c	2004-03-09 13:08:48.000000000 +0100
> +++ linux-2.6.4-rc2-mm1-plug/drivers/md/dm-crypt.c	2004-03-09 15:27:36.000000000 +0100
> @@ -668,7 +668,7 @@
>  
>  		/* out of memory -> run queues */
>  		if (remaining)
> -			blk_run_queues();
> +			blk_congestion_wait(bio_data_dir(clone), HZ/100);

Why did you change this? It was the way I wanted it.

If we were out of memory the buffers were allocated from a mempool and I
want to get it out as soon as possible. If we are OOM the write will
most likely be the VM trying to free some memory and it would be
counterproductive to wait. It is not unlikely that we are the only
writer to that disk so there's a chance that the queue is not congested.


