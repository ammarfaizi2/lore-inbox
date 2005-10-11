Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVJKVcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVJKVcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVJKVcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:32:09 -0400
Received: from imap.gmx.net ([213.165.64.20]:20358 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932309AbVJKVcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:32:08 -0400
X-Authenticated: #20450766
Date: Tue, 11 Oct 2005 23:31:22 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m3psqewe30.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0510112325410.19291@poirot.grange>
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

Well, I've had this patch (to 2.6.13) failing once, whereas I still 
haven't been able to reproduce the error with your previous patch. What 
now? A bit worrying is that test results are not 100% deterministic now... 
Which means, until recently my standard test (copy about 150M co the 
CD-RW && sync) produced always consistent results, now I've seen a couple 
of times the same driver version either failing or succeeding...

BTW, Peter, I still get errors from mails to you:

<petero2@telia.com>:
81.228.8.84_does_not_like_recipient./Remote_host_said:_553_RCPT_TO:<petero2@telia.com>_refused/G
iving_up_on_81.228.8.84./


Thanks
Guennadi
---
Guennadi Liakhovetski
