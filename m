Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbVLQVd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbVLQVd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVLQVd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:33:58 -0500
Received: from lame.durables.org ([64.81.244.120]:42435 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S932657AbVLQVd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:33:57 -0500
Subject: Re: [PATCH 07/13]  [RFC] ipath core misc files
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051217123850.aa6cfd53.akpm@osdl.org>
References: <200512161548.KglSM2YESlGlEQfQ@cisco.com>
	 <200512161548.3fqe3fMerrheBMdX@cisco.com>
	 <20051217123850.aa6cfd53.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 13:33:55 -0800
Message-Id: <1134855235.20575.22.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +int ipath_mlock(unsigned long start_page, size_t num_pages, struct page **p)
> OK.  It's perhaps not a very well named function.

Really?  Suggestion for a better name?

> > +	}
> > +	vm->vm_flags |= VM_SHM | VM_LOCKED;
> > +
> > +	return 0;
> > +}
> 
> I don't think we want to be setting the user's VMA's vm_flags in this
> manner.  This is purely to retain the physical page across fork?

I didn't write this bit of the driver, but I believe this is the case.
Is there a better way of doing this?

> > +int ipath_munlock(size_t num_pages, struct page **p)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < num_pages; i++) {
> > +		_IPATH_MMDBG("%u/%lu put_page %p\n", i, num_pages, p[i]);
> > +		SetPageDirty(p[i]);
> > +		put_page(p[i]);
> > +	}
> > +	return 0;
> > +}
> 
> Nope, SetPageDirty() doesn't tell the VM that the page is dirty - it'll
> never get written out.  Use set_page_dirty_lock().

OK.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


