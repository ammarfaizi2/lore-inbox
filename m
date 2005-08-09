Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVHIOtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVHIOtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVHIOtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:49:04 -0400
Received: from gold.veritas.com ([143.127.12.110]:49326 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964799AbVHIOtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:49:03 -0400
Date: Tue, 9 Aug 2005 15:50:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
In-Reply-To: <1123597903.30257.204.camel@gaston>
Message-ID: <Pine.LNX.4.61.0508091548150.13674@goblin.wat.veritas.com>
References: <42F57FCA.9040805@yahoo.com.au>  <200508090710.00637.phillips@arcor.de>
 <42F7F5AE.6070403@yahoo.com.au>  <1123577509.30257.173.camel@gaston> 
 <Pine.LNX.4.61.0508091215490.11660@goblin.wat.veritas.com>
 <1123597903.30257.204.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Aug 2005 14:49:03.0057 (UTC) FILETIME=[7BF40C10:01C59CF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Benjamin Herrenschmidt wrote:
> 
> > But you don't mind if they are refcounted, do you?
> > Just so long as they start out from 1 so never get freed.
> 
> Well, a refcounting bug would let them be freed and kaboom ... That's
> why a "PG_not_your_ram_dammit" bit would be useful. It could at least
> BUG_ON when refcount reaches 0 :)

Okay, great, let's give every struct page two refcounts,
so if one of them goes wrong, the other one will save us.

Hugh
