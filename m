Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422706AbWHLVZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422706AbWHLVZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422709AbWHLVZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:25:10 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:37357 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422706AbWHLVZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:25:09 -0400
Message-ID: <44DE4788.8050200@free.fr>
Date: Sat, 12 Aug 2006 23:26:32 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: 2.6.18-rc3-mm2 - OOM storm
References: <20060806030809.2cfb0b1e.akpm@osdl.org>	 <44DAF6A4.9000004@free.fr>  <20060810021957.38c82311.akpm@osdl.org> <1155395232.5948.21.camel@Homer.simpson.net>
In-Reply-To: <1155395232.5948.21.camel@Homer.simpson.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 12.08.2006 17:07, Mike Galbraith a écrit :
> On Thu, 2006-08-10 at 02:19 -0700, Andrew Morton wrote:
> 
>> It would be interesting to try disabling CONFIG_ADAPTIVE_READAHEAD -
>> perhaps that got broken.
> 
> A typo was pinning pagecache.  Fixes leak encountered with rpm -qaV.

Problem fixed here too. Thanks
 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> 
> --- linux-2.6.18-rc3-mm2/mm/filemap.c.org	2006-08-12 14:04:14.000000000 +0000
> +++ linux-2.6.18-rc3-mm2/mm/filemap.c	2006-08-12 14:07:53.000000000 +0000
> @@ -1498,7 +1498,7 @@ retry_find:
>  			page_cache_readahead_adaptive(mapping, ra,
>  						file, NULL, NULL,
>  						pgoff, pgoff, pgoff + 1);
> -			page = find_lock_page(mapping, pgoff);
> +			page = find_get_page(mapping, pgoff);
>  		} else if (PageReadahead(page)) {
>  			page_cache_readahead_adaptive(mapping, ra,
>  						file, NULL, page,
> 
> 

-- 
laurent
