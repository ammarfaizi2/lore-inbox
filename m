Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWBJEZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWBJEZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWBJEZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:25:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751073AbWBJEZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:25:45 -0500
Date: Thu, 9 Feb 2006 20:25:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: nickpiggin@yahoo.com.au, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
Message-Id: <20060209202507.26f66be0.akpm@osdl.org>
In-Reply-To: <200602101514.40140.kernel@kolivas.org>
References: <200602101355.41421.kernel@kolivas.org>
	<200602101449.59486.kernel@kolivas.org>
	<43EC1164.4000605@yahoo.com.au>
	<200602101514.40140.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
>  Ok I see. We don't have a way to add to the tail of that list though?

del_page_from_lru() + (new) add_page_to_inactive_list_tail().

> Is that 
>  a worthwhile addition to this (ever growing) project? That would definitely 
>  have an impact on the other code if not all done within swap_prefetch.c.. 
>  which would also be quite a large open coded something.

Do both of the above in a new function in swap.c.

It's likely to have quite some impact on the overall behaviour of the
feature - would need careful testing.  It might end up screwing the whole
thing up.

