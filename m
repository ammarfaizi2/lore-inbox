Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVADRSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVADRSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVADRSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:18:49 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:2456
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261810AbVADRSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:18:44 -0500
Date: Tue, 4 Jan 2005 17:18:43 +0000
From: Ben Dooks <ben@fluff.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-bkcurr: major slab corruption preventing booting on ARM
Message-ID: <20050104171843.GA4848@home.fluff.org>
References: <20050104144350.A22890@flint.arm.linux.org.uk> <20050104161049.D22890@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104161049.D22890@flint.arm.linux.org.uk>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 04:10:49PM +0000, Russell King wrote:
> On Tue, Jan 04, 2005 at 02:43:50PM +0000, Russell King wrote:
> > I've had a report from a fellow ARM hacker of their platform not
> > booting.  After they turned on slab debugging, they saw (pieced
> > together from a report on IRC):
> > 
> > Freeing init memory: 104K
> > run_init_process(/bin/bash)
> > Slab corruption: start=c0010934, len=160
> > Last user: [<c00adc54>](d_alloc+0x28/0x2d8)
> > 
> > I've just run up 2.6.10-bkcurr on a different ARM platform, and
> > encountered the following output.  It looks like there's serious
> > slab corruption issues in these kernels.
> > 
> > I'll dig a little further into the report below to see if there's
> > anything obvious.
> 
> Ok, reverting the pud_t patch fixes both these problems (the exact
> patch can be found at: http://www.home.arm.linux.org.uk/~rmk/misc/bk4-bk5
> Note that this is not a plain bk4-bk5 patch, but just the pud_t
> changes brought forward to bk6 or there abouts.)
> 
> So, something in the 4 level page table patches is causing random
> scribbling in kernel memory.

I've tried that, and it fixes the problems for me on
the EB2410ITX (ARM9 2410) and the corruption of the initial-ramdisk.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
