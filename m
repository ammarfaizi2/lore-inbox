Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVAYWmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVAYWmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVAYWlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:41:51 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63190 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262212AbVAYWlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:41:09 -0500
Message-ID: <41F6BCC2.2080609@austin.ibm.com>
Date: Tue, 25 Jan 2005 15:40:18 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] page_cache_readahead: unneeded prev_page assignments
References: <41F6348E.A1CB395C@tv-sign.ru>
In-Reply-To: <41F6348E.A1CB395C@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine, thought we had some reason for it in the past, but it will 
definitly be overwritten.

Signed-off-by: Steven Pratt <slpratt@austin.ibm.com>

Oleg Nesterov wrote:

>There is no point in setting ra->prev_page before 'goto out',
>it will be overwritten anyway.
>
>Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
>--- 2.6.11-rc2/mm/readahead.c~	Wed Jan 12 11:44:55 2005
>+++ 2.6.11-rc2/mm/readahead.c	Mon Jan 24 20:19:38 2005
>@@ -432,7 +432,6 @@ page_cache_readahead(struct address_spac
> 
> 	if (newsize == 0 || (ra->flags & RA_FLAG_INCACHE)) {
> 		newsize = 1;
>-		ra->prev_page = offset;
> 		goto out;	/* No readahead or file already in cache */
> 	}
> 	/*
>@@ -443,7 +442,6 @@ page_cache_readahead(struct address_spac
> 	if ((ra->size == 0 && offset == 0)	/* first io and start of file */
> 	    || (ra->size == -1 && ra->prev_page == offset - 1)) {
> 		/* First sequential */
>-		ra->prev_page  = offset + newsize - 1;
> 		ra->size = get_init_ra_size(newsize, max);
> 		ra->start = offset;
> 		if (!blockable_page_cache_readahead(mapping, filp, offset,
>@@ -475,7 +473,6 @@ page_cache_readahead(struct address_spac
> 	 */
> 	if ((offset != (ra->prev_page+1) || (ra->size == 0))) {
> 		ra_off(ra);
>-		ra->prev_page  = offset + newsize - 1;
> 		blockable_page_cache_readahead(mapping, filp, offset,
> 				 newsize, ra, 1);
> 		goto out;
>@@ -545,7 +542,7 @@ page_cache_readahead(struct address_spac
> 
> out:
> 	ra->prev_page = offset + newsize - 1;
>-	return(newsize);
>+	return newsize;
> }
> 
> /*
>  
>

