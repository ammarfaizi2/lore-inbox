Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWJILpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWJILpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWJILpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:45:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:21890 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932580AbWJILpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:45:31 -0400
Date: Mon, 9 Oct 2006 13:45:27 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Message-ID: <20061009114527.GB26824@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site> <20061007105853.14024.95383.sendpatchset@linux.site> <20061007134407.6aa4dd26.akpm@osdl.org> <1160351174.14601.3.camel@localhost.localdomain> <20061009102635.GC3487@wotan.suse.de> <1160391014.10229.16.camel@localhost.localdomain> <20061009110007.GA3592@wotan.suse.de> <1160392214.10229.19.camel@localhost.localdomain> <20061009111906.GA26824@wotan.suse.de> <1160393579.10229.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160393579.10229.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 09:32:59PM +1000, Benjamin Herrenschmidt wrote:
> > 
> > You'll want to clear VM_PFNMAP after unmapping all pages from it, before
> > switching to struct page backing.
> 
> Which means having a list of all vma's ... I suppose I can look at the
> truncate code to do that race free but I was hoping I could avoid it
> (that's the whole point of using unmap_mapping_range() in fact).

Yeah I don't think there is any other way to do it.

> > > It also needs update_mmu_cache() I suppose.
> > 
> > Hmm, but it might not be called from a pagefault. Can we get away
> > with not calling it? Or is it required by some architectures?
> 
> I think some architectures might be upset if it's not called...

But would any get upset if it is called from !pagefault path?
