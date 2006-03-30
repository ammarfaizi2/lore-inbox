Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWC3TfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWC3TfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWC3TfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:35:00 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:42631 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750758AbWC3TfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:35:00 -0500
Date: Thu, 30 Mar 2006 12:34:57 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioremap_cached()
Message-ID: <20060330193457.GL13590@parisc-linux.org>
References: <20060330164120.GJ13590@parisc-linux.org> <p73zmj7949i.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73zmj7949i.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 08:27:53PM +0200, Andi Kleen wrote:
> Matthew Wilcox <matthew@wil.cx> writes:
> 
> > We currently have three ways for getting access to device memory --
> > ioremap(), ioremap_nocache() and pci_iomap().  99% of the callers of
> > ioremap() are doing it to access device registers, and really, really
> > want to use ioremap_nocache() instead.  I presume nobody notices on PCs
> > because they have write-through caches, but it ought to trip up people
> > trying to flush writes.
> 
> Actually MTRRs take care of that on x86.
> So essentially on x86 ioremap() for devices is already ioremap_uncached()
> And ioremap on memory is cached.
> 
> That's nice and simple semantics that other platforms can emulate too.
> Doing things differently will just cause pain for the other platforms
> when they have to fix up drivers all the time.

That doesn't make any sense.  What's the point of ioremap_nocache() if
ioremap() does magic things that make things uncached?  And who says
you're allowed to ioremap() memory anyway?

> It all works fine until someone wants WC too. I would rather add a 
> ioremap_wc(), that would be more useful.

ioremap_wc() sounds like a good idea.
