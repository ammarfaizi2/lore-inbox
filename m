Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbWASOBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbWASOBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWASOBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:01:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:37289 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161203AbWASOBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:01:32 -0500
Date: Thu, 19 Jan 2006 15:01:27 +0100
From: Nick Piggin <npiggin@suse.de>
To: Jason Baron <jbaron@redhat.com>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/2] x86_64: pageattr use single list
Message-ID: <20060119140127.GB958@wotan.suse.de>
References: <20060117150307.7411.94174.sendpatchset@linux.site> <20060117150316.7411.98772.sendpatchset@linux.site> <Pine.LNX.4.61.0601181437030.6584@dhcp83-105.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601181437030.6584@dhcp83-105.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 02:38:11PM -0500, Jason Baron wrote:
> 
> On Wed, 18 Jan 2006, Nick Piggin wrote:
> 
> > Use page->lru.next to implement the singly linked list of pages rather
> > than the struct deferred_page which needs to be allocated and freed for
> > each page.
> > 
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> > Acked-by: Andi Kleen <ak@suse.de>
> > 
> > Index: linux-2.6/arch/x86_64/mm/pageattr.c
> > ===================================================================
> 
> ...
> 
> > +
> > +	flush_map((dpage && !dpage->lru.next) ? (unsigned long)page_address(dpage) : 0);
> > +	while (dpage) {
> > +		__free_page(dpage);
> > +		dpage = (struct page *)dpage->lru.next;
> >  	} 
> >  } 
> >  
> 
> do you want to be touching a struct page that was just freed?
> 

No, thanks. Good catch.

Nick
