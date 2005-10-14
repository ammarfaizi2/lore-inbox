Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVJNEzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVJNEzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 00:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVJNEzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 00:55:04 -0400
Received: from [85.8.13.51] ([85.8.13.51]:26765 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751118AbVJNEzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 00:55:02 -0400
Message-ID: <434F3A1E.7000403@drzeus.cx>
Date: Fri, 14 Oct 2005 06:54:54 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, iss_storagedev@hp.com,
       Jakub Jelinek <jj@ultra.linux.cz>, Frodo Looijaard <frodol@dds.nl>,
       Jean Delvare <khali@linux-fr.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Roland Dreier <rolandd@cisco.com>,
       Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pierre Ossman <drzeus-wbsd@drzeus.cx>,
       Carsten Gross <carsten@sol.wh-hms.uni-ulm.de>,
       Greg Kroah-Hartman <greg@kroah.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Vinh Truong <vinh.truong@eng.sun.com>,
       Mark Douglas Corner <mcorner@umich.edu>,
       Michael Downey <downey@zymeta.com>, Antonino Daplas <adaplas@pol.net>,
       Ben Gardner <bgardner@wabtec.com>
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
References: <200510132128.45171.jesper.juhl@gmail.com>
In-Reply-To: <200510132128.45171.jesper.juhl@gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> This is the remaining misc drivers/ part of the big kfree cleanup patch.
> 
> Remove pointless checks for NULL prior to calling kfree() in misc files in drivers/.
> 
> 
> Sorry about the long Cc: list, but I wanted to make sure I included everyone
> who's code I've changed with this patch.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> --- linux-2.6.14-rc4-orig/drivers/mmc/wbsd.c	2005-10-11 22:41:10.000000000 +0200
> +++ linux-2.6.14-rc4/drivers/mmc/wbsd.c	2005-10-12 15:43:04.000000000 +0200
> @@ -1595,8 +1595,7 @@ static void __devexit wbsd_release_dma(s
>  	if (host->dma_addr)
>  		dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
>  			DMA_BIDIRECTIONAL);
> -	if (host->dma_buffer)
> -		kfree(host->dma_buffer);
> +	kfree(host->dma_buffer);
>  	if (host->dma >= 0)
>  		free_dma(host->dma);
>  

Looks good. Thanks.

Acked-by: Pierre Ossman <drzeus@drzeus.cx>

