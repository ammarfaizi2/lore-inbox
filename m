Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWDXPg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWDXPg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWDXPg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:36:29 -0400
Received: from waste.org ([64.81.244.121]:7660 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750775AbWDXPg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:36:29 -0400
Date: Mon, 24 Apr 2006 10:33:08 -0500
From: Matt Mackall <mpm@selenic.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch 4/4] change slab poison pattern
Message-ID: <20060424153308.GA15445@waste.org>
References: <20060424083333.217677000@localhost.localdomain> <20060424083342.743876000@localhost.localdomain> <1145870404.21484.2.camel@localhost> <20060424102352.GA5789@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424102352.GA5789@miraclelinux.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 06:23:52PM +0800, Akinobu Mita wrote:
> On Mon, Apr 24, 2006 at 12:20:03PM +0300, Pekka Enberg wrote:
> > > Because use-after-free poisoning make kref counter signed value.
> > > So this patch prevents it by changing poisoning pattern.
> > 
> > Then why not check against POISON_INUSE when CONFIG_SLAB_DEBUG in the
> > kref debugging code? I would prefer you didn't change the slab constants
> > (they're well known by everyone now) but if you must, at least stick a
> > big fat comment there.
> 
> This slab poisoning pattern change is not very important.
> 
> Because even if slab debugging is enalbed, kref_put() with unreferenced
> kref object will be detected as slab corruption.
> 
> Because kref_put() decrements the kref counter in freed slab object.
> 
> Slab corruption: start=e0e8b698, len=32
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<f08ea008>](release_test_kref+0x8/0x14 [test])
> 000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>                  ^^
> The main reason I want to propose this kref debugging is because
> I can find many places where we can replace from atomic_t to
> struct kref by doing "grep -r atomic_dec_and_test .".
> 
> But I warried that replacing by kref will just increase atomic operations
> because of debugging code in kref (WARN_ON()es in kref.c)
> 
> So patch 4/4 is not very important, I want to drop patch 4/4.

It would have conflicted with this, btw:

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm3/broken-out/add-poisonh-and-patch-primary-users.patch

-- 
Mathematics is the supreme nostalgia of our time.
