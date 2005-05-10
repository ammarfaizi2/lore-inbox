Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVEJSQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVEJSQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVEJSQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:16:19 -0400
Received: from graphe.net ([209.204.138.32]:25363 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261721AbVEJSQP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:16:15 -0400
Date: Tue, 10 May 2005 11:15:54 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: akpm@osdl.org, =?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm: fix rss counter being incremented when unmapping
In-Reply-To: <20050509122916.GA30726@doener.homenet>
Message-ID: <Pine.LNX.4.58.0505101112540.19973@graphe.net>
References: <20050509122916.GA30726@doener.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct. Thanks for catching that. My latest rss patch also has that.

On Mon, 9 May 2005, Björn Steinbrink wrote:

> This patch fixes a bug introduced by the "mm counter operations through
> macros" patch, which replaced a decrement operation in with an increment
> macro in try_to_unmap_one().
>
> Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
>
> diff -NurpP --minimal linux-2.6.12-rc4/mm/rmap.c linux-2.6.12-rc4-fixed/mm/rmap.c
> --- linux-2.6.12-rc4/mm/rmap.c  2005-05-08 17:53:49.000000000 +0200
> +++ linux-2.6.12-rc4-fixed/mm/rmap.c    2005-05-09 13:38:03.000000000 +0200
> @@ -586,7 +586,7 @@ static int try_to_unmap_one(struct page
>                 dec_mm_counter(mm, anon_rss);
>         }
>
> -       inc_mm_counter(mm, rss);
> +       dec_mm_counter(mm, rss);
>         page_remove_rmap(page);
>         page_cache_release(page);
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
>
