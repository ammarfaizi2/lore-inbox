Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTIOIra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 04:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTIOIra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 04:47:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17067 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262143AbTIOIr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 04:47:28 -0400
Date: Mon, 15 Sep 2003 10:47:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Eduardo Casino <casino_e@terra.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
Message-ID: <20030915084722.GD27105@suse.de>
References: <1063399684.1184.7.camel@centinela>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063399684.1184.7.camel@centinela>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12 2003, Eduardo Casino wrote:
> Hi All,
> 
> I had a look at the NetBSD pciide.c driver and found this interesting
> bit of code:
> 	
> 	/*
> 	 * Rev. <= 0x01 of the 3112 have a bug that can cause data
> 	 * corruption if DMA transfers cross an 8K boundary.  This is
> 	 * apparently hard to tickle, but we'll go ahead and play it
> 	 * safe.
> 	 */
> 	if (PCI_REVISION(pa->pa_class) <= 0x01) {
> 		sc->sc_dma_maxsegsz = 8192;
> 		sc->sc_dma_boundary = 8192;
> 	}
> 
> This is basically the same as setting hwif->rqsize to 15, but the NetBSD

You can do much much better than that, it's pretty simply to just
restrict the segment size and boundary if you have a controller with
such a bug. And then you get the benefit of the larger requests too,
it's basically not a performance hit at that point.

-- 
Jens Axboe

