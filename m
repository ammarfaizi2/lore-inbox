Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315342AbSDWVWn>; Tue, 23 Apr 2002 17:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315343AbSDWVWm>; Tue, 23 Apr 2002 17:22:42 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:20493
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315342AbSDWVWm>; Tue, 23 Apr 2002 17:22:42 -0400
Date: Tue, 23 Apr 2002 14:20:48 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Ed Sweetman <ed.sweetman@wmich.edu>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam5
In-Reply-To: <20020423140531.GC2048@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10204231420300.2264-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This exactly what I did :-)

Cheers,


On Tue, 23 Apr 2002, J.A. Magallon wrote:

> 
> On 2002.04.23 Andre Hedrick wrote:
> >
> >bottom of ide-pci.c
> >
> >there is a failed test to isolate multi-function chips which carry a real
> >host inside.
> >
> >ide_scan_pcidev()
> >
> >else if (d->order_fix)
> >	d->order_fix(dev, d);
> >--
> >--
> >--
> >
> >delete the three lines after d->order_fix(dev, d);
> >
> 
> Planning to include a 41-ide-6-promise-fix.gz in -pre7-jam6 with:
> 
> --- linux/drivers/ide/ide-pci.c.org	2002-04-23 15:57:13.000000000 +0200
> +++ linux/drivers/ide/ide-pci.c	2002-04-23 15:57:57.000000000 +0200
> @@ -918,9 +918,11 @@
>  			"(uses own driver)\n", d->name);
>  	else if (d->order_fix)
>  		d->order_fix(dev, d);
> +#if 0
>  	else if (((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) &&
>  		 (!(PCI_FUNC(dev->devfn) & 1)))
>  		return;
> +#endif
>  	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886A) &&
>  		 (!(PCI_FUNC(dev->devfn) & 1)))
>  		return;	/* UM8886A/BF pair */
> 
> so text stays there for reference....
> 
> -- 
> J.A. Magallon                           #  Let the source be with you...        
> mailto:jamagallon@able.es
> Mandrake Linux release 8.3 (Cooker) for i586
> Linux werewolf 2.4.19-pre7-jam5 #1 SMP mar abr 23 01:29:38 CEST 2002 i686
> 

Andre Hedrick
LAD Storage Consulting Group

