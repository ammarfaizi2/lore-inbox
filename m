Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVILM2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVILM2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVILM2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:28:46 -0400
Received: from mail.suse.de ([195.135.220.2]:9900 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750783AbVILM2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:28:45 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [1/3] Add 4GB DMA32 zone
Date: Mon, 12 Sep 2005 14:28:39 +0200
User-Agent: KMail/1.8
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <43246267.mailL4R11PXCB@suse.de> <200509121322.09138.ak@suse.de> <1126528473.30449.59.camel@localhost.localdomain>
In-Reply-To: <1126528473.30449.59.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121428.40127.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 14:34, Alan Cox wrote:
> On Llu, 2005-09-12 at 13:22 +0200, Andi Kleen wrote:
> > And with the mempool sleep approach they will just get small queues. Yes
> > that will be slower, but if you want performance on boxes with a lot of
> > memory you should not buy broken hardware.
>
> Ironically its broken hardware it works best with. AMD64 is problematic
> but Intel with the swiotlb works ;)

Actually the swiotlb code currently doesn't attempt to handle dma masks
<4GB even when the bounce pool happens to be located lower - it will just fail 
or use GFP_DMA. It could be fixed in theory, but it would be pretty 
unreliable and sometimes work on one system and sometimes not, so I would be 
reluctant to go down that path.

Also BTW on many systems which don't allocate the IOMMU aperture in BIOS and 
Linux has to allocate it over memory it tends to be as low (or high) as the 
swiotlb pool - it is bootmem allocated at roughly the same place in boot.
But again the code doesn't attempt to handle that, it just uses hardcoded
0xffffffff masks.

-Andi
