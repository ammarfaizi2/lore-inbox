Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSFPXhd>; Sun, 16 Jun 2002 19:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316616AbSFPXhc>; Sun, 16 Jun 2002 19:37:32 -0400
Received: from ns.suse.de ([213.95.15.193]:65292 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316615AbSFPXhb>;
	Sun, 16 Jun 2002 19:37:31 -0400
Date: Mon, 17 Jun 2002 01:37:32 +0200
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
       Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: another new version of pageattr caching conflict fix for 2.4
Message-ID: <20020617013732.A14867@wotan.suse.de>
References: <20020614062754.A11232@wotan.suse.de> <20020614112849.A22888@redhat.com> <20020614181328.A18643@wotan.suse.de> <20020614173133.GH2314@inspiron.paqnet.com> <20020614200537.A5418@wotan.suse.de> <m17kkzv8lq.fsf@frodo.biederman.org> <20020616184801.A15227@wotan.suse.de> <m13cvnun7o.fsf@frodo.biederman.org> <20020616204305.A32022@wotan.suse.de> <m1y9dft2t8.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y9dft2t8.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > MTRRs work on physical, not virtual memory, so they have no aliasing
> > issues.
> 
> Doesn't the AGP aperture cause a physical alias?  Leading to strange

Yes. That's what this patch is all about.

> the same problems if the agp aperture was marked write-back, and the

AGP aperture is uncacheable, not write-back.

> memory was marked uncacheable.  My gut impression is to just make the
> agp aperture write-back cacheable, and then we don't have to change
> the kernel page table at all.  Unfortunately I don't expect the host

That would violate the AGP specification.

> bridge with the memory and agp controllers to like that mode,
> especially as there are physical aliasing issues.

exactly.

> 
> > Fixing the MTRRs is fine, but it is really outside the scope of my patch.
> > Just changing the kernel map wouldn't be enough to fix wrong MTRRs,
> > because it wouldn't cover highmem. 
> 
> My preferred fix is to use PAT, to override the buggy mtrrs.  Which
> brings up the same aliasing issues.  Which makes it related but
> outside the scope of the problem.

I don't follow you here. IMHO it is much easier to fix the MTRRs in the
MTRR driver for those rare buggy BIOS (if they exist - I've never seen one)
than to hack up all of memory management just to get the right bits set.
I see no disadvantage of using the MTRRs and it is lot simpler than
PAT and pte bits.


-Andi

