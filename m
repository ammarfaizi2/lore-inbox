Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWBISEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWBISEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWBISEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:04:51 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:43432 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932515AbWBISEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:04:50 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17387.33855.858274.530175@gargle.gargle.HOWL>
Date: Thu, 9 Feb 2006 21:04:47 +0300
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.ck,gmane.linux.kernel.mm
In-Reply-To: <43EB43B9.5040001@yahoo.com.au>
References: <200602092339.49719.kernel@kolivas.org>
	<43EB43B9.5040001@yahoo.com.au>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:

[...]

 > > +/*
 > > + * We check to see no part of the vm is busy. If it is this will interrupt
 > > + * trickle_swap and wait another PREFETCH_DELAY. Purposefully racy.
 > > + */
 > > +inline void delay_swap_prefetch(void)
 > > +{
 > > +	__set_bit(0, &swapped.busy);
 > > +}
 > > +
 > 
 > Test this first so you don't bounce the cacheline around in page
 > reclaim too much.

Shouldn't we have special macros/inlines for this? Like, e.g.,

static inline void __set_bit_weak(int nr, volatile unsigned long * addr)
{
        if (!__test_bit(nr, addr))
                __set_bit(nr, addr);
}

? These test-then-set sequences start to proliferate throughout the code.

[...]

Nikita.
