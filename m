Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSCHDFi>; Thu, 7 Mar 2002 22:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310668AbSCHDFe>; Thu, 7 Mar 2002 22:05:34 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51099 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310666AbSCHDFZ>;
	Thu, 7 Mar 2002 22:05:25 -0500
Message-ID: <3C882A46.7060409@us.ibm.com>
Date: Thu, 07 Mar 2002 19:04:38 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: truncate_list_pages()  BUG and confusion
In-Reply-To: <3C880EFF.A0789715@zip.com.au> <1044120155.1015527354@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Where did truncate_list_pages unlock it? It doesn't do that
> until after it's called truncate_complete_page, which (indirectly)
> frees the page ... ?

Ahh, put_page_testzero
#define put_page_testzero(p)    atomic_dec_and_test(&(p)->count)

It will only try to free if the page count is zero.  The caller makes 
sure that this doesn't happen.

if (!PageReserved(page) && put_page_testzero(page)) {
	if (PageLRU(page))
         	lru_cache_del(page);
	__free_pages_ok(page, 0);
}


-- 
Dave Hansen
haveblue@us.ibm.com

