Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVH1UAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVH1UAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVH1UAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:00:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750775AbVH1UAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:00:12 -0400
Date: Sun, 28 Aug 2005 13:00:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
In-Reply-To: <1125258200.5048.18.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0508281253320.3317@g5.osdl.org>
References: <1125159996.5159.8.camel@mulgrave>  <20050827105355.360bd26a.akpm@osdl.org>
 <1125258200.5048.18.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Aug 2005, James Bottomley wrote:
> 
> radix_tree_insert() is reliable from IRQ provided you don't try to use
> radix_tree_preload() and you defined your radix tree gfp flag to be
> GFP_ATOMIC.

It would be better if it wasn't, though.

I really don't see why we made it irq-safe, and take the hit of disabling
interrupts in addition to the locking.  That's a quite noticeable loss,
and I don't think it's really a valid thing to insert (or look up) page
cache entries from interrupts.

What _is_ it that makes us do that, btw? Is it just because we clear the 
writeback tag bits or something? Sad. It makes page lookup noticeably more 
expensive.

		Linus
