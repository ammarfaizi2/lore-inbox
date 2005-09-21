Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVIUVXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVIUVXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVIUVXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:23:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19414 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964826AbVIUVXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:23:22 -0400
Date: Wed, 21 Sep 2005 23:23:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] Rework image freeing
Message-ID: <20050921212311.GC2071@elf.ucw.cz>
References: <20050921205132.GA4249@elf.ucw.cz> <1127337482.10664.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127337482.10664.21.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +static long alloc_image_page(void)
> > +{
> > +       long res = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
> > +       if (res) {
> > +               SetPageNosave(virt_to_page(res));
> > +               SetPageNosaveFree(virt_to_page(res));
> > +       }
> > +       return res;
> > +}
> 
> Please avoid using longs here.  "res" really is a virtual address, and
> it would be polite to keep it in a pointer of some kind.  Returning
> void* would also avoid the two casts in alloc_pagedir().  The same
> probably goes for pbe->address and pbe->orig_address.
> 
> BTW, I think get_zeroed_page() returns a long to keep people from
> confusing it with the allocator routines that return actual 'struct page
> *', and not the page's virtual address.  So, you really should be
> casting them to real pointers as soon as it comes back from
> get_zeroed_page() and cousins.

Okay, but that's another patch, as I'll have to do s/long/void */ on
whole file. address/orig_address is used at lot of places.

								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
