Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVCVRx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVCVRx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVCVRx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:53:59 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:16361
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261480AbVCVRxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:53:54 -0500
Date: Tue, 22 Mar 2005 09:52:21 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, tony.luck@intel.com, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322095221.2b912c83.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503220548250.5484@goblin.wat.veritas.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03210DD4@scsmsx401.amr.corp.intel.com>
	<20050321150205.4af39064.davem@davemloft.net>
	<1111464894.5125.34.camel@npiggin-nld.site>
	<20050321212955.6a0f2b61.davem@davemloft.net>
	<Pine.LNX.4.61.0503220548250.5484@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 06:08:38 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> > It just wants the range of page tables liberated.  I guess
> > essentially PMD_SIZE is the granularity.
> 
> I _think_ that answer means that my current code is fine in this respect.
> But I'm not entirely convinced.  Since sparc64 is the only architecture
> which implements a flush_tlb_pgtables which actually uses start,end,
> we do need to suit your needs there - informed reassurance welcome!

Ok.  This interface is meant to deal with platforms that virtually
map their page tables, usually for faster TLB miss processing.

As stated, IA64 does this just as sparc64 does, however they flush
their linear page table virtual mappings in a different place.

This by definition means that the granularity is PMD_SIZE.  That
is the smallest chunk of page table, ie. what a pte_t chunk maps.

> > It's funny since this code aparently works fine on ia64 which
> > is fully 3-level too.  Hmm...
> 
> Yes, odd.  I'll have to have another think later on.

I'll play around with some of the patches you posted today and
get back to you.
