Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTH0PqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbTH0PqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:46:16 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:3489 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263444AbTH0PqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:46:15 -0400
Subject: Re: Promise IDE patches
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Niehusmann <jan@gondor.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030827151227.GA25198@gondor.com>
References: <20030826223158.GA25047@gondor.com>
	 <200308270054.27375.bzolnier@elka.pw.edu.pl>
	 <1061996391.22825.39.camel@dhcp23.swansea.linux.org.uk>
	 <20030827151227.GA25198@gondor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061999127.22739.60.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 16:45:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-27 at 16:12, Jan Niehusmann wrote:
> On Wed, Aug 27, 2003 at 03:59:52PM +0100, Alan Cox wrote:
> > If you fail to do this then existing PIO LBA48 setups will just die
> > on boot.
> 
> But 'die on boot' is much better than 'silently currupt data', don't you
> think? 
> Still, a proper fix would work in all cases... 

You'd prevent people from using valid working file systems in ways
that don't corrupt.

I think the logic we need is something like

	if drive_is_lba48 && controller_doesnt_do_lba48
		clip_capacity

as a variant of the current change. That covers the "no way" case. For
the others we need to check capacity requires lba48 && !dma_lba48
somewhere, probably ide_dma_check. That would make us drop out of DMA
for unsafe setups in a way that doesnt cause crashes or suprises and
still let everyone access the data properly.

