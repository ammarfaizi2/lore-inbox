Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFTNrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFTNrh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFTNrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:47:37 -0400
Received: from silver.veritas.com ([143.127.12.111]:30061 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261240AbVFTNre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:47:34 -0400
Date: Mon, 20 Jun 2005 14:48:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Richard B. Johnson" <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
In-Reply-To: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0506201443400.2903@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Jun 2005 13:47:34.0115 (UTC) FILETIME=[9C84AB30:01C5759E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gosh, I thought from the Subject that you'd taken over from Linus,
and were announcing your new release ;)

On Mon, 20 Jun 2005, Richard B. Johnson wrote:
> 
> Attempts to run a driver that worked up to 2.6.11.9 shows that
> it aparently is no longer possible to nest calls to `down`.
> In other words, a procedure that has taken a semaphore can't
> then take another semaphore.
> 
> down(&first_resource);
> down(&second_resource);
> ...
> ...
> up(&second_resource);
> up(&first_resource);
> 
> 
> The error is 'sleeping function called from invalid context....'
> 
> ------------[ cut here ]------------
> kernel BUG at mm/memory.c:1112!

No, the error is "kernel BUG at mm/memory.c:1112!", which occurs while
it's holding page table lock, from which it doesn't recover very well.

It's the BUG_ON(!pte_none(*pte)) in remap_pte_range.  Maybe your page
table is corrupt, maybe your driver is trying to remap_pfn_range on
top of something already mapped.

Hugh
