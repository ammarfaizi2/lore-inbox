Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSLLPRM>; Thu, 12 Dec 2002 10:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSLLPRM>; Thu, 12 Dec 2002 10:17:12 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:43905 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S264706AbSLLPRL>; Thu, 12 Dec 2002 10:17:11 -0500
Message-ID: <3DF95416.7010107@ToughGuy.net>
Date: Fri, 13 Dec 2002 08:59:26 +0530
From: Bourne <bourne@ToughGuy.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 ( try_to_swap_out) does not set page->mapping to NULL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, A small piece of code in mm/vmscan.c kept me confused. Please 
could some one explain this ?

File: mm/vmscan.c , try_to_swap_out()

....SNIP....
drop_pte: mm->rss--
                UnlockPage(page);
                ---SNIP--
                page_cache_release(page);
                return freeable;
                ----SNIP----
if(page->mapping)
    goto drop_pte;

What i can get is if page->mapping is NOT NULL , then do a 
page_cache_release(). This boils down to __free_pages_ok(). Here the 
code snippet is if(page->mapping) BUG();

So if try_to_swap_out wants to drop a page which can be brought in 
always ( i.e , not dirty ), then what is the harm in setting it to NULL ?

TIA

Bourne

