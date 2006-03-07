Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWCGXVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWCGXVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWCGXVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:21:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:58593 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964800AbWCGXVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:21:30 -0500
Subject: Re: [TG3]: Add DMA address workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Michael Chan <mchan@broadcom.com>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <200603071900.k27J0YSP023014@hera.kernel.org>
References: <200603071900.k27J0YSP023014@hera.kernel.org>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 10:21:07 +1100
Message-Id: <1141773668.11221.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 19:00 +0000, Linux Kernel Mailing List wrote:
> commit 72f2afb8a6858edd9335cd158eb21053a0c2c39a
> tree 1cc6884bf4e48822423d23d68d7b2699cd2e68fd
> parent d11d9b2dd2c43dd99a491df8a83ae28401db0044
> author Michael Chan <mchan@broadcom.com> Tue, 07 Mar 2006 11:28:35 -0800
> committer David S. Miller <davem@davemloft.net> Tue, 07 Mar 2006 11:28:35 -0800
> 
> [TG3]: Add DMA address workaround
> 
> Add DMA workaround for chips that do not support full 64-bit DMA
> addresses.
> 
> 5714, 5715, and 5780 chips only support DMA addresses less than 40
> bits. On 64-bit systems with IOMMU, set the dma_mask to 40-bit so
> that pci_map_xxx() calls will map the DMA address below 40 bits if
> necessary. On 64-bit systems without IOMMU, set the dma_mask to
> 64-bit and check for DMA addresses exceeding the limit in
> tg3_start_xmit().
> 
> 5788 only supports 32-bit DMA so need to set the mask appropriately
> also.

I suppose that means I need to update the ppc64 iommu code to actually
honor the DMA mask when allocating ;) That will be easy for "dumb"
iommu's like the G5 but might be a bit more tricky with pSeries.

Anton, Paul, we have no control on the DMA ranges allocated to each phb
in the system, do we know if they go beyond 32 bits ? (And if yes,
beyond 40 bits)

Ben.


