Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWJYMro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWJYMro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWJYMro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:47:44 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:61139 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964802AbWJYMrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:47:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Date: Wed, 25 Oct 2006 14:46:40 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <20061025091022.GB7266@elf.ucw.cz> <1161770750.22729.117.camel@nigel.suspend2.net>
In-Reply-To: <1161770750.22729.117.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251446.41344.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25 October 2006 12:05, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2006-10-25 at 11:10 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > And now, can you do same computation assuming the swap allocator goes
> > > > > > completely crazy, and free space is in 1-page chunks?
> > > > > 
> > > > > The worst case is 3 * sizeof(unsigned long) *
> > > > > number_of_swap_extents_allocated bytes.
> > > > 
> > > > Okay, so if we got 4GB of swap space, thats 1MB swap pages, worst case
> > > > is you have one extent per page, on x86-64 that's 24MB. +kmalloc
> > > > overhead, I assume?
> > > 
> > > Sounds right.
> > 
> > Ok, 24-50MB per 4GB of swap space is not _that_ bad...
> 
> Other way round: 12MB for x86, 24 for x86_64 is the worst case.
> Actually, come to think of it, that would be for 8GB of swap space. The
> worst case would require every page of swap to be alternately free and
> allocated, so for 4GB you'd only have 2GB of swap allocated = 1/2 the
> number of extents and half the memory requirements.
> 
> > > > And you do linear walks over those extents, leading to O(n^2)
> > > > algorithm, no? That has bitten us before...
> > > 
> > > We start from where we last added an extent on the chain by default.
> > 
> > ...but linear search through 24MB _is_ going to hurt.
> 
> If we did one, yes it would. But this will be O(1) since we start at the
> last value, and get_swap_page goes through the space sequentially.

No, it doesn't, AFAICT, but I don't think it matters.

The question is whether there is a chance we'll get anywhere close to the
worst case and I think the answer is 'no' due to the way in which the swap
allocation works.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
