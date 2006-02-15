Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946059AbWBORiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946059AbWBORiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946055AbWBORiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:38:21 -0500
Received: from [194.90.237.34] ([194.90.237.34]:5234 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1946054AbWBORiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:38:20 -0500
Date: Wed, 15 Feb 2006 19:39:48 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] add asm-generic/mman.h
Message-ID: <20060215173948.GJ12974@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060215151649.GA12090@mellanox.co.il> <1140019088.21448.3.camel@dyn9047017100.beaverton.ibm.com> <20060215165016.GD12974@mellanox.co.il> <1140022377.21448.6.camel@dyn9047017100.beaverton.ibm.com> <20060215170935.GE12974@mellanox.co.il> <Pine.LNX.4.64.0602150916580.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602150916580.3691@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 15 Feb 2006 17:40:14.0343 (UTC) FILETIME=[E09A6970:01C63256]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Linus Torvalds <torvalds@osdl.org>:
> Subject: Re: [PATCH] add asm-generic/mman.h
> 
> 
> 
> On Wed, 15 Feb 2006, Michael S. Tsirkin wrote:
> >
> > Other numbers look right, dont they?
> 
> Suggestion: for each macro name, do
> 
> 	grep "macroname" patch
> 
> and if you see anything that looks even half-way suspicious, check it.
> 
> Here's a pipeline from hell which shows that you broke at least 
> MADV_REMOVE (which has values 5-9 depending on architecture).
> 
> 	sed -n '/^[-+].*define[ 	]*/
> 		{ s/.*define[ 	]*\([A-Za-z_0-9]*\).*/\1/ ; p}'
> 		patch  |
> 	sort -u |
> 	while read i
> 	do
> 		echo $i:
> 		grep "^[-+].*$i" patch
> 	done |
> 	less -S

This change was intentional: MADV_REMOVE wasnt in any mainline kernels:
it was added recently, so no app should be using it, yet.

> Rule #1: use tools instead of eyeballs whenever you possibly can. Humans 
> are bad at noticing changes like this.

Right. I'll go check again.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
