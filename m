Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbTDQW4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 18:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbTDQW4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 18:56:31 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:14331 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S262659AbTDQW4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 18:56:30 -0400
Date: Fri, 18 Apr 2003 00:10:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: joern@wohnheim.fh-wedel.de, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop swapoff 3/3 OOMkill
In-Reply-To: <20030417145527.00de9fb6.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0304172359320.1178-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003, Andrew Morton wrote:
> 
> __GFP_NORETRY:
> 
> 	Don't oom-kill and don't retry.   For swapoff.
> 
> I've implemented a __GFP_REPEAT, and don't like it, because it blurs the
> __GFP_REPEAT and __GFP_NOFAIL requirements.  I'll add __GFP_NORETRY and we
> can then pass that into read_swap_cache_async() and handle the error.
> 
> Sound good?

Probably not.  I did try something like that over a year ago, and it
didn't work as well as I'd expected.  One problem, I think, is that
while it's going through pages already in the swap cache, swapoff
may not need to allocate memory itself; but meanwhile other tasks
are trying to allocate memory and getting OOMkilled.  I think that
argues that swapoff does need to register itself for the duration
with the OOMkiller: a PF_ flag achieves that but a __GFP flag does not.

Hugh

