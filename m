Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVADQOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVADQOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVADQNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:13:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11533 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261715AbVADQKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:10:52 -0500
Date: Tue, 4 Jan 2005 16:10:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-bkcurr: major slab corruption preventing booting on ARM
Message-ID: <20050104161049.D22890@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050104144350.A22890@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050104144350.A22890@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jan 04, 2005 at 02:43:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 02:43:50PM +0000, Russell King wrote:
> I've had a report from a fellow ARM hacker of their platform not
> booting.  After they turned on slab debugging, they saw (pieced
> together from a report on IRC):
> 
> Freeing init memory: 104K
> run_init_process(/bin/bash)
> Slab corruption: start=c0010934, len=160
> Last user: [<c00adc54>](d_alloc+0x28/0x2d8)
> 
> I've just run up 2.6.10-bkcurr on a different ARM platform, and
> encountered the following output.  It looks like there's serious
> slab corruption issues in these kernels.
> 
> I'll dig a little further into the report below to see if there's
> anything obvious.

Ok, reverting the pud_t patch fixes both these problems (the exact
patch can be found at: http://www.home.arm.linux.org.uk/~rmk/misc/bk4-bk5
Note that this is not a plain bk4-bk5 patch, but just the pud_t
changes brought forward to bk6 or there abouts.)

So, something in the 4 level page table patches is causing random
scribbling in kernel memory.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
