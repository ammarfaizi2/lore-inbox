Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSKNSVX>; Thu, 14 Nov 2002 13:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSKNSVX>; Thu, 14 Nov 2002 13:21:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30483 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261317AbSKNSVW>;
	Thu, 14 Nov 2002 13:21:22 -0500
Message-ID: <3DD3EB3D.8050606@pobox.com>
Date: Thu, 14 Nov 2002 13:28:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       mochel@osdl.org
Subject: Re: [PATCH] eliminate pci_dev name
References: <20021114171017.B30392@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20021114171017.B30392@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:

> diff -urpNX dontdiff linux-2.5.47/include/linux/pci.h 
> linux-2.5.47-willy/include/linux/pci.h
> --- linux-2.5.47/include/linux/pci.h	2002-11-14 10:52:17.000000000 -0500
> +++ linux-2.5.47-willy/include/linux/pci.h	2002-11-14 
> 11:43:40.000000000 -0500
> @@ -371,7 +371,6 @@ struct pci_dev {
>  	struct resource dma_resource[DEVICE_COUNT_DMA];
>  	struct resource irq_resource[DEVICE_COUNT_IRQ];
>
> -	char		name[90];	/* device name */
>  	char		slot_name[8];	/* slot name */
>  	int		active;		/* ISAPnP: device is active */
>  	int		ro;		/* ISAPnP: read only */
>


Patch looks pretty good to me... seems like the obvious (and useful) 
cleanup.

You should increase DEVICE_NAME_SIZE in include/linux/device.h from 80 
to 90, though.  I assume you don't want to take the other option, which 
is to audit every use and all the id strings to make sure they're short 
enough.  In fact, IIRC, device name increased in size due to some really 
long PCI names, so I think '90' will wind up the preferred value in any 
case.

	Jeff



