Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbUCTQ5e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUCTQ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:57:34 -0500
Received: from holomorphy.com ([207.189.100.168]:55176 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262310AbUCTQ5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:57:32 -0500
Date: Sat, 20 Mar 2004 08:57:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320165726.GG2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <20040320155739.GQ9009@dualathlon.random> <20040320161538.C6726@flint.arm.linux.org.uk> <20040320162534.GU9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320162534.GU9009@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 05:25:34PM +0100, Andrea Arcangeli wrote:
> they're using MMIO pci space or it wouldn't catch my BUG_ON on x86.
> The whole point is that it is non ram, if it would be ram, x86 couldn't
> notice the virt_to_page, since the page_t would be in the range of the
> mem_map_t and pfn_valid would be happy with it.
> If it was dma_alloc_coherent it would return ram I think, not non-ram.

Any idea what driver? /dev/mem, which is where X typically gets its
mappings of mmiospace, doesn't actually use ->nopage(). Maybe rmk's
notion of doing it all from within the drivers is the right idea in
general, or at least until we hit cases that can't be handled that
way at all.


-- wli
