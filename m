Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262043AbSI3MnC>; Mon, 30 Sep 2002 08:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262044AbSI3MnC>; Mon, 30 Sep 2002 08:43:02 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:54266 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262043AbSI3MnC>; Mon, 30 Sep 2002 08:43:02 -0400
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: perex@suse.cz, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       alan@redhat.com
In-Reply-To: <20020929.175311.97852433.davem@redhat.com>
References: <3D9759FF.2050802@pobox.com>
	<Pine.LNX.4.33.0209292230500.591-100000@pnote.perex-int.cz> 
	<20020929.175311.97852433.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 13:54:11 +0100
Message-Id: <1033390451.16337.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 01:53, David S. Miller wrote:
>    From: Jaroslav Kysela <perex@suse.cz>
>    Date: Sun, 29 Sep 2002 22:34:51 +0200 (CEST)
>     
>    -	if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
>    +	if (hwdev == NULL || (u32)hwdev->dma_mask <= 0x00ffffff)
>     		gfp |= GFP_DMA;
> 
> So alan, why is this really broken?
> 
> EISA/ISA DMA is defined as using a hwdev of NULL or requiring
> <16MB address, he is preserving GFP_DMA in those cases.

Firstly the DMA mask on x86 can't be below 24bits, we don't support
allocation from a smaller zone. Secondly what about PCI for 25-31bits -
there we do need to force gfp_dma to have any chance of getting the
right pages

Giving the page allocator a mask argument does sound a lot nicer

