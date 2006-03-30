Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWC3U2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWC3U2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWC3U2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:28:09 -0500
Received: from ns.suse.de ([195.135.220.2]:23730 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750825AbWC3U2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:28:00 -0500
From: Andi Kleen <ak@suse.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ioremap_cached()
Date: Thu, 30 Mar 2006 22:27:53 +0200
User-Agent: KMail/1.9.1
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
References: <20060330164120.GJ13590@parisc-linux.org> <200603302217.55435.ak@suse.de> <D3AB1B22-E33B-409F-BF54-2F6FD071337A@kernel.crashing.org>
In-Reply-To: <D3AB1B22-E33B-409F-BF54-2F6FD071337A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603302227.53343.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 22:21, Kumar Gala wrote:
> 
> On Mar 30, 2006, at 2:17 PM, Andi Kleen wrote:
> 
> > On Thursday 30 March 2006 22:14, Matthew Wilcox wrote:
> >
> >> I think you misunderstood.  The right interface to call, that should
> >> work everywhere, should be the simple, obvious one.  ioremap().  That
> >> effectively is what everyone gets anyway (since they test on x86).
> >> So change the *definition* of ioremap() to be uncached.  Then we  
> >> can add
> >> ioremap_wc() and ioremap_cached() for these special purpose mappings.
> >
> > That would break all the current users who do ioremap on memory
> > and want it cached.
> 
> What's an example of this?  I ask since on powerpc ioremap() is  
> always _PAGE_NO_CACHE.

ACPI, IPMI, DMI, ... I bet there are more. It's needed every time
a driver needs to look for some firmware table because it might
not be mapped.

-Andi
