Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTIRMCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 08:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTIRMCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 08:02:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:63901 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261178AbTIRMCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 08:02:44 -0400
Date: Thu, 18 Sep 2003 14:01:43 +0200 (MEST)
Message-Id: <200309181201.h8IC1hue002338@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: andrea@suse.de, marcelo.tosatti@cyclades.com.br
Subject: Re: nr_free_buffer_pages 2.4.23pre4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003 07:06:12 +0200, Andrea Arcangeli <andrea@suse.de> wrote:
> According to the kernel CVS you didn't merge this yet, so please merge
> the below too, it will remove a not necessary branch that also generates
> a gcc false positive (all harmless of course but it's more correct to
> remove it):
> 
> --- 2.4.23pre4/mm/page_alloc.c.~1~	2003-09-13 00:08:04.000000000 +0200
> +++ 2.4.23pre4/mm/page_alloc.c	2003-09-14 01:05:24.000000000 +0200
> @@ -258,8 +258,6 @@ static struct page * balance_classzone(z
>  	struct page * page = NULL;
>  	int __freed;
>  
> -	if (!(gfp_mask & __GFP_WAIT))
> -		goto out;
>  	if (in_interrupt())
>  		BUG();

Andrea,

This cleanup leaves the 'out' label unused, triggering
yet another gcc warning (though less scary than the previous).
Please apply this cleanup patch on top of the one above.

/Mikael

--- linux-2.4.23-pre4/mm/page_alloc.c.~1~	2003-09-18 13:43:41.753607800 +0200
+++ linux-2.4.23-pre4/mm/page_alloc.c	2003-09-18 13:55:46.785155159 +0200
@@ -317,7 +317,6 @@
 		}
 		current->nr_local_pages = 0;
 	}
- out:
 	*freed = __freed;
 	return page;
 }
