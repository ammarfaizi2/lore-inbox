Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWHPIdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWHPIdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWHPIdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:33:17 -0400
Received: from ns.suse.de ([195.135.220.2]:44724 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751000AbWHPIdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:33:17 -0400
Date: Wed, 16 Aug 2006 10:32:59 +0200
From: Andi Kleen <ak@muc.de>
To: David Chinner <dgc@sgi.com>
Cc: Christoph Lameter <clameter@sgi.com>, mpm@selenic.com,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
Message-Id: <20060816103259.f87c167a.ak@muc.de>
In-Reply-To: <20060816081208.GL51703024@melbourne.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
	<20060816081208.GL51703024@melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 3. New slabs that are created can be merged into the kmalloc array
> >    if it is detected that they match. This decreases the number of caches
> >    and benefits cache use.
> 
> While this will be good for reducing fragmentation,

Will it? The theory behind a zone allocator like slab is that objects of the
same type have similar livetimes. Fragmentation mostly happens when objects
have very different live times. If you mix objects of different types
into the same slab then you might get more fragmentation.
kmalloc already has that problem but it probably shouldn't be added 
to other slabs too.

-Andi

