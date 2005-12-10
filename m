Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVLJDck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVLJDck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 22:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVLJDck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 22:32:40 -0500
Received: from cantor2.suse.de ([195.135.220.15]:52132 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964907AbVLJDck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 22:32:40 -0500
Date: Sat, 10 Dec 2005 04:32:35 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/6] Framework
Message-ID: <20051210033235.GP11190@wotan.suse.de>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define global_page_state(__x) atomic_long_read(&vm_stat[__x])
> +#define zone_page_state(__z,__x) atomic_long_read(&(__z)->vm_stat[__x])
> +extern unsigned long node_page_state(int node, enum zone_stat_item);
> +
> +/*
> + * For use when we know that interrupts are disabled.

Why do you need to disable interupts for atomic_t ? 
If you just want to prevent switching CPUs that could be 
done with get_cpu(), but alternatively you could just ignore
that race (it wouldn't be a big issue to still increment
the counter on the old CPU)

And why atomic and not just local_t?  On x86/x86-64 local_t
would be much cheaper at least. It's not long, but that could
be as well added.

-Andi

