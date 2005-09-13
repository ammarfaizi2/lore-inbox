Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbVIMLam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbVIMLam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbVIMLam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:30:42 -0400
Received: from gold.veritas.com ([143.127.12.110]:114 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932608AbVIMLal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:30:41 -0400
Date: Tue, 13 Sep 2005 12:30:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Kirill Korotaev <dev@sw.ru>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, xemul@sw.ru
Subject: Re: [PATCH] error path in setup_arg_pages() misses vm_unacct_memory()
In-Reply-To: <20050913014008.0ee54c62.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509131220540.7040@goblin.wat.veritas.com>
References: <4325B188.10404@sw.ru> <20050912132352.6d3a0e3a.akpm@osdl.org>
 <43268C21.9090704@sw.ru> <20050913014008.0ee54c62.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Sep 2005 11:30:39.0566 (UTC) FILETIME=[9160B6E0:01C5B856]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Andrew Morton wrote:
> Kirill Korotaev <dev@sw.ru> wrote:
> >
> > maybe it is worth moving vm_acct_memory() out of 
> >  security_vm_enough_memory()?
> 
> I think that would be saner, yes.  That means that the callers would call
> vm_acct_memory() after security_enough_memory(), if that succeeded.

I don't like that at all.  The implementation of its tests is necessarily
imprecise, but nonetheless, we do prefer primitives which atomically test
and reserve.  We're not moving from request_region to check_region, are we?

But change the naming by all means, it was never good,
and grew worse when "security_" got stuck on the front.

Hugh
