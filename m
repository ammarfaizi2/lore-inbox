Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUH1BSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUH1BSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUH1BSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:18:05 -0400
Received: from colin2.muc.de ([193.149.48.15]:33544 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268092AbUH1BSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:18:00 -0400
Date: 28 Aug 2004 03:17:59 +0200
Date: Sat, 28 Aug 2004 03:17:59 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, clameter@sgi.com, ak@suse.de, wli@holomorphy.com,
       davem@redhat.com, raybry@sgi.com, benh@kernel.crashing.org,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Message-ID: <20040828011759.GF50329@muc.de>
References: <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com> <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com> <20040827233602.GB1024@wotan.suse.de> <Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com> <20040827172337.638275c3.davem@davemloft.net> <20040827173641.5cfb79f6.akpm@osdl.org> <20040827174038.67b9cbce.davem@davemloft.net> <20040828010542.GB50329@muc.de> <20040827181142.7c382a65.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827181142.7c382a65.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 06:11:42PM -0700, David S. Miller wrote:
> On 28 Aug 2004 03:05:42 +0200
> Andi Kleen <ak@muc.de> wrote:
> 
> > I would expect most programs to be not have that many holes,
> 
> Holes are not the issue.

Holey parts will be quickly skipped in pml4.

> 
> clear_page_tables() doesn't even use the VMA list as a guide
> (it actually can't), it just walks the page tables one pgd at a
> time, one pmd at a time, one pte at a time.  And this has the
> worst cache behavior even for simple cases like lat_proc
> in lmbench.
> 
> Each pgd/pmd scan is a data reading walk of a whole page
> (or whatever size the particular page table level blocks
> are for the platform, usually they are PAGE_SIZE).
> It's very costly.

Ok, haven't done measurements yet. I would hope though that
on any arch that needs 4 levels reading another PAGE_SIZE worth 
of memory is not prohibitive.

That said any optimizations are welcome of course.

-Andi


