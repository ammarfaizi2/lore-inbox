Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316977AbSFKXBN>; Tue, 11 Jun 2002 19:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317031AbSFKXBN>; Tue, 11 Jun 2002 19:01:13 -0400
Received: from p50886B65.dip.t-dialin.net ([80.136.107.101]:49899 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316977AbSFKXBM>; Tue, 11 Jun 2002 19:01:12 -0400
Date: Tue, 11 Jun 2002 17:00:51 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Roland Dreier <roland@topspin.com>
cc: "David S. Miller" <davem@redhat.com>, <oliver@neukum.name>,
        <wjhun@ayrnetworks.com>, <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52y9dl65aa.fsf@topspin.com>
Message-ID: <Pine.LNX.4.44.0206111657220.24261-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11 Jun 2002, Roland Dreier wrote:
> 3) Change the code to
> 
>         struct something {
>                 int field1;
>                 char *dma_buffer;
>                 int field2;
>         };
> 
>         struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);
>         /* find pci_device */
>         dev->dma_buffer = aligned_pci_alloc(pci_device, SMALLER_THAN_CACHELINE);
>         /* do DMA into dev->dma_buffer */

You introduce a possible null pointer dereference here, don't you?

// Assume this fails:
struct something *dev = kmalloc(sizeof(struct something), GFP_KERNEL);
// dev is a NULL pointer now.
dev->dma_buffer = aligned_pci_alloc(pci_device, SMALLER_THAN_CACHELINE);
// Big bang

Just wondering...

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

