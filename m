Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVDTVLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVDTVLB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 17:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVDTVLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 17:11:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43929 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261814AbVDTVKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 17:10:49 -0400
Date: Wed, 20 Apr 2005 23:10:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Subject: Re: [RFC][PATCH] nameing reserved pages [1/3]
Message-ID: <20050420211018.GC3372@elf.ucw.cz>
References: <42664654.5080409@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42664654.5080409@jp.fujitsu.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> inline functions for naming pages.
> -- Kame

> 
> Adding page_type definitions and funcs for naming reserved pages.
> 
> Reserved page's information is stored into page->private.
> 
> This is a weak naming method and anyone can overwrite it. 
> 
> This information is used in /dev/memstate in following patch.
> 
> Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> 
> ---
> 
>  linux-2.6.12-rc2-kamezawa/include/linux/mm.h |   31 +++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+)
> 
> diff -puN include/linux/mm.h~name_reserved include/linux/mm.h
> --- linux-2.6.12-rc2/include/linux/mm.h~name_reserved	2005-04-20 09:37:48.000000000 +0900
> +++ linux-2.6.12-rc2-kamezawa/include/linux/mm.h	2005-04-20 10:38:01.000000000 +0900
> @@ -348,6 +348,37 @@ static inline void put_page(struct page 
>  #endif		/* CONFIG_HUGETLB_PAGE */
>  
>  /*
> + * Type of Pages. This is used in /dev/memstate.
> + * value range is 0-255.
> + */
> +enum page_type {
> +	Page_Common = 0,
> +	Min_Reserved_Types = 1,
> +	Rserved_Unknwon = 1,
         ~
	  missing e?

> +	Reserved_At_Boot,
> +	Max_Reserved_Types,
> +	Page_Invalid = 0xff
> +};

You certainly use unusual naming convention here. Could we get
reserved_at_boot instead? (I.e. all lowercase).


> +/*
> + * Basically, page->private has no meaning without PG_private.
> + * Here, we use page->private for PG_reserved pages to record type of a page.
> + * Because a page is reserved, anyone will not modify page->private.
> + * When it is freed, page->private will be overwritten by some code.
> + */
> +static inline void set_page_reserved(struct page *page, unsigned char type)
> +{

Make it enum page_type type.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
