Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSKOBiy>; Thu, 14 Nov 2002 20:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSKOBiy>; Thu, 14 Nov 2002 20:38:54 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60617 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265475AbSKOBix>; Thu, 14 Nov 2002 20:38:53 -0500
Date: Thu, 14 Nov 2002 20:45:39 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>, Tim Hockin <thockin@sun.com>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
Message-ID: <20021114204539.A15162@devserv.devel.redhat.com>
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com> <3DD43C65.80103@sun.com> <20021114193156.A2801@devserv.devel.redhat.com> <3DD443EC.2080504@sun.com> <20021115011947.GP23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115011947.GP23425@holomorphy.com>; from wli@holomorphy.com on Thu, Nov 14, 2002 at 05:19:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Offer an alternative?  :)  Linked list costs us as much or MORE for 
> > ->next as the gid_t.  kmalloc() doesn't work for previous reasoning.  I 
> > considered a list of gid arr[256] or similar.  A voice reminds me that 
> > it doesn't impact us noticably in real use.  Now, maybe other 
> > architectures will find a good reason to switch to kmalloc() list of 
> > smaller arrays, and the associated complextities or something else more 
> > clever.
> 
> Well, there are always B-trees; nice low arrival rates to the allocator
> owing to elements/node and O(lg(n)) searches with low constants due to
> big fat branching factors. Not my call though.

This sounds intriguing.

Bill, if I may borrow from your data structure expertise,
what would you do if you wanted gid_t's indexed by two criteria?
Obviously, we want them them indexed by value (to look them up
for access checking), but NFS also needs them sorted by usage,
to fit the last 3 into the RPC parameters. This looks like
something requiring two overlaying trees who share leafs,
and every leaf being a single gid_t, with nightmarish overhead.

Before Tim came to the scene, the hope was that lookups would
do exhaustive search of arrays, sorted by LRU, while RPC
picked N leading elements of said sorted array. Tim busts
this scheme to pieces, because he sorts arrays by value
(if I read it right).

-- Pete
