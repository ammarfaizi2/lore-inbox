Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285068AbRLQJaO>; Mon, 17 Dec 2001 04:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285065AbRLQJ3y>; Mon, 17 Dec 2001 04:29:54 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:15629 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S285062AbRLQJ3x>; Mon, 17 Dec 2001 04:29:53 -0500
Date: Mon, 17 Dec 2001 10:32:12 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: "Sottek, Matthew J" <matthew.j.sottek@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: zap_page_range in a module
In-Reply-To: <20011214173045.C26535@redhat.com>
Message-ID: <Pine.LNX.4.21.0112150058450.811-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2001, Benjamin LaHaise wrote:

> On Fri, Dec 14, 2001 at 01:26:29PM -0800, Sottek, Matthew J wrote:
> > currently can only work when compiled into the kernel because I need 
> > zap_page_rage(). Is there an acceptable way for me to get equivalent
> > functionality in a module so that this will be more useful to the
> > general public?
> 
> The vm does zap_page_range for you if you're implementing an mmap operation, 
> otherwise vmalloc/vfree/vremap will take care of the details for you.  How 
> is your code using zap_page_range?  It really shouldn't be.

True, but IMHO only for standard mmap semantics.

Well, the background is slightly different here, but very much the same
problem: I'd like to get rid of some page(s) which are mapped to an
userland vma. At certain points I need to force a page fault on this and
so the overloaded vma->nopage() gets called and can do the right thing.

zap_page_range() does exactly what I want. IMHO zap_page_range() is some
kind of symmetric buddy of remap_page_range() - it's somewhat surprizing
to find one exported but not the other one. And, AFAICS, there is no
technical reason as well, not to use it - at least for me it's working
perfectly fine. Of course it needs proper mm serialization provided by
down_write(&mm->mmap_sem).

Martin

