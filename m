Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287163AbRL2Ios>; Sat, 29 Dec 2001 03:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287165AbRL2Ioi>; Sat, 29 Dec 2001 03:44:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:65293 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287163AbRL2Io1>; Sat, 29 Dec 2001 03:44:27 -0500
Message-ID: <3C2D81B6.D9B78DDA@zip.com.au>
Date: Sat, 29 Dec 2001 00:41:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alad@hss.hns.com
CC: linux-kernel@vger.kernel.org
Subject: Re: vmscan.c: shrink_cache() doubt
In-Reply-To: <65256B31.002E1834.00@sandesh.hss.hns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alad@hss.hns.com wrote:
> 
> In shrink_cache(), we have
> 
>           if (!page->buffers && (page_count(page) != 1 || !page->mapping))
>                goto page_mapped;
>           .
>           .
>           .
> page_mapped:
>           if (--max_mapped >=0)
>                continue;
> 
> Assume page->buffers == NULL and page->count == 1, then why jump to page_mapped
> if page->mapping == NULL ??
> 

These are anonymous pages - memory returned by malloc() rather
than by mmap().

Replace max_mapped with max_unfreeable and replace page_mapped
with page_unfreeable and it may make some sense.

-
