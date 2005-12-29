Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVL2VQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVL2VQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVL2VQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:16:49 -0500
Received: from cantor2.suse.de ([195.135.220.15]:19373 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751007AbVL2VQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:16:48 -0500
Date: Thu, 29 Dec 2005 22:16:38 +0100
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andreas Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Eric Dumazet <dada1@cosmosbay.com>, Denis Vlasenko <vda@ilport.com.ua>,
       Matt Mackall <mpm@selenic.com>, Dave Jones <davej@redhat.com>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Message-ID: <20051229211638.GL11515@wotan.suse.de>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua> <200512281054.26703.vda@ilport.com.ua> <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <1135885721.6039.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135885721.6039.32.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK then, after reading this I figured there must be a way to dynamically
> allocate slab sizes based on the kmalloc constants.  So I spent last
> night and some of this morning coming up with the below patch.

The canonical slab theory is that constant allocations are for fixed
objects. And if they are frequent they should be in theory kmem
cache because in theory their object live times should be similar
and clustering them together should give the best fragmentation
advoidance.

So in theory longer term the dynamic kmallocs are more important because
they cannot be handled like this - and these are not caught by
your patch.

So I'm not sure you're optimizing the right thing here.

Perhaps a good evolution your patch would be to add some analysis of
the callers and generate a nice compile time report that people can use as a 
guideline to convert kmalloc over the kmem_cache_alloc. But to do this really
well would require dynamic data from runtime.

Given that I think a runtime patch is better. Ideally one that's easy
to use with someone collecting data from users and then submitting a patch
for a better new set of default slabs.  Would need to be separate
for 32bit and 64bit too.

I guess one could run a fancy dynamic optimization algorithm to find
the best set of slabs from the data.

-Andi

