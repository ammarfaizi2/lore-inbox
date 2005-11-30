Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVK3XYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVK3XYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVK3XYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:24:13 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:27800 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751221AbVK3XYM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:24:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aCnGTiRS8YmosXdyEtvNgKKt0PYRAlHBcvZX0cn2AMNg9i/vFSU1tPCEt88dBzwMdK9WFLpRmCSlHf2zvrDyc9unopK0pxzDv3o9nUnw9QtQDr2G8tzuDUxV1VjGh7gldIAyhBiSJxneZPpy5X4IDPl6fkXnRAQIKbaf0cozxxU=
Message-ID: <fe726f4e0511301524r29303c18m@mail.gmail.com>
Date: Thu, 1 Dec 2005 00:24:10 +0100
From: =?ISO-8859-1?Q?Carlos_Mart=EDn?= <carlosmn@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc3-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051130123920.35193b6a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20051129203134.13b93f48.akpm@osdl.org>
	 <fe726f4e0511300932l2ee9eabdg@mail.gmail.com>
	 <20051130123920.35193b6a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/05, Andrew Morton <akpm@osdl.org> wrote:
> --- devel/arch/x86_64/kernel/pci-dma.c~move-swiotlb-header-file-into-common-code-fix-2  2005-11-30 12:38:52.000000000 -0800
> +++ devel-akpm/arch/x86_64/kernel/pci-dma.c     2005-11-30 12:38:52.000000000 -0800
> @@ -25,11 +25,11 @@
>   * the same here.
>   */
>  int dma_map_sg(struct device *hwdev, struct scatterlist *sg,
> -              int nents, int direction)
> +              int nents, enum dma_data_direction dir)
>  {
>         int i;
>
> -       BUG_ON(direction == DMA_NONE);
> +       BUG_ON(dir == DMA_NONE);
>         for (i = 0; i < nents; i++ ) {
>                 struct scatterlist *s = &sg[i];
>                 BUG_ON(!s->page);
> @@ -38,7 +38,6 @@ int dma_map_sg(struct device *hwdev, str
>         }
>         return nents;
>  }
> -
>  EXPORT_SYMBOL(dma_map_sg);
>
>  /* Unmap a set of streaming mode DMA translations.
> @@ -46,7 +45,7 @@ EXPORT_SYMBOL(dma_map_sg);
>   * pci_unmap_single() above.
>   */
>  void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> -                 int nents, int dir)
> +                 int nents, enum dma_data_direction dir)
>  {
>         int i;
>         for (i = 0; i < nents; i++) {
> @@ -56,5 +55,4 @@ void dma_unmap_sg(struct device *dev, st
>                 dma_unmap_single(dev, s->dma_address, s->dma_length, dir);
>         }
>  }
> -
>  EXPORT_SYMBOL(dma_unmap_sg);
> _
>
>

Right, of course, I should have seen that. It's running nicely with an
uptime of two and a half hours.
The patch is missing the header, btw.

   cmn
--
Carlos Martín Nieto        http://www.cmartin.tk

"¿Cómo voy a decir bobadas si soy mudo?" -- CACHAI
