Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRCYQfa>; Sun, 25 Mar 2001 11:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbRCYQfU>; Sun, 25 Mar 2001 11:35:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7183 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132072AbRCYQfH>;
	Sun, 25 Mar 2001 11:35:07 -0500
Date: Sun, 25 Mar 2001 17:33:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mm@kvack.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pae-2.4.3-A4
Message-ID: <20010325173344.B30655@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.31.0103191839510.1003-100000@penguin.transmeta.com> <Pine.LNX.4.30.0103251643070.6469-200000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0103251643070.6469-200000@elte.hu>; from mingo@elte.hu on Sun, Mar 25, 2001 at 04:53:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2001 at 04:53:37PM +0200, Ingo Molnar wrote:
> one nontrivial issue was that on PAE the pgd has to be installed with
> 'present' pgd entries, due to a CPU erratum. This means that the
> pgd_present() code in mm/memory.c, while correct theoretically, doesnt
> work with PAE. An equivalent solution is to use !pgd_none(), which also
> works with the PAE workaround.

Certainly that's the way the original *_alloc routines used to work.
In fact, ARM never had need to implement the pmd_present() macros, since
they were never referenced - only the pmd_none() macros were.

However, I'm currently struggling with this change on ARM - so far after
a number of hours trying to kick something into shape, I've not managed
to even get to the stange where I get a kernel image to link, let alone
the compilation to finish.

One of my many dilemas at the moment is how to allocate the page 0 PMD
in pgd_alloc(), where we don't have a mm_struct to do the locking against.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

