Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292960AbSCDW6N>; Mon, 4 Mar 2002 17:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292962AbSCDW5x>; Mon, 4 Mar 2002 17:57:53 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64776
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292960AbSCDW5o>; Mon, 4 Mar 2002 17:57:44 -0500
Date: Mon, 4 Mar 2002 14:57:01 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: William Jhun <wjhun@ayrnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide_free_irq()
In-Reply-To: <20020304141709.C1247@ayrnetworks.com>
Message-ID: <Pine.LNX.4.10.10203041456040.13256-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sure but only one arch I see that is effected and they do not use this
storage class ...

asm-s390/ide.h:#define ide_free_irq(irq,dev_id)         do {} while (0)
asm-s390x/ide.h:#define ide_free_irq(irq,dev_id)        do {} while (0)

Is there another ?

On Mon, 4 Mar 2002, William Jhun wrote:

> Simple patch. The current drivers/ide/ide.c calls free_irq() instead of
> ide_free_irq(). We depend on these alternate routines to deal with our
> semi-broken hardware, but since ide-probe.c calls ide_reqest_irq(), it
> seems logical that this should also be ide_free_irq().
> 
> Thanks,
> Will Jhun
> 
> *** drivers/ide/ide.c.orig	Mon Feb 25 11:37:57 2002
> --- drivers/ide/ide.c	Mon Mar  4 14:05:41 2002
> ***************
> *** 2115,2121 ****
>   		g = g->next;
>   	} while (g != hwgroup->hwif);
>   	if (irq_count == 1)
> ! 		free_irq(hwif->irq, hwgroup);
>   
>   	/*
>   	 * Note that we only release the standard ports,
> --- 2115,2121 ----
>   		g = g->next;
>   	} while (g != hwgroup->hwif);
>   	if (irq_count == 1)
> ! 		ide_free_irq(hwif->irq, hwgroup);
>   
>   	/*
>   	 * Note that we only release the standard ports,
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

