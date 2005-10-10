Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVJJF1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVJJF1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 01:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVJJF1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 01:27:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:45720 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932332AbVJJF1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 01:27:02 -0400
X-Authenticated: #20450766
Date: Mon, 10 Oct 2005 07:05:02 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m3psqewe30.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0510100704180.4120@poirot.grange>
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange> <m3slvtzf72.fsf@telia.com>
 <Pine.LNX.4.60.0509252026290.3089@poirot.grange> <m34q873ccc.fsf@telia.com>
 <Pine.LNX.4.60.0509262122450.4031@poirot.grange> <m3slvr1ugx.fsf@telia.com>
 <Pine.LNX.4.60.0509262358020.6722@poirot.grange> <m3hdc4ucrt.fsf@telia.com>
 <Pine.LNX.4.60.0509292116260.11615@poirot.grange> <m3k6gw86f0.fsf@telia.com>
 <Pine.LNX.4.60.0510092304550.14767@poirot.grange> <m3psqewe30.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Oct 2005, Peter Osterlund wrote:

> In that case, this patch should also work. Does it?

This is to 2.6.13, right?

Thanks
Guennadi

> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index d4b9c17..cb6bda9 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -538,7 +538,7 @@ static void pkt_iosched_process_queue(st
>  			spin_unlock(&pd->iosched.lock);
>  			if (bio && (bio->bi_sector == pd->iosched.last_write))
>  				need_write_seek = 0;
> -			if (need_write_seek && reads_queued) {
> +			if (!writes_queued && reads_queued) {
>  				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
>  					VPRINTK("pktcdvd: write, waiting\n");
>  					break;
> 
---
Guennadi Liakhovetski
