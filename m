Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbVIMLca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbVIMLca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbVIMLca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:32:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:47547 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932609AbVIMLca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:32:30 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] Re: [1/3] Add 4GB DMA32 zone
Date: Tue, 13 Sep 2005 13:32:16 +0200
User-Agent: KMail/1.8
Cc: discuss@x86-64.org, zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com
References: <43246267.mailL4R11PXCB@suse.de> <200509131147.42140.ak@suse.de> <20050913031540.0c732284.akpm@osdl.org>
In-Reply-To: <20050913031540.0c732284.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509131332.17244.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm ok description is not very enlightening. 4 zones should indeed
still fit into 2 bits.

Kamezawa-san, can you please explain why exactly you did that change?

Thanks,
-Andi

On Tuesday 13 September 2005 12:15, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> > Andrew do you still have the patch with
> >  the description? It must have been between 2.6.13mm1 and  2.6.13mm2.
>
> From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>
> Because 2.6.13-mm2  adds new zone DMA32, ZONES_SHIFT becomes 3.
> So, flags bits reserved for (SECTION | NODE | ZONE) should be increase.
>
> ZONE_SHIFT is increased, FLAGS_RESERVED should be.
>
> Signed-off-by Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Cc: Andi Kleen <ak@muc.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  include/linux/mmzone.h |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff -puN include/linux/mmzone.h~x86_64-dma32-fix include/linux/mmzone.h
> --- 25/include/linux/mmzone.h~x86_64-dma32-fix	Fri Sep  9 17:13:41 2005
> +++ 25-akpm/include/linux/mmzone.h	Fri Sep  9 17:14:13 2005
> @@ -431,9 +431,10 @@ extern struct pglist_data contig_page_da
>  #if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
>  /*
>   * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
> - * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
> + * there are 4 zones (3 bits) and this leaves 8-2=6 bits for nodes.
> + * +6bits for sections if CONFIG_SPARSEMEM
>   */
> -#define FLAGS_RESERVED		8
> +#define FLAGS_RESERVED		9
>
>  #elif BITS_PER_LONG == 64
>  /*
> _
