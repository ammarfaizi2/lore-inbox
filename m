Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVIZInK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVIZInK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 04:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVIZInK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 04:43:10 -0400
Received: from silver.veritas.com ([143.127.12.111]:5693 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932430AbVIZInJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 04:43:09 -0400
Date: Mon, 26 Sep 2005 09:42:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/21] mm: batch updating mm_counters
In-Reply-To: <1127719503.5101.38.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.61.0509260939060.9937@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com> 
 <Pine.LNX.4.61.0509251707171.3490@goblin.wat.veritas.com>
 <1127719503.5101.38.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Sep 2005 08:43:03.0514 (UTC) FILETIME=[4EDFB3A0:01C5C276]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Nick Piggin wrote:
> On Sun, 2005-09-25 at 17:08 +0100, Hugh Dickins wrote:
> > -		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr);
> > +		anon = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
> > +							vm_flags, addr);
> > +		rss[anon]++;
> 
> How about passing rss[2] to copy_one_pte, and have that
> increment the correct rss value accordingly? Not that
> you may consider that any nicer than what you have here.

That does seem a more _normal_ way of doing it.

Though adding a seventh argument doesn't appeal
(perhaps irrelevant since copy_one_pte is inlined).

I don't mind much either way: anyone have strong feelings?

Hugh
