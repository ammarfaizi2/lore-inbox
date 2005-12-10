Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVLJD0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVLJD0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 22:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVLJD0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 22:26:47 -0500
Received: from cantor.suse.de ([195.135.220.2]:24215 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964904AbVLJD0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 22:26:46 -0500
Date: Sat, 10 Dec 2005 04:26:44 +0100
From: Andi Kleen <ak@suse.de>
To: Keith Mannthey <kmannth@gmail.com>
Cc: Andi Kleen <ak@muc.de>, Matt Tolentino <metolent@cs.vt.edu>, akpm@osdl.org,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       matthew.e.tolentino@intel.com
Subject: Re: [discuss] Re: [patch 3/3] add x86-64 support for memory hot-add
Message-ID: <20051210032644.GJ15804@wotan.suse.de>
References: <200512091523.jB9FNn5J006697@ap1.cs.vt.edu> <20051209173249.GA54033@muc.de> <a762e240512091616l62f1c69andeec382d7356ba64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a762e240512091616l62f1c69andeec382d7356ba64@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 04:16:41PM -0800, Keith Mannthey wrote:
> > These should be all __cpuinit.
> >
> > In general SRAT has a hotplug memory bit so it's possible
> > to predict how much memory there will be in advance. Since
> > the overhead of the kernel page tables should be very
> > low I would prefer if you just used instead.
> 
> How much overhead would there be?

It's 2MB pages in 3levels, so roughly 3*8=24 bytes per 2MB or roughly
512 bytes per GB (rounded up always to the next page)

> 
> > (i.e. instead of extending the kernel mapping preallocate
> > the direct mapping and just clear the P bits)
> 
> On my box the SRAT for hot-add areas exposed are from the end
> installed memory to way out in outerspace.
> SRAT: hot plug zone found 280000000 - 2300000000
> I can't hot add that sort of range on my box but the bios didn't want
> to limit or is planing for really really big dimms.

You're just proving someone's (anyone want to volunteer their name? ;-]
I think Linus pointed it out originally, so let's call it Linus') 
law - as soon as we use some BIOS feature we soon find a BIOS 
that will get it totally wrong.

Anyways, I retracted anyways because of some other issues so Matt's 
original approach should be ok.

-Andi
