Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262997AbVAFV01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbVAFV01 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVAFVY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:24:26 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28860 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263028AbVAFVWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:22:38 -0500
Subject: Re: [2.6.10-bk7] Oops: ide_dma_timeout_retry
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Simon Kirby <sim@netnation.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050106192357.GA1760@netnation.com>
References: <20050105233359.GA2327@netnation.com>
	 <1105023683.24896.213.camel@localhost.localdomain>
	 <20050106192357.GA1760@netnation.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105040975.17176.245.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 20:18:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-06 at 19:23, Simon Kirby wrote:
> On Thu, Jan 06, 2005 at 04:30:14PM +0000, Alan Cox wrote:
> I can't seem to find a post with the SGI fixes, and I don't see anything
> from a quick skim of the bk8 and bk9 logs (problem reproduced in bk7). 
> Could you point me to the relevant thread?

Don't think it got discussed on l/k. Dunno if its in the 2.6.10bk code
yet either

        rq->errors = 0;
                                                                                
        if (!rq->bio)
                goto out;
                                                                                
        rq->sector = rq->bio->bi_sector;
        rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
        rq->hard_cur_sectors = rq->current_nr_sectors;
        rq->buffer = bio_data(rq->bio);
out:
        return ret;


Is how the code should look at the end of ide_dma_timeout_retry (plus
your rq == NULL check I imagine)

