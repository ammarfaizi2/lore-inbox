Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUJBCaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUJBCaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 22:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUJBCaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 22:30:14 -0400
Received: from mail-13.iinet.net.au ([203.59.3.45]:14483 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267212AbUJBCaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 22:30:08 -0400
Message-ID: <415E12A9.7000507@cyberone.com.au>
Date: Sat, 02 Oct 2004 12:30:01 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-mm@kvack.org, akpm@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
References: <20041001182221.GA3191@logos.cnet>
In-Reply-To: <20041001182221.GA3191@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

>
>With such a thing in place we can build a mechanism for kswapd 
>(or a separate kernel thread, if needed) to notice when we are low on 
>high order pages, and use the coalescing algorithm instead blindly 
>freeing unique pages from LRU in the hope to build large physically 
>contiguous memory areas.
>
>Comments appreciated.
>
>

Hi Marcelo,
Seems like a good idea... even with regular dumb kswapd "merging",
you may easily get stuck for example on systems without swap...

Anyway, I'd like to get those beat kswapd patches in first. Then
your mechanism just becomes something like:

    if order-0 pages are low {
        try to free memory
    }
    else if order-1 or higher pages are low {
         try to coalesce_memory
         if that fails, try to free memory
    }

