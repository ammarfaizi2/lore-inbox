Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWACVlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWACVlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWACVlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:41:11 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:18918 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964955AbWACVlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:41:09 -0500
Message-ID: <43BAEF69.3020006@austin.ibm.com>
Date: Tue, 03 Jan 2006 15:40:57 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yasunori Goto <y-goto@jp.fujitsu.com>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Patch] New zone ZONE_EASY_RECLAIM take 4. (Change PageHighMem())[8/8]
References: <20051220173217.1B18.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20051220173217.1B18.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch is change PageHighMem()'s definition for i386.
> Easy reclaim zone is treated like highmem on i386.

This doesn't look like an i386 file, it looks like you are changing it 
for all architectures that have HIGHMEM (do any other archs use 
highmeme?). This may be fine, just wanted you to be aware.

> 
> This is new patch at take 4.
> 
> Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
> 
> Index: zone_reclaim/include/linux/page-flags.h
> ===================================================================
> --- zone_reclaim.orig/include/linux/page-flags.h	2005-12-15 21:01:09.000000000 +0900
> +++ zone_reclaim/include/linux/page-flags.h	2005-12-15 21:24:07.000000000 +0900
> @@ -265,7 +265,7 @@ extern void __mod_page_state_offset(unsi
>  #define TestSetPageSlab(page)	test_and_set_bit(PG_slab, &(page)->flags)
>  
>  #ifdef CONFIG_HIGHMEM
> -#define PageHighMem(page)	is_highmem(page_zone(page))
> +#define PageHighMem(page)	is_higher_zone(page_zone(page))
>  #else
>  #define PageHighMem(page)	0 /* needed to optimize away at compile time */
>  #endif
> 


