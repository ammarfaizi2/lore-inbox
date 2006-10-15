Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWJOLfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWJOLfz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 07:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWJOLfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 07:35:55 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:31291 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932070AbWJOLfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 07:35:55 -0400
Subject: Re: [patch 6/6] mm: fix pagecache write deadlocks
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Neil Brown <neilb@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061014041927.GA14467@wotan.suse.de>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
	 <20061013143616.15438.77140.sendpatchset@linux.site>
	 <20061013151457.81bb7f03.akpm@osdl.org>
	 <20061014041927.GA14467@wotan.suse.de>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 13:35:47 +0200
Message-Id: <1160912147.5230.21.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-14 at 06:19 +0200, Nick Piggin wrote:
> On Fri, Oct 13, 2006 at 03:14:57PM -0700, Andrew Morton wrote:
> > On Fri, 13 Oct 2006 18:44:52 +0200 (CEST)
> > Nick Piggin <npiggin@suse.de> wrote:

> > > @@ -2450,6 +2436,7 @@ int nobh_truncate_page(struct address_sp
> > >  		memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
> > >  		flush_dcache_page(page);
> > >  		kunmap_atomic(kaddr, KM_USER0);
> > > +		SetPageUptodate(page);
> > >  		set_page_dirty(page);
> > >  	}
> > >  	unlock_page(page);
> > 
> > I've already forgotten why this was added.  Comment, please ;)
> 
> Well, nobh_prepare_write no longer sets it uptodate, so we need to if
> we're going to set_page_dirty. OTOH, why does truncate_page need to
> zero the pagecache anyway? I wonder if we couldn't delete this whole
> function? (not in this patchset!)

It zeros the tail end of the page so we don't leak old data?

