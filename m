Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTINJEk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 05:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbTINJEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 05:04:40 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:17338 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262340AbTINJEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 05:04:08 -0400
Date: Sun, 14 Sep 2003 11:03:58 +0200 (MEST)
Message-Id: <200309140903.h8E93wCH014048@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: andrea@suse.de
Subject: Re: [PATCH][2.4.23-pre4] page_alloc uninitialised variable bug
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003 01:11:02 +0200, Andrea Arcangeli wrote:
>this is the right cleanup for mainline to avoid the harmless compile
>time warning. Please test it so Marcelo can apply it. Sorry also for the
>delay in the watermark fixes, I finally sorted out a subtle x86-64 bug
>yesterday, so I should be able to port the watermark stuff to mainline
>early next week.
>
>--- 2.4.23pre4/mm/page_alloc.c.~1~	2003-09-13 00:08:04.000000000 +0200
>+++ 2.4.23pre4/mm/page_alloc.c	2003-09-14 01:05:24.000000000 +0200
>@@ -258,8 +258,6 @@ static struct page * balance_classzone(z
> 	struct page * page = NULL;
> 	int __freed;
> 
>-	if (!(gfp_mask & __GFP_WAIT))
>-		goto out;
> 	if (in_interrupt())
> 		BUG();

Yep this works fine.

/Mikael
