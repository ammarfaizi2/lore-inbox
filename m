Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUDOEL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 00:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbUDOEL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 00:11:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33696 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263726AbUDOELz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 00:11:55 -0400
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: PAT support
References: <1KifY-uA-7@gated-at.bofh.it>
	<m3n05gu4o2.fsf@averell.firstfloor.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Apr 2004 22:11:01 -0600
In-Reply-To: <m3n05gu4o2.fsf@averell.firstfloor.org>
Message-ID: <m1fzb56fu2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> Terence Ripperda <tripperda@nvidia.com> writes:
> 
> Hi Terence,
> 
> > this current patch includes the original PAT support and the new
> > cachemap mechanism. note that the cachemap mechanism does not
> > actually change any caching attributes, it only keeps track of the
> > attributes and tests regions. I think the end idea would be that
> > drivers would use the normal
> > ioremap/change_page_attr/remap_page_range mechanisms like they
> > already do, and these mechanisms would in turn use cachemap to make
> > sure there's no conflicts. I'm completely open to how any specific
> > details should work, and any changes needed to be made.
> 
> Looks good for starting. The patch could use some minor cleanup still,
> but it should be good enough for testing.
> 
> As for an interface - i still think it would be cleaner to just
> call it from change_page_attr(). Then other users only need to
> call a single function. But that's easily changed.
> 
> To make it really useful I think we need ioremap_wrcomb() and support
> in the bus/pci mmap function (the PCI layer already has ioctls for this,
> they are just ignored on i386 right). Then the X server could
> start using it. 
> 
> Without any users the testing coverage would be probably not too good,
> but it needs some testing in the real world before it could 
> be merged first. Maybe it could be simply hooked into the AGP
> driver and into some DRM driver. Then people would start testing
> it at least.

This would also be extremely useful on machines with large amounts
of memory, for write-back mappings.  With large amounts but odd sized
entries it becomes extremely tricky to map all of the memory using
mtrrs.

Last I looked the common remedy was to using overlapping mtrrs
which the kernel does not understand and that make it impossible
for X to setup write-combining MTRRs.

The memory map on x86 shows no hope of getting simpler and mtrrs 
are getting continually less good at being able to scale so getting
PAT support of some kind in the kernel would be extremely good.

Eric
