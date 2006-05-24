Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWEXBTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWEXBTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWEXBTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:19:15 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42667 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932530AbWEXBTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:19:15 -0400
Date: Wed, 24 May 2006 10:18:50 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Patch]Fix spanned_pages is not updated at a case of memory hot-add.
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1148401689.8658.12.camel@localhost.localdomain>
References: <20060523170830.97E1.Y-GOTO@jp.fujitsu.com> <1148401689.8658.12.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060524100531.3468.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really don't like the idea of having this variable called "new_"
> something.  That implies that this is what the new end_pfn is going to
> be.  The *new* one.  In reality, it is what it _might_ have been.  How
> about "tmp_zone_end_pfn"?
> 
> This practice of dealing with spanned_pages is a real pain. 
> 
> I generally try to avoid max/min in code, but this struck me as possibly
> being useful.  Do you find this easier to read, or your patch?

Ah, I think using max is better due to smaller code, indeed.

> 
> diff -puN mm/memory_hotplug.c~fix-spanned-pages mm/memory_hotplug.c
> --- work/mm/memory_hotplug.c~fix-spanned-pages	2006-05-23 09:04:31.000000000 -0700
> +++ work-dave/mm/memory_hotplug.c	2006-05-23 09:22:18.000000000 -0700
> @@ -91,8 +91,8 @@ static void grow_zone_span(struct zone *
>  	if (start_pfn < zone->zone_start_pfn)
>  		zone->zone_start_pfn = start_pfn;
>  
> -	if (end_pfn > old_zone_end_pfn)
> -		zone->spanned_pages = end_pfn - zone->zone_start_pfn;
> +	zone->spanned_pages = max(old_zone_end_pfn, end_pfn) -
> +				zone->zone_start_pfn);
                                                    ^
                                       this parentheses is redundant. :-)

Could you fix and repost it? Or should I?

-- 
Yasunori Goto 


