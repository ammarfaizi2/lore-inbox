Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbUKRMv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbUKRMv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbUKRMv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:51:27 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:47078 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262760AbUKRMvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:51:25 -0500
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Keir.Fraser@cl.cam.ac.uk, haveblue@us.ibm.com, Ian.Pratt@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value 
In-reply-to: Your message of "Thu, 18 Nov 2004 02:36:20 PST."
             <20041118103620.GC3217@holomorphy.com> 
Date: Thu, 18 Nov 2004 12:51:12 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUlkn-0007sb-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Nov 18, 2004 at 02:14:19AM -0800, Andrew Morton wrote:
> > Just send 'em to linux-kernel first-up and cc everyone else.  That way you
> > avoid duplication of effort and everyone is on the same page.
> > I'm still struggling to understand the rationale behind the mem.c change
> > btw.  io_remap_page_range() _is_ remap_page_range() (or, now,
> > remap_pfn_range()) on x86.  So whatever the patch is supposed to be doing,
> > it's a no-op.
> 
> Sorry for stepping in so late. io_remap_page_range() has an
> architecture-specific calling convention. It can't be used in code
> shared across where the calling conventions differ until that's
> resolved (which I intend to do, though I'm not going to stop anyone
> from doing it before I get around to it).

Having pulled the latest snapshot, it's good to see that
remap_pfn_range has cleaned things up a bit. However, it doesn't
solve our problem.

In arch xen we need to use a different function for mapping MMIO
or BIOS pages, which is the /dev/mem behaviour we need to
support.

I'm not sure we can do this without changing the call in mem.c,
at least not without adding an extra hook inside remap_pfn_range
that allows us to use an alternative to set_pte e.g. slow_set_pte
that tries to figure out whether the pfn is real memory or
not. Personally I think the mem.c #ifdef is cleaner and more
robust. 

I'm not sure I understand the issue about io_remap_page_range
having an architecture-specific calling convention. Please can
you enlighten me.

Thanks,
Ian



