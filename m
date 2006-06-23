Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752149AbWFWWoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbWFWWoY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbWFWWoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:44:24 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:46245 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752149AbWFWWoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:44:23 -0400
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
In-Reply-To: <Pine.LNX.4.64.0606231514170.6483@g5.osdl.org>
References: <20060619175243.24655.76005.sendpatchset@lappy>
	 <20060619175253.24655.96323.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
	 <1151019590.15744.144.camel@lappy>
	 <Pine.LNX.4.64.0606231933060.7524@blonde.wat.veritas.com>
	 <1151100017.30819.50.camel@lappy>
	 <Pine.LNX.4.64.0606231514170.6483@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 00:44:18 +0200
Message-Id: <1151102659.30819.55.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 15:35 -0700, Linus Torvalds wrote:
> On Sat, 24 Jun 2006, Peter Zijlstra wrote:
> 
> > > > +	if ((pgprot_val(vma->vm_page_prot) == pgprot_val(vm_page_prot) &&
> > > > +	     ((vm_flags & (VM_WRITE|VM_SHARED|VM_PFNMAP|VM_INSERTPAGE)) ==
> > > > +			  (VM_WRITE|VM_SHARED)) &&
> > > > +	     vma->vm_file && vma->vm_file->f_mapping &&
> > > > +	     mapping_cap_account_dirty(vma->vm_file->f_mapping)) ||
> > > > +	    (vma->vm_ops && vma->vm_ops->page_mkwrite))
> > > > +		vma->vm_page_prot =
> > > > +			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
> > > > +
> > > 
> > > I'm dazzled by the beauty of it!
> > 
> > It's a real beauty isn't it :-)
> 
> Since Hugh pointed that out..
> 
> It really would be nice to just encapsulate that as an inline function of 
> its own, and move the comment at the top of it to be at the top of the 
> inline function.

Dang, I just send out -v11, awell such is life. I'll see what I can do.
Preferably mprotect can reuse that same function.

Will repost a new 1/5 shortly.

Peter

