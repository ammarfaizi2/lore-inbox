Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbUBRKqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUBRKqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:46:37 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:12488 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S264163AbUBRKqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:46:33 -0500
Subject: Re: Any guides for adding new IDE chipset drivers?
From: Alex Bennee <kernel-hacker@bennee.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <200402172010.34114.bzolnier@elka.pw.edu.pl>
References: <1077028026.31892.153.camel@cambridge.braddahead.com>
	 <200402172010.34114.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1077100866.31859.164.camel@cambridge.braddahead.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Wed, 18 Feb 2004 10:41:06 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-17 at 19:10, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 17 of February 2004 15:27, Alex Bennee wrote:
> >
> > Thanks. I'll base my driver on this one as it does seem quite easy
> > to follow. However I'm wondering what the point of the begin/end functions
> > are. The dma_read/write functions just seem to call dma_count which starts
> > the dma requests going.
> 
> hwif->ide_dma_count() is gone in 2.6.3-rc4.

Ok that makes sense. However I'm working with 2.4 as I'm not ready to
make the jump in versions yet. However the rest of your notes make
things clearer.

> ATAPI drivers (ie. ide-cd.c) and TCQ code (ide-tcq.c)
> use ->ide_dma_begin() and ->ide_dma_end() directly.
> 
> DMA timeout recovery functions also call ->ide_dma_end().

I take it the dma_test_irq() function is called from the ide layer can
just test to see if the DMA engine has finished its transfer?

> > Am I missing something here? Is all that required from the higher level a
> > single call to dma_read/write or should I be expecting a series of calls to
> > setup a transfer?
> 
> To setup a DMA transfer:
> 
> ATA: ->ide_dma_{read,write}() (they call ->ide_dma_begin()) or
>      __ide_dma_queued_{read,write}() (they may call ->ide_dma_begin())
> 
> ATAPI: ->ide_dma_{read,write}() + ->ide_dma_begin()
> 
> Hope this helps.

It does thanks :-)

-- 
Alex, homepage: http://www.bennee.com/~alex/
Leela: "Well, it's a type M planet, so it should at least have
Roddenberries." 

