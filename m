Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVKJCr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVKJCr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbVKJCr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:47:29 -0500
Received: from silver.veritas.com ([143.127.12.111]:65071 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751038AbVKJCr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:47:28 -0500
Date: Thu, 10 Nov 2005 02:46:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Paul Mackerras <paulus@samba.org>
cc: Andrew Morton <akpm@osdl.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] mm: remove ppc highpte
In-Reply-To: <17266.43166.752587.255943@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.61.0511100235160.6308@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100148410.5814@goblin.wat.veritas.com>
 <17266.43166.752587.255943@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 02:47:28.0631 (UTC) FILETIME=[16E1A870:01C5E5A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Paul Mackerras wrote:
> Hugh Dickins writes:
> 
> > ppc's HIGHPTE config option was removed in 2.5.28, and nobody seems to
> > have wanted it enough to restore it: so remove its traces from pgtable.h
> > and pte_alloc_one.  Or supply an alternative patch to config it back?
> 
> I'm staggered.  We do want to be able to have pte pages in highmem.
> I would rather just have it always enabled if CONFIG_HIGHMEM=y, rather
> than putting the config option back.  I think that should just involve
> adding __GFP_HIGHMEM to the flags for alloc_pages in pte_alloc_one
> unconditionally, no?

I'm glad the patch has struck a spark!  Yes, there doesn't appear to
be anything else that you'd need to do.  Except, why was it disabled
in the first place?  I think you'll need to reassure yourselves that
whatever the reason was has gone away, before reenabling.

Andrew, please drop 06/15, I don't think anything after depends on it
(but it came about when I was looking at uninlining pte_offset_map_lock).

Hugh
