Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbVAFWSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbVAFWSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbVAFWSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:18:23 -0500
Received: from newpeace.netnation.com ([204.174.223.7]:37086 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP id S263100AbVAFWSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:18:07 -0500
Date: Thu, 6 Jan 2005 14:18:02 -0800
From: Simon Kirby <sim@netnation.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.10-bk7] Oops: ide_dma_timeout_retry
Message-ID: <20050106221801.GB1760@netnation.com>
References: <20050105233359.GA2327@netnation.com> <1105023683.24896.213.camel@localhost.localdomain> <20050106192357.GA1760@netnation.com> <1105040975.17176.245.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105040975.17176.245.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 08:18:22PM +0000, Alan Cox wrote:

> Don't think it got discussed on l/k. Dunno if its in the 2.6.10bk code
> yet either
> 
>         rq->errors = 0;
>                                                                                 
>         if (!rq->bio)
>                 goto out;
>                                                                                 
>         rq->sector = rq->bio->bi_sector;
>         rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
>         rq->hard_cur_sectors = rq->current_nr_sectors;
>         rq->buffer = bio_data(rq->bio);
> out:
>         return ret;
> 
> 
> Is how the code should look at the end of ide_dma_timeout_retry (plus
> your rq == NULL check I imagine)

The only difference with the code in 2.6.10 (ide-io.c is currently
unchanged in bk9) is rq->buffer is set to NULL instead of
bio_data(rq->bio)... I suppose this is the corruption fix?

Simon-
