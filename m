Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVEMOY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVEMOY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVEMOY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:24:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62109 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262381AbVEMOYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:24:34 -0400
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86
	MTRR handling
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tripperda@nvidia.com
In-Reply-To: <20050513132945.GB16088@wotan.suse.de>
References: <s2832b02.028@emea1-mh.id2.novell.com>
	 <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com>
	 <20050513132945.GB16088@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 13 May 2005 07:24:22 -0700
Message-Id: <1115994262.7129.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 15:29 +0200, Andi Kleen wrote:
> > : x86-64 will need updating to also take advantage of this.
> >   It may be able to just copy the i386 includes as-is, I've
> >   not looked closely at the PAT related changes on x86-64 yet. Andi?
> > 
> > : The list manipulation macros in mm/cachemap.c are a little fugly.
> > 
> > Anything else ?
> 
> For memory (pfn_valid == 1) it would be more memory efficient to use a few bits
> in struct page->flags

I think page->flags use should be limited to things that are relatively
performance-sensitive and arch-independent, mostly because we're running
out of them on 32-bit platforms, fast.

Each incremental use of page flags doesn't have any immediate storage
cost, but it's a serious pain when we run out, and having to bloat it to
a 64-bit value on 32-bit platforms wouldn't be very memory efficient,
either. :)

> In general because there are lots of uses of "range lists" it would be better
> to put it as a library into lib.

Either that, or something like "Dynamically allocated pageflags" would
be nice.

	http://lwn.net/Articles/124332/

-- Dave

