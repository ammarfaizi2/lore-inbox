Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751849AbWJIMJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWJIMJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWJIMJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:09:15 -0400
Received: from mx1.suse.de ([195.135.220.2]:49066 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751849AbWJIMJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:09:14 -0400
Date: Mon, 9 Oct 2006 14:09:12 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Message-ID: <20061009120912.GE26824@wotan.suse.de>
References: <1160351174.14601.3.camel@localhost.localdomain> <20061009102635.GC3487@wotan.suse.de> <1160391014.10229.16.camel@localhost.localdomain> <20061009110007.GA3592@wotan.suse.de> <1160392214.10229.19.camel@localhost.localdomain> <20061009111906.GA26824@wotan.suse.de> <1160393579.10229.24.camel@localhost.localdomain> <20061009114527.GB26824@wotan.suse.de> <1160394571.10229.27.camel@localhost.localdomain> <20061009115836.GC26824@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009115836.GC26824@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 01:58:36PM +0200, Nick Piggin wrote:
> > > > > > It also needs update_mmu_cache() I suppose.
> > > > > 
> > > > > Hmm, but it might not be called from a pagefault. Can we get away
> > > > > with not calling it? Or is it required by some architectures?
> > > > 
> > > > I think some architectures might be upset if it's not called...
> > > 
> > > But would any get upset if it is called from !pagefault path?
> > 
> > Probably not... the PTE has been filled so it should be safe, but then,
> > I don't know the details of what non-ppc archs do with that callback.

I guess we can make the rule that it only be called from the ->fault
handler anyway. If they want that functionality from ->mmap, then they
can use remap_pfn_range, because it isn't so performance critical.
