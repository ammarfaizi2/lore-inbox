Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVA1R4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVA1R4D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVA1RyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:54:03 -0500
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:16360 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261510AbVA1RuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:50:18 -0500
Message-ID: <41FA7AE2.10209@ammasso.com>
Date: Fri, 28 Jan 2005 11:48:18 -0600
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Correct way to release get_user_pages()?
References: <52pszqw917.fsf@topspin.com>
In-Reply-To: <52pszqw917.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

> Reading through the tree, I see that some callers of get_user_pages()
> release the pages that they got via put_page(), and some callers use
> page_cache_release().  Of course <linux/pagemap.h> has
> 
> 	#define page_cache_release(page)      put_page(page)
> 
> so this is really not much of a difference, but I'd like to know which
> is considered better style.  Any opinions?

I've defined this function.  I'm not sure if it really works, but it 
looks good.

#include <linux/pagemap.h>

void put_user_pages(int len, struct page **pages)
{
         int i;

         for (i=0; i<len; i++) {
                 if (!PageReserved(pages[i])) {
                         SetPageDirty(pages[i]);
                 }
                 page_cache_release(pages[i]);
         }
}

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
