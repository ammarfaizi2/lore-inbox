Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWC3UOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWC3UOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWC3UOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:14:36 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:54937 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750794AbWC3UOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:14:35 -0500
Date: Thu, 30 Mar 2006 13:14:35 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioremap_cached()
Message-ID: <20060330201435.GM13590@parisc-linux.org>
References: <20060330164120.GJ13590@parisc-linux.org> <p73zmj7949i.fsf@verdi.suse.de> <20060330193457.GL13590@parisc-linux.org> <200603302150.05357.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603302150.05357.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 09:50:05PM +0200, Andi Kleen wrote:
> > That doesn't make any sense.  What's the point of ioremap_nocache() if
> > ioremap() does magic things that make things uncached? 
> 
> In theory ioremap_nocache would force uncached even if there is no MTRR
> and is better/clearer.
> 
> But on x86 there normally is, so lots of code gets it wrong.
> 
> My point is just that forcing a semantics that's not enforced
> on x86 would be a uphill battle for everybody else. Probably not
> a good idea. Better fake x86.

I think you misunderstood.  The right interface to call, that should
work everywhere, should be the simple, obvious one.  ioremap().  That
effectively is what everyone gets anyway (since they test on x86).
So change the *definition* of ioremap() to be uncached.  Then we can add
ioremap_wc() and ioremap_cached() for these special purpose mappings.

> It's unfortunately tricky to get it fully right on x86. The issue
> is to have a good way avoid illegal cache aliases. There were some
> attempts, but so far they never were polished up from the initial
> prototypes.

I know there's similar issues with Itanium.  IIRC, the EFI memory map
helps here by saying how various different types of memory should be
mapped.
