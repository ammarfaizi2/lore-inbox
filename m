Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVBWFXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVBWFXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 00:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVBWFXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 00:23:48 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:53090 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261295AbVBWFXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 00:23:45 -0500
Subject: Re: [PATCH 2/2] page table iterators
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: Hugh Dickins <hugh@veritas.com>, ak@suse.de, benh@kernel.crashing.org,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050222203115.49f79f42.davem@davemloft.net>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>
	 <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>
	 <20050217230342.GA3115@wotan.suse.de>
	 <20050217153031.011f873f.davem@davemloft.net>
	 <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>
	 <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
	 <421B0163.3050802@yahoo.com.au>
	 <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
	 <20050222203115.49f79f42.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 16:23:40 +1100
Message-Id: <1109136220.5177.24.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 20:31 -0800, David S. Miller wrote:

> I just got also reminded that we walk these damn pagetables completely
> twice every exit, once to unmap the VMAs pte mappings, once again to
> zap the page tables.  It might be fruitful to explore combining
> those two steps, perhaps not.
> 

I'm going to have a look at refcounting page table pages, which
will hopefully allow us to get back (and more) the clear_page_range
overhead introduced by the aggressive page table freeing.

It may also allow nice things like dropping file backed page table
mappings if they get reclaimed, and also a single walk to do the
freeing. I haven't looked into details yet though, these are just
vague hopes.


> Anyways, comments and improvment suggestions welcome.  Particularly
> interesting would be if this thing helps a lot on other platforms
> too, such as x86_64, ia64, alpha and ppc64.
> 

I have a feeling it should provide nice benefits to all archs if
we get it into all the walkers. Downsides are few - the bitmap walk
probably only becomes more expensive when all but a handful of
cachelines are present in a page table page.

I'd like to look at ways to make this patch happen with you soon...
First, for 2.6.12 my main concern is to get pt walking consistent,
and try to claw back some of the clear_page_range regression.

Thanks,
Nick


Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
