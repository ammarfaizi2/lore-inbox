Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVILGJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVILGJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 02:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVILGJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 02:09:57 -0400
Received: from dvhart.com ([64.146.134.43]:23425 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750802AbVILGJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 02:09:57 -0400
Date: Sun, 11 Sep 2005 23:09:59 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-ID: <208180000.1126505399@[10.10.2.4]>
In-Reply-To: <20050912050122.GA3830@muc.de>
References: <20050908053042.6e05882f.akpm@osdl.org> <201750000.1126494444@[10.10.2.4]> <20050912050122.GA3830@muc.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Andi, does that need changing on ia32 as well as x86_64, or are you
>> just missing some ifdefs? Looks to me like the rest of the patch is
>> specific to x86_64.
> 
> It should be a straight forward fix - the new zone is empty on i386.
> Ok I reviewed chunk_to_zone and it should be ok with the new empty
> zone. So just the appended patch should work. Can you test?

Will do. but did you actually mean to enable it on both arches? didn't
look like it, but maybe you did.
 
> -AndI
> 
> Make i386 compile again with fourth DMA32 zone
> 
> The code should deal with an additiona empty zone, so fix up the
># error.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/arch/i386/kernel/srat.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/srat.c
> +++ linux/arch/i386/kernel/srat.c
> @@ -137,8 +137,8 @@ static void __init parse_memory_affinity
>  		 "enabled and removable" : "enabled" ) );
>  }
>  
> -#if MAX_NR_ZONES != 3
> -#error "MAX_NR_ZONES != 3, chunk_to_zone requires review"
> +#if MAX_NR_ZONES != 4
> +#error "MAX_NR_ZONES != 4, chunk_to_zone requires review"
>  #endif
>  /* Take a chunk of pages from page frame cstart to cend and count the number
>   * of pages in each zone, returned via zones[].
> 
> 
> 
> 
> 


