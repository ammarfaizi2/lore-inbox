Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbUCNBBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUCNBBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:01:21 -0500
Received: from holomorphy.com ([207.189.100.168]:48139 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263236AbUCNBBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:01:19 -0500
Date: Sat, 13 Mar 2004 17:01:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040314010108.GF655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Rajesh Venkatasubramanian <vrajesh@umich.edu>, riel@redhat.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com> <20040310135012.GM30940@dualathlon.random> <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu> <20040312172600.GC30940@dualathlon.random> <Pine.GSO.4.58.0403121548530.2624@sapphire.engin.umich.edu> <Pine.LNX.4.58.0403131246580.28574@ruby.engin.umich.edu> <20040313181606.GO30940@dualathlon.random> <Pine.GSO.4.58.0403131426590.12823@blue.engin.umich.edu> <20040314002348.GQ30940@dualathlon.random> <Pine.LNX.4.58.0403131647000.900@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403131647000.900@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 04:52:00PM -0800, Linus Torvalds wrote:
> Yes. However, I'd at least personally hope that we don't even need the 
> find_vma() all the time.
> When removing a page using the reverse mapping, there really is very
> little reason to even look up the vma, although right now the
> "flush_tlb_page()" interface is done for vma only so we'd need to change 
> that or at least add a "flush_tlb_page_mm(mm, virt)" flusher (and if any 
> architecture wants to look up the vma, they could do so).
> It would be silly to look up the vma if we don't actually need it, and I
> don't think we do. It's likely faster to just look up the page tables
> directly than to even worry about anything else.
> But find_vma() certainly would be sufficient.

find_vma() is often necessary to determine whether the page is mlock()'d.
In schemes where mm's that may not map the page appear in searches, it
may also be necessary to determine if there's even a vma covering the
area at all or otherwise a normal vma, since pagetables outside normal
vmas may very well not be understood by the core (e.g. hugetlb).


-- wli
