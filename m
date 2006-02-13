Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWBMA5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWBMA5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWBMA5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:57:30 -0500
Received: from silver.veritas.com ([143.127.12.111]:10085 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751107AbWBMA5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:57:30 -0500
Date: Mon, 13 Feb 2006 00:57:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: wli@holomorphy.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] compound page: use page[1].lru
In-Reply-To: <20060212135457.2a3d3b37.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0602130043480.17715@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602121943150.15774@goblin.wat.veritas.com>
 <20060212135457.2a3d3b37.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Feb 2006 00:57:29.0860 (UTC) FILETIME=[76F35C40:01C63038]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2006, Andrew Morton wrote:
> 
> I'm scratching my head over flush_dcache_page() on, say, sparc64.  For
> example, the one in fs/direct-io.c.  With this patch, we'll call
> flush_dcache_page_impl(), which at least won't crash.  Before the patch I
> think we'd just do random stuff.

A head-scratching business indeed.  I think your description is right.

I haven't looked up the intersection of the set of arches which have
hugetlb with the set of arches which do something in flush_dcache_page,
but maybe you have, and found sparc64 the only or most significant.

> But I'm not sure that flush_dcache_page(hugetlb tail page) will do the
> right thing in aither case?

Probably not; but nobody seems to have noticed.  Perhaps it all comes
right in the end somehow.  I haven't much of a clue.

Remember that 1/3 is only changing page[1].mapping i.e. it's making
the first tail page behave like all the other constituents of the
compound page, so it can hardly be making matters worse.

Hugh
