Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVLLMvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVLLMvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 07:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVLLMvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 07:51:48 -0500
Received: from hera.kernel.org ([140.211.167.34]:2775 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751140AbVLLMvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 07:51:48 -0500
Date: Mon, 12 Dec 2005 09:57:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org
Subject: Re: [RFC 3/6] Make nr_pagecache a per zone counter
Message-ID: <20051212115731.GA3599@dmt.cnet>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005456.3887.94412.sendpatchset@schroedinger.engr.sgi.com> <20051211183241.GD4267@dmt.cnet> <20051211194840.GU11190@wotan.suse.de> <20051211204943.GA4375@dmt.cnet> <439CF3B1.4050803@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439CF3B1.4050803@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 02:51:13PM +1100, Nick Piggin wrote:
> Marcelo Tosatti wrote:
> >On Sun, Dec 11, 2005 at 08:48:40PM +0100, Andi Kleen wrote:
> >
> >>>By the way, why does nr_pagecache needs to be an atomic variable on UP 
> >>>systems?
> >>
> >>At least on X86 UP atomic doesn't use the LOCK prefix and is thus quite
> >>cheap. I would expect other architectures who care about UP performance
> >>(= not IA64) to be similar.
> >
> >
> >But in practice the variable does not need to be an atomic type for UP, but
> >simply a word, since stores are atomic on UP systems, no?
> >
> >Several arches seem to use additional atomicity instructions on 
> >atomic functions:
> >
> 
> Yeah, this is to protect from interrupts and is common to most
> load store architectures. It is possible we could have
> atomic_xxx_irq / atomic_xxx_irqsave functions for these, however
> I think nobody has yet demostrated the improvements outweigh the
> complexity that would be added.

Hi Nick,

But nr_pagecache is not accessed at interrupt code, is it? It does
not need to be an atomic type.

