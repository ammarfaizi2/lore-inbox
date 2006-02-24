Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWBXMzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWBXMzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWBXMzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:55:10 -0500
Received: from silver.veritas.com ([143.127.12.111]:37235 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750819AbWBXMzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:55:09 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,143,1139212800"; 
   d="scan'208"; a="34870394:sNHT24168216"
Date: Fri, 24 Feb 2006 12:55:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
In-Reply-To: <200602241333.16190.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0602241252010.17767@goblin.wat.veritas.com>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org>
 <20060224064912.GB7243@elte.hu> <43FEAF52.80705@yahoo.com.au>
 <200602241333.16190.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Feb 2006 12:55:08.0310 (UTC) FILETIME=[8A54AB60:01C63941]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Andi Kleen wrote:
> On Friday 24 February 2006 08:01, Nick Piggin wrote:
> > 
> > Yeah, as I said above, the newly allocated page is fine, it is the
> > page table pages I'm worried about.
> 
> page tables are easy because we zero them on free (as a side effect
> of all the pte_clears)

But once the page table is freed, it's likely to get used for something
else, whether for another page table or something different doesn't 
matter: this mm can no longer blindly mess with the entries within in.

Nick's point is that it's mmap_sem (or mm_users 0) guarding against
the page table being freed.

Hugh
