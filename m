Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUDMABl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 20:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUDMABl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 20:01:41 -0400
Received: from zero.aec.at ([193.170.194.10]:11275 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263171AbUDMABh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 20:01:37 -0400
To: Terence Ripperda <tripperda@nvidia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PAT support
References: <1KifY-uA-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 13 Apr 2004 02:01:33 +0200
In-Reply-To: <1KifY-uA-7@gated-at.bofh.it> (Terence Ripperda's message of
 "Tue, 13 Apr 2004 00:40:06 +0200")
Message-ID: <m3n05gu4o2.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda <tripperda@nvidia.com> writes:

Hi Terence,

> this current patch includes the original PAT support and the new
> cachemap mechanism. note that the cachemap mechanism does not
> actually change any caching attributes, it only keeps track of the
> attributes and tests regions. I think the end idea would be that
> drivers would use the normal
> ioremap/change_page_attr/remap_page_range mechanisms like they
> already do, and these mechanisms would in turn use cachemap to make
> sure there's no conflicts. I'm completely open to how any specific
> details should work, and any changes needed to be made.

Looks good for starting. The patch could use some minor cleanup still,
but it should be good enough for testing.

As for an interface - i still think it would be cleaner to just
call it from change_page_attr(). Then other users only need to
call a single function. But that's easily changed.

To make it really useful I think we need ioremap_wrcomb() and support
in the bus/pci mmap function (the PCI layer already has ioctls for this,
they are just ignored on i386 right). Then the X server could
start using it. 

Without any users the testing coverage would be probably not too good,
but it needs some testing in the real world before it could 
be merged first. Maybe it could be simply hooked into the AGP
driver and into some DRM driver. Then people would start testing
it at least.

-Andi

