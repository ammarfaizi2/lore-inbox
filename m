Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751851AbWJIMLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWJIMLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWJIMLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:11:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:65471 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751851AbWJIMLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:11:40 -0400
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061009120912.GE26824@wotan.suse.de>
References: <1160351174.14601.3.camel@localhost.localdomain>
	 <20061009102635.GC3487@wotan.suse.de>
	 <1160391014.10229.16.camel@localhost.localdomain>
	 <20061009110007.GA3592@wotan.suse.de>
	 <1160392214.10229.19.camel@localhost.localdomain>
	 <20061009111906.GA26824@wotan.suse.de>
	 <1160393579.10229.24.camel@localhost.localdomain>
	 <20061009114527.GB26824@wotan.suse.de>
	 <1160394571.10229.27.camel@localhost.localdomain>
	 <20061009115836.GC26824@wotan.suse.de>
	 <20061009120912.GE26824@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 22:11:16 +1000
Message-Id: <1160395876.10229.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 14:09 +0200, Nick Piggin wrote:
> On Mon, Oct 09, 2006 at 01:58:36PM +0200, Nick Piggin wrote:
> > > > > > > It also needs update_mmu_cache() I suppose.
> > > > > > 
> > > > > > Hmm, but it might not be called from a pagefault. Can we get away
> > > > > > with not calling it? Or is it required by some architectures?
> > > > > 
> > > > > I think some architectures might be upset if it's not called...
> > > > 
> > > > But would any get upset if it is called from !pagefault path?
> > > 
> > > Probably not... the PTE has been filled so it should be safe, but then,
> > > I don't know the details of what non-ppc archs do with that callback.
> 
> I guess we can make the rule that it only be called from the ->fault
> handler anyway. If they want that functionality from ->mmap, then they
> can use remap_pfn_range, because it isn't so performance critical.

Yup. The whole point of the discussion is for cases where we can't just
setup a static mapping at mmap time.

Ben.


