Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUH1BDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUH1BDG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUH1BDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:03:06 -0400
Received: from colin2.muc.de ([193.149.48.15]:14858 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268043AbUH1BCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:02:55 -0400
Date: 28 Aug 2004 03:02:53 +0200
Date: Sat, 28 Aug 2004 03:02:53 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, clameter@sgi.com, ak@suse.de,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Message-ID: <20040828010253.GA50329@muc.de>
References: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com> <20040816143903.GY11200@holomorphy.com> <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com> <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com> <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com> <20040827233602.GB1024@wotan.suse.de> <Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com> <20040827172337.638275c3.davem@davemloft.net> <20040827173641.5cfb79f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827173641.5cfb79f6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 05:36:41PM -0700, Andrew Morton wrote:
> "David S. Miller" <davem@davemloft.net> wrote:
> >
> > On Fri, 27 Aug 2004 17:19:11 -0700 (PDT)
> > Christoph Lameter <clameter@sgi.com> wrote:
> > 
> > > That is still 2^(32+12) = 2^44 = 16TB.
> > 
> > It's actually:
> > 
> > 	2 ^ (31 + PAGE_SHIFT)
> > 
> > '31' because atomic_t is 'signed' and PAGE_SHIFT should
> > be obvious.
> > 
> > Christoph definitely has a point, this is even more virtual space
> > than most of the 64-bit platforms even support.  (Sparc64 is
> > 2^43 and I believe ia64 is similar)
> 
> When can we reasonably expect someone to blow this out of the water? 
> Within the next couple of years, I suspect?

With 4 level page tables x86-64 will support 47 bits virtual theoretical.
They cannot be used right now because the current x86-64 CPUs have
40 bits physical max and it is currently even hardcoded to 40bits,
but I planned to drop that in the 4 level patch (in fact I already did) 
so that the kernel will in theory support CPUs will more physical memory.


> It does look like we need a new type which is atomic64 on 64-bit and
> atomic32 on 32-bit.  That could be used to fix the
> mmaping-the-same-page-4G-times-kills-the-kernel bug too.

Yep.  Good plan. atomic_long_t ? 

> 
> > and this limit actually
> > mostly comes from the 3-level page table limits.
> 
> This reminds me - where's that 4-level pagetable patch got to?

It exists on my HD, but is not really finished yet.

I was on vacation and travelling and had some other things to do, so it got 
delayed a bit, but I hope to work on it soon again.

-Andi

