Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbWJ3Umf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbWJ3Umf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030593AbWJ3Umf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:42:35 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:37318 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030565AbWJ3Ume (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:42:34 -0500
Date: Mon, 30 Oct 2006 12:42:30 -0800 (PST)
From: Zwane Mwaikambo <zwane@infradead.org>
Subject: Re: [PATCH] vmalloc : optimization, cleanup, bugfixes
In-reply-to: <453C87A6.4060602@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0610301234500.20628@montezuma.fsmlabs.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
References: <453C3A29.4010606@intel.com>
 <20061022214508.6c4f30c6.akpm@osdl.org>
 <200610231036.10418.dada1@cosmosbay.com> <453C87A6.4060602@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006, Nick Piggin wrote:

> Eric Dumazet wrote:
> > [PATCH] vmalloc : optimization, cleanup, bugfixes
> > 
> > This patch does three things
> > 
> > 1) reorder 'struct vm_struct' to speedup lookups on CPUS with small cache
> > lines. The fields 'next,addr,size' should be now in the same cache line, to
> > speedup lookups.
> > 
> > 2) One minor cleanup in __get_vm_area_node()
> > 
> > 3) Bugfixes in vmalloc_user() and vmalloc_32_user()
> > NULL returns from __vmalloc() and __find_vm_area() were not tested.
> 
> Hmm, so they weren't. As far as testing the return of __find_vm_area,
> you can just turn that into a BUG_ON(!area), because at that point,
> we've established that the vmalloc succeeded.

No need for a BUG_ON it'll simply be a NULL dereference, at which point 
we're back to the original code.

	Zwane

