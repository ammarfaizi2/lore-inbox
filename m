Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313568AbSDLNaT>; Fri, 12 Apr 2002 09:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313741AbSDLNaS>; Fri, 12 Apr 2002 09:30:18 -0400
Received: from copper.ftech.net ([212.32.16.118]:15584 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S313568AbSDLNaR>;
	Fri, 12 Apr 2002 09:30:17 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E428C@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'admin@nextframe.net'" <admin@nextframe.net>,
        Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [patch] 2.5.8-pre3 - drivers/net/wan/farsync.c
Date: Fri, 12 Apr 2002 14:30:04 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	yes this patch is fine.  I will submit another later today to fix
the pci_enable_device problem, but the supa-dupa performance patch needs
some more testing yet.

Kevin


-----Original Message-----
From: Morten Helgesen [mailto:admin@nextframe.net]
Sent: 12 April 2002 12:57
To: Francois Romieu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.8-pre3 - drivers/net/wan/farsync.c


Hey, Francois! 

I`ve been working with Kevin Curtis <kevin.curtis@farsite.co.uk> (the
current maintainer of farsync.c) the last couple
of days, and we`ve performed a bit of spring cleaning, including
pci_enable_device() fixes and this fix for
dev->rmem_end/start. Kevin also said he has been working on performance
issues, so the next release of this driver should be
really fancy :) 

Right, Kevin ? :)

== Morten

On Fri, Apr 12, 2002 at 01:34:38PM +0200, Francois Romieu wrote:
> Greetings,
> 
> Problem:
> compilation fails due to removal of rmem_{start/end} in struct net_device.
> 
> Fix:
> Simple removal. I haven't found any other use of these fields in the
driver.
> 
> --- linux-2.5.8-pre3.orig/drivers/net/wan/farsync.c	Thu Apr 11 23:51:52
2002
> +++ linux-2.5.8-pre3/drivers/net/wan/farsync.c	Thu Apr 11 23:55:24
2002
> @@ -1469,10 +1469,6 @@ fst_init_card ( struct fst_card_info *ca
>                                   + BUF_OFFSET ( txBuffer[i][0][0]);
>                  dev->mem_end     = card->phys_mem
>                                   + BUF_OFFSET (
txBuffer[i][NUM_TX_BUFFER][0]);
> -                dev->rmem_start  = card->phys_mem
> -                                 + BUF_OFFSET ( rxBuffer[i][0][0]);
> -                dev->rmem_end    = card->phys_mem
> -                                 + BUF_OFFSET (
rxBuffer[i][NUM_RX_BUFFER][0]);
>                  dev->base_addr   = card->pci_conf;
>                  dev->irq         = card->irq;
>  
> -- 
> Ueimor
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
