Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWJILt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWJILt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWJILt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:49:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:39359 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932601AbWJILt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:49:58 -0400
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061009114527.GB26824@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
	 <20061007105853.14024.95383.sendpatchset@linux.site>
	 <20061007134407.6aa4dd26.akpm@osdl.org>
	 <1160351174.14601.3.camel@localhost.localdomain>
	 <20061009102635.GC3487@wotan.suse.de>
	 <1160391014.10229.16.camel@localhost.localdomain>
	 <20061009110007.GA3592@wotan.suse.de>
	 <1160392214.10229.19.camel@localhost.localdomain>
	 <20061009111906.GA26824@wotan.suse.de>
	 <1160393579.10229.24.camel@localhost.localdomain>
	 <20061009114527.GB26824@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 21:49:31 +1000
Message-Id: <1160394571.10229.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 13:45 +0200, Nick Piggin wrote:
> On Mon, Oct 09, 2006 at 09:32:59PM +1000, Benjamin Herrenschmidt wrote:
> > > 
> > > You'll want to clear VM_PFNMAP after unmapping all pages from it, before
> > > switching to struct page backing.
> > 
> > Which means having a list of all vma's ... I suppose I can look at the
> > truncate code to do that race free but I was hoping I could avoid it
> > (that's the whole point of using unmap_mapping_range() in fact).
> 
> Yeah I don't think there is any other way to do it.

What is the problem if I always keep VM_PFNMAP set ?

> > > > It also needs update_mmu_cache() I suppose.
> > > 
> > > Hmm, but it might not be called from a pagefault. Can we get away
> > > with not calling it? Or is it required by some architectures?
> > 
> > I think some architectures might be upset if it's not called...
> 
> But would any get upset if it is called from !pagefault path?

Probably not... the PTE has been filled so it should be safe, but then,
I don't know the details of what non-ppc archs do with that callback.

Ben.


