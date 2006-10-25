Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423134AbWJYJBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423134AbWJYJBH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 05:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423135AbWJYJBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 05:01:07 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:47296 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1423134AbWJYJBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 05:01:05 -0400
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061025084226.GN5851@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <200610242208.34426.rjw@sisk.pl> <20061024213402.GC5662@elf.ucw.cz>
	 <1161728153.22729.22.camel@nigel.suspend2.net>
	 <20061024221950.GB5851@elf.ucw.cz>
	 <1161729027.22729.37.camel@nigel.suspend2.net>
	 <20061025081135.GM5851@elf.ucw.cz>
	 <1161764907.22729.86.camel@nigel.suspend2.net>
	 <20061025084226.GN5851@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 19:01:04 +1000
Message-Id: <1161766865.22729.96.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-10-25 at 10:42 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > With the code I have in Suspend2 (which is what I'm working towards),
> > > > the value includes the swap_type, so there's no overlap. Assuming the
> > > > swap allocator does it's normal thing and swap allocated is contiguous,
> > > > you'll probably end up with two extents: one containing the swap
> > > > allocated on the first device, and the other containing the swap
> > > > allocated on the second device. So (with the current version), striping
> > > > would use 6 * sizeof(unsigned long) instead of 3 * sizeof(unsigned
> > > > long).
> > > 
> > > And now, can you do same computation assuming the swap allocator goes
> > > completely crazy, and free space is in 1-page chunks?
> > 
> > The worst case is 3 * sizeof(unsigned long) *
> > number_of_swap_extents_allocated bytes.
> 
> Okay, so if we got 4GB of swap space, thats 1MB swap pages, worst case
> is you have one extent per page, on x86-64 that's 24MB. +kmalloc
> overhead, I assume?

Sounds right.

> And you do linear walks over those extents, leading to O(n^2)
> algorithm, no? That has bitten us before...

We start from where we last added an extent on the chain by default.

You're not going to respond to the other bit of my reply? I was
beginning to think you were being more reasonable this time. Oh well.

Regards,

Nigel

