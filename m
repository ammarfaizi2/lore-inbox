Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTDII5P (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 04:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTDII5P (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 04:57:15 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:57222 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262930AbTDII5N (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 04:57:13 -0400
Message-ID: <014501c2fe77$9ef3b410$760010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com><035401c2fdac$6e6aa400$5600a8c0@edumazet> <20030408020439.16c8322b.akpm@digeo.com>
Subject: Re: Kernel BUG linux-2.5.67
Date: Wed, 9 Apr 2003 11:08:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew

Sorry for the delay...

I confirm that your patch corrects the problem for me.

Thanks

Eric

From: "Andrew Morton" <akpm@digeo.com>
> > instant oops with a small multi-threaded program using futex() & hugetlb
>
> Was the futex placed inside a hugetlb page?  Please say yes.
>
> There is a stunning bug.
>
> --- 25/include/linux/mm.h~a 2003-04-08 02:03:19.000000000 -0700
> +++ 25-akpm/include/linux/mm.h 2003-04-08 02:03:24.000000000 -0700
> @@ -231,8 +231,8 @@ static inline void get_page(struct page
>  static inline void put_page(struct page *page)
>  {
>   if (PageCompound(page)) {
> + page = (struct page *)page->lru.next;
>   if (put_page_testzero(page)) {
> - page = (struct page *)page->lru.next;
>   if (page->lru.prev) { /* destructor? */
>   (*(void (*)(struct page *))page->lru.prev)(page);
>   } else {
>
> _
>

