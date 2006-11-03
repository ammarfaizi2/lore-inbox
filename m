Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753363AbWKCQma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbWKCQma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbWKCQma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:42:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64155 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753363AbWKCQm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:42:29 -0500
Subject: Re: [PATCH 5/8] resend cciss: disable DMA prefetch on P600
From: Arjan van de Ven <arjan@infradead.org>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: akpm@osdl.org, jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20061103155412.GA1657@beardog.cca.cpqcorp.net>
References: <20061103155412.GA1657@beardog.cca.cpqcorp.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 03 Nov 2006 17:42:15 +0100
Message-Id: <1162572135.3160.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 09:54 -0600, Mike Miller (OS Dev) wrote:
> PATCH 5 of 8 resend
> 
> This patch unconditionally disables DMA prefetch on the P600 controller. A
> bug in the ASIC may result in prefetching either beyond the end of memory
> or to fall off into a memory hole.
> Please consider this for inclusion.
> 
> Thanks,
> mikem
> 
> Signed-off-by: Mike Miller <mike.miller@hp.com>
> 
>  cciss.c     |   13 +++++++++++++
>  cciss_cmd.h |    1 +
>  2 files changed, 14 insertions(+)
> --------------------------------------------------------------------------------
> diff -urNp linux-2.6-p00004/drivers/block/cciss.c linux-2.6-p00005/drivers/block/cciss.c
> --- linux-2.6-p00004/drivers/block/cciss.c	2006-10-31 15:20:25.000000000 -0600
> +++ linux-2.6-p00005/drivers/block/cciss.c	2006-11-03 09:43:55.000000000 -0600
> @@ -2997,6 +2997,19 @@ static int cciss_pci_init(ctlr_info_t *c
>  	}
>  #endif
>  
> +	{
> +		/* Disabling DMA prefetch for the P600
> +		 * An ASIC bug may result in a prefetch beyond
> +		 * physical memory.
> +		 */
> +		__u32 dma_prefetch
> +		if(board_id == 0x3225103C) {
> +			dma_prefetch = readl(c->vaddr + I2O_DMA1_CFG);
> +			dma_prefetch |= 0x8000;
> +			writel(dma_prefetch, c->vaddr + I2O_DMA1_CFG);
> +		}
> +	}
> +

if you remove the if() you might as well also remove the {}'s ;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

