Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWFJEaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWFJEaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 00:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWFJEaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 00:30:21 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:26345 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932283AbWFJEaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 00:30:19 -0400
Date: Sat, 10 Jun 2006 13:32:07 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       npiggin@suse.de, linux-mm@kvack.org, ak@suse.de
Subject: Re: zoned VM stats: Add NR_ANON
Message-Id: <20060610133207.df05aa29.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0606091152490.916@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
	<20060608230305.25121.97821.sendpatchset@schroedinger.engr.sgi.com>
	<20060608210056.9b2f3f13.akpm@osdl.org>
	<Pine.LNX.4.64.0606091152490.916@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006 11:54:07 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Note that this will change the meaning of the number of mapped pages
> reported in /proc/vmstat /proc/meminfo and in the per node statistics.
> This may affect user space tools that monitor these counters!
> 
> However, NR_MAPPED then works like NR_DIRTY. It is only valid for
> pagecache pages.

> Index: linux-2.6.17-rc6-mm1/mm/rmap.c
> ===================================================================
> --- linux-2.6.17-rc6-mm1.orig/mm/rmap.c	2006-06-09 10:30:51.768993888 -0700
> +++ linux-2.6.17-rc6-mm1/mm/rmap.c	2006-06-09 11:26:59.389471258 -0700
> @@ -455,7 +455,7 @@ static void __page_set_anon_rmap(struct 
>  	 * nr_mapped state can be updated without turning off
>  	 * interrupts because it is not modified via interrupt.
>  	 */
> -	__inc_zone_page_state(page, NR_MAPPED);
> +	__inc_zone_page_state(page, NR_ANON);
>  }
>  
>  /**
> @@ -531,7 +531,7 @@ void page_remove_rmap(struct page *page)
>  		 */
>  		if (page_test_and_clear_dirty(page))
>  			set_page_dirty(page);
> -		__dec_zone_page_state(page, NR_MAPPED);
> +		__dec_zone_page_state(page, PageAnon(page) ? NR_ANON : NR_MAPPED);
>  	}
>  }

Can this accounting catch  page migration ?  TBD ?
Now all coutners are counted per zone, migration should be cared.

-Kame

