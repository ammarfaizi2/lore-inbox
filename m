Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbTGBVqP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbTGBVqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:46:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64128 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264609AbTGBVqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:46:11 -0400
Date: Wed, 02 Jul 2003 14:48:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>
cc: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <563510000.1057182494@flay>
In-Reply-To: <20030702214032.GH20413@holomorphy.com>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random> <20030702214032.GH20413@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (c) redo the logic around page_convert_anon() and incrementally build
> 	pte_chains for remap_file_pages().
> 	The anobjrmap code did exactly this, but it was chaining
> 	distinct user virtual addresses instead.
> 	(i) you always have the pte_chain in hand anyway; the core
> 		is always prepped to handle allocating them now
> 	(ii) instead of just bailing for file-backed pages in
> 		page_add_rmap(), pass it enough information to know
> 		whether the address matches what it should from the
> 		vma, and start chaining if it doesn't
> 	(iii) but you say ->mapcount sharing space with the chain is a
> 		problem? no, it's not; again, take a cue from anobjrmap:
> 		if a file-backed page needs a pte_chain, shoehorn
> 		->mapcount into the first pte_chain block dangling off it
> 
> After all 3 are done, remap_file_pages() integrates smoothly into the VM,
> requires no magical privileges, nothing magical or brutally invasive
> that would scare people just before 2.6.0 is required, and the big
> apps can get their magical lowmem savings by just mlock()'ing _anything_
> they do massive sharing with, regardless of remap_file_pages().
> 
> Does anyone get it _now_?

If you have (anon) object based rmap, I don't see why you want to build
a pte_chain on a per-page basis - keeping this info on a per linear
area seems much more efficient. We still have a reverse mapping for
everything this way.

M.

