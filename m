Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVEMN3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVEMN3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 09:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVEMN3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 09:29:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:18091 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262360AbVEMN3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 09:29:50 -0400
Date: Fri, 13 May 2005 15:29:45 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, ak@suse.de,
       tripperda@nvidia.com
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050513132945.GB16088@wotan.suse.de>
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512214118.GA25065@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> : x86-64 will need updating to also take advantage of this.
>   It may be able to just copy the i386 includes as-is, I've
>   not looked closely at the PAT related changes on x86-64 yet. Andi?
> 
> : The list manipulation macros in mm/cachemap.c are a little fugly.
> 
> Anything else ?

For memory (pfn_valid == 1) it would be more memory efficient to use a few bits
in struct page->flags

In general because there are lots of uses of "range lists" it would be better
to put it as a library into lib.

Coding style needs some work.

Too many printks.

I am not sure yet the cmaps don't need reference counting. For some
cases (user space support) they probably will.

Need user space support, e.g. using the existing ioctls for /proc/bus/pci/*
(they are currently not implemented on i386/x86-64 but should with this)
Then someone would need to change the X server to use this.

Needs testing on a lot of systems.

Need to figure out if CMAP_ALLOW_OVERLAPPING should be set or not.

Probably need to go over the combining rule etc. with a fine comb

-Andi
