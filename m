Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbSJQTES>; Thu, 17 Oct 2002 15:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSJQTES>; Thu, 17 Oct 2002 15:04:18 -0400
Received: from pc-62-30-107-77-az.blueyonder.co.uk ([62.30.107.77]:20608 "EHLO
	bartonsoftware.com") by vger.kernel.org with ESMTP
	id <S261746AbSJQTER>; Thu, 17 Oct 2002 15:04:17 -0400
Date: Thu, 17 Oct 2002 20:11:17 +0100
Message-Id: <200210171911.g9HJBHk02456@bartonsoftware.com>
From: Eric Barton <eric@bartonsoftware.com>
To: linux-kernel@vger.kernel.org
Subject: kernel vaddr -> struct page
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying to turn a kernel virtual address into a struct page that I can
then pass to tcp_sendpage().  

The kernel virtual address could be {kmalloc(),vmalloc(),kmap()}-ed memory,
and I guarantee that this memory will not be {kfree(),vfree(),kunmap()}-ed
until the socket has done with the page (i.e. all the data has been acked).

I'd have thought that vmalloc_to_page(kvaddr) should give me a page I could
use, since it is walking the page tables to find the pte for 'kvaddr', and
checking that the physical page is present.

However I find I'm sending garbage when I use this method.

Can anyone help me understand?

-- 

                Cheers,
                        Eric

----------------------------------------------------
|Eric Barton        Barton Software                |
|9 York Gardens     Tel:    +44 (117) 330 1575     |
|Clifton            Mobile: +44 (7909) 680 356     |
|Bristol BS8 4LL    Fax:    call first             |
|United Kingdom     E-Mail: eric@bartonsoftware.com|
----------------------------------------------------
