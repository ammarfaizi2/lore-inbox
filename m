Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbSI3Ayf>; Sun, 29 Sep 2002 20:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261878AbSI3Ayf>; Sun, 29 Sep 2002 20:54:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29355 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261877AbSI3Aye>;
	Sun, 29 Sep 2002 20:54:34 -0400
Date: Sun, 29 Sep 2002 17:53:11 -0700 (PDT)
Message-Id: <20020929.175311.97852433.davem@redhat.com>
To: perex@suse.cz
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0209292230500.591-100000@pnote.perex-int.cz>
References: <3D9759FF.2050802@pobox.com>
	<Pine.LNX.4.33.0209292230500.591-100000@pnote.perex-int.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jaroslav Kysela <perex@suse.cz>
   Date: Sun, 29 Sep 2002 22:34:51 +0200 (CEST)
    
   -	if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
   +	if (hwdev == NULL || (u32)hwdev->dma_mask <= 0x00ffffff)
    		gfp |= GFP_DMA;

So alan, why is this really broken?

EISA/ISA DMA is defined as using a hwdev of NULL or requiring
<16MB address, he is preserving GFP_DMA in those cases.

The only problem I have with the patch is that it probably isn't
that hard to let the page allocator take some MASK arg (defaults
to all 1's) to implement this in 2.5.x
