Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVD0Grw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVD0Grw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 02:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVD0Grw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 02:47:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:62091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261695AbVD0Gru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:47:50 -0400
Date: Tue, 26 Apr 2005 23:47:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counting bounce buffer in vmstat
Message-Id: <20050426234725.1ed66aff.akpm@osdl.org>
In-Reply-To: <426F3445.9060701@jp.fujitsu.com>
References: <426F3445.9060701@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> diff -puN include/linux/page-flags.h~count_bounce include/linux/page-flags.h
>  --- linux-2.6.12-rc2-mm3/include/linux/page-flags.h~count_bounce	2005-04-27 10:23:15.000000000 +0900
>  +++ linux-2.6.12-rc2-mm3-kamezawa/include/linux/page-flags.h	2005-04-27 10:24:11.000000000 +0900
>  @@ -89,6 +89,7 @@ struct page_state {
>   	unsigned long nr_page_table_pages;/* Pages used for pagetables */
>   	unsigned long nr_mapped;	/* mapped into pagetables */
>   	unsigned long nr_slab;		/* In slab */
>  +	unsigned long nr_bounce;	/* pages for bounce buffers */
>   #define GET_PAGE_STATE_LAST nr_slab

That's not really right.

There are two functions: get_page_state() and get_full_page_state(). 
get_page_state() only gets those fields up to and including
GET_PAGE_STATE_LAST.  The way you have the code laid out there implies that
get_page_state() also calculates the total nr_bounce, only it doesn't.

I'll fix it up.

