Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbTIOPYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbTIOPYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:24:12 -0400
Received: from smtp.terra.es ([213.4.129.129]:54985 "EHLO tfsmtp3.mail.isp")
	by vger.kernel.org with ESMTP id S261468AbTIOPYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:24:08 -0400
From: CASINO_E <CASINO_E@teleline.es>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Reply-To: casino_e@terra.es
Message-ID: <d95d2d93f8.d93f8d95d2@teleline.es>
Date: Mon, 15 Sep 2003 17:24:05 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: Re: SII SATA request size limit
X-Accept-Language: es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me if I'm saying something stupid but, do you mean a special 
case for this controller in ide-dma.c:ide_build_dmatable()?

In this case, should not segment size and boundary be included in hwif 
so we can have a generic ide_build_dmatable() without dealing 
explicitly with special cases? We could initialize to the default for 
most controllers and set the values for the exceptions inside each 
particular driver.

----- Mensaje Original -----
De: Jens Axboe <axboe@suse.de>
Fecha: Lunes, Septiembre 15, 2003 10:47 am
Asunto: Re: SII SATA request size limit

> On Fri, Sep 12 2003, Eduardo Casino wrote:
> > Hi All,
> > 
> > I had a look at the NetBSD pciide.c driver and found this 
> interesting> bit of code:
> > 	
> > 	/*
> > 	 * Rev. <= 0x01 of the 3112 have a bug that can cause data
> > 	 * corruption if DMA transfers cross an 8K boundary.  This is
> > 	 * apparently hard to tickle, but we'll go ahead and play it
> > 	 * safe.
> > 	 */
> > 	if (PCI_REVISION(pa->pa_class) <= 0x01) {
> > 	        sc->sc_dma_maxsegsz = 8192;
> > 	        sc->sc_dma_boundary = 8192;
> > 	}
> > 
> > This is basically the same as setting hwif->rqsize to 15, but 
> the NetBSD
> 
> You can do much much better than that, it's pretty simply to just
> restrict the segment size and boundary if you have a controller with
> such a bug. And then you get the benefit of the larger requests too,
> it's basically not a performance hit at that point.
> 
> -- 
> Jens Axboe
> 
> 


