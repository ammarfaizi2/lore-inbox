Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbRAXJYv>; Wed, 24 Jan 2001 04:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130755AbRAXJYb>; Wed, 24 Jan 2001 04:24:31 -0500
Received: from styx.suse.cz ([195.70.145.226]:4336 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130431AbRAXJYX>;
	Wed, 24 Jan 2001 04:24:23 -0500
Date: Wed, 24 Jan 2001 10:24:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] No VIA IDE DMA unless configured
Message-ID: <20010124102418.B1031@suse.cz>
In-Reply-To: <Pine.LNX.4.30.0101232239280.27097-100000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101232239280.27097-100000@svea.tellus>; from tori@tellus.mine.nu on Tue, Jan 23, 2001 at 10:46:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 10:46:14PM +0100, Tobias Ringstrom wrote:

> Linus, please consider this patch for 2.4.1.  It makes sure the VIA IDE
> driver does not enable DMA automatically, unless the user has requested it
> using "make whateverconfig".
> 
> /Tobias
> 
> --- via82cxxx.c.orig	Tue Jan 23 22:26:25 2001
> +++ via82cxxx.c	Tue Jan 23 22:27:05 2001
> @@ -602,7 +602,9 @@
>  #ifdef CONFIG_BLK_DEV_IDEDMA
>  	if (hwif->dma_base) {
>  		hwif->dmaproc = &via82cxxx_dmaproc;
> +#ifdef CONFIG_IDEDMA_AUTO
>  		hwif->autodma = 1;
> +#endif /* CONFIG_IDEDMA_AUTO */
>  	}
>  #endif /* CONFIG_BLK_DEV_IDEDMA */
>  }
> 

Linus, if you haven't applied my disable-dma-in-all-cases patch I've
sent you earlier, please do apply this one - it's correct and should be
there. It conflicts with the older one, obviously.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
