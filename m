Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSLMKCp>; Fri, 13 Dec 2002 05:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSLMKCp>; Fri, 13 Dec 2002 05:02:45 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:25582 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S261842AbSLMKCo>; Fri, 13 Dec 2002 05:02:44 -0500
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions)
From: Arjan van de Ven <arjanv@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200212122247.gBCMlHgY011021@turing-police.cc.vt.edu>
References: <200212122247.gBCMlHgY011021@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Dec 2002 11:10:24 +0100
Message-Id: <1039774224.1449.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 23:47, Valdis.Kletnieks@vt.edu wrote:

> Been there. Done that. Does the attached patch help? It did for me.
> 
> /Valdis
> 
> 
> ----
> 

> --- drivers/pcmcia/cardbus.c.dist	2002-12-03 01:49:29.000000000 -0500
> +++ drivers/pcmcia/cardbus.c	2002-12-03 01:50:23.000000000 -0500
> @@ -283,8 +283,6 @@
>  		dev->hdr_type = hdr & 0x7f;
>  
>  		pci_setup_device(dev);
> -		if (pci_enable_device(dev))
> -			continue;
>  
>  		strcpy(dev->dev.bus_id, dev->slot_name);
>  
> @@ -302,6 +300,8 @@
>  			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
>  		}
>  
> +		if (pci_enable_device(dev))
> +			continue;
>  		device_register(&dev->dev);
>  		pci_insert_device(dev, bus);
>  	}

interesting. BUT aren't we writing to the device 3 lines before where
you add the pci_enable_device()? That sounds like a bad plan to me ;(
