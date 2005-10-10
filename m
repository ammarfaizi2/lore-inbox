Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVJJRuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVJJRuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVJJRuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:50:16 -0400
Received: from pop.gmx.de ([213.165.64.20]:58516 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751093AbVJJRuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:50:14 -0400
X-Authenticated: #20450766
Date: Mon, 10 Oct 2005 19:48:12 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m3psqewe30.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0510101947040.6650@poirot.grange>
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

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
> 
> > On Sun, 2 Oct 2005, Peter Osterlund wrote:
> > 
> > > OK, in that case this patch for 2.6.12 should work as well, because
> > > all it does compared to the previous patch is to remove the now unused
> > > high_prio_read variables. Can you confirm that it works?
> > 
> > Yes, it does.
> 
> In that case, this patch should also work. Does it?

Yes. 2.6.13 + this patch work for me.

Thanks
Guennadi

> 
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
> -- 
> Peter Osterlund - petero2@telia.com
> http://web.telia.com/~u89404340
> 

---
Guennadi Liakhovetski
