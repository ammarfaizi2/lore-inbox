Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVHCNUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVHCNUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 09:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVHCNUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 09:20:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42630 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262285AbVHCNU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 09:20:26 -0400
Date: Wed, 3 Aug 2005 15:20:25 +0200
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: pci cacheline size / latency oddness.
Message-ID: <20050803132025.GU10895@wotan.suse.de>
References: <20050801233517.GA23172@redhat.com> <1122943309.26405.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122943309.26405.7.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 08:41:49PM -0400, Parag Warudkar wrote:
> On Mon, 2005-08-01 at 19:35 -0400, Dave Jones wrote:
> > This means we will do the wrong thing on AMD machines which have
> > 64 byte cachelines.
> 
> pcibios_init (in i386/pci/common.c, which is linked in by X86_64 PCI
> code) seems to do this 
>  
> if (c->x86 >= 6 && c->x86_vendor == X86_VENDOR_AMD)
>                 pci_cache_line_size = 64 >> 2;  /* K7 & K8 */
> 
> Is it correct to expect all AMD k7/8 machines to have 16 as cache line
> size - I thought 64 was more appropriate?

iirc the pci cache line register takes a value shifted left by 2 bits.

And yes all K7/K8 machines have 64byte cache lines.

> On my Athlon64 laptop, all PCI devices end up having 0 latency. 

That has nothing to do with the cache line size.

> 
> > x86-64 doesn't have an arch override for pci_cache_line_size
> 
> I am trying to fix it up - What's the right way to override it in x86_64
> code?  Just initialize it to 64 may be?

I don't think there is anything to fix.

-Andi
