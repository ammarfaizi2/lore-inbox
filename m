Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWGSCTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWGSCTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 22:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWGSCTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 22:19:35 -0400
Received: from in.cluded.net ([195.159.98.120]:11144 "EHLO in.cluded.net")
	by vger.kernel.org with ESMTP id S932450AbWGSCTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 22:19:34 -0400
Message-ID: <44BD95C9.8050600@cluded.net>
Date: Wed, 19 Jul 2006 02:15:37 +0000
From: "Daniel K." <daniel@cluded.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060307 SeaMonkey/1.5a
MIME-Version: 1.0
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
CC: linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
       twoller@crystal.cirrus.com, James@superbug.demon.co.uk, zab@zabbo.net,
       sailer@ife.ee.ethz.ch, perex@suse.cz, zaitcev@yahoo.com
Subject: Re: [PATCH] sound: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060719005455.GB30823@lumumba.uhasselt.be>
In-Reply-To: <20060719005455.GB30823@lumumba.uhasselt.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:
> diff --git a/sound/oss/swarm_cs4297a.c b/sound/oss/swarm_cs4297a.c
> index eb5ea32..b257f20 100644
> --- a/sound/oss/swarm_cs4297a.c
> +++ b/sound/oss/swarm_cs4297a.c
> @@ -615,25 +615,23 @@ static int init_serdma(serdma_t *dma)
>  
>          /* Descriptors */
>          dma->ringsz = DMA_DESCR;
> -        dma->descrtab = kmalloc(dma->ringsz * sizeof(serdma_descr_t), GFP_KERNEL);
> +        dma->descrtab = kcalloc(dma->ringsz, sizeof(serdma_descr_t), GFP_KERNEL);
>          if (!dma->descrtab) {
>                  printk(KERN_ERR "cs4297a: kmalloc descrtab failed\n");

Maybe change the error message as well?

>                  return -1;
>          }
> -        memset(dma->descrtab, 0, dma->ringsz * sizeof(serdma_descr_t));
>          dma->descrtab_end = dma->descrtab + dma->ringsz;
>  	/* XXX bloddy mess, use proper DMA API here ...  */
>  	dma->descrtab_phys = CPHYSADDR((long)dma->descrtab);
>          dma->descr_add = dma->descr_rem = dma->descrtab;
>  
>          /* Frame buffer area */
> -        dma->dma_buf = kmalloc(DMA_BUF_SIZE, GFP_KERNEL);
> +        dma->dma_buf = kzalloc(DMA_BUF_SIZE, GFP_KERNEL);
>          if (!dma->dma_buf) {
>                  printk(KERN_ERR "cs4297a: kmalloc dma_buf failed\n");

here too

>                  kfree(dma->descrtab);
>                  return -1;
>          }
> -        memset(dma->dma_buf, 0, DMA_BUF_SIZE);
>          dma->dma_buf_phys = CPHYSADDR((long)dma->dma_buf);
>  
>          /* Samples buffer area */


Daniel K.

