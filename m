Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135851AbRD2R7Q>; Sun, 29 Apr 2001 13:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135855AbRD2R7H>; Sun, 29 Apr 2001 13:59:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34947 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135851AbRD2R6y>;
	Sun, 29 Apr 2001 13:58:54 -0400
Date: Sun, 29 Apr 2001 13:58:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Frank de Lange <frank@unternet.org>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Severe trashing in 2.4.4
In-Reply-To: <20010429194631.A11681@unternet.org>
Message-ID: <Pine.GSO.4.21.0104291349530.2210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Apr 2001, Frank de Lange wrote:

> On Sun, Apr 29, 2001 at 12:27:29PM -0400, Alexander Viro wrote:
> > What about /proc/slabinfo? Notice that 2.4.4 (and couple of the 2.4.4-pre)
> > has a bug in prune_icache() that makes it underestimate the amount of
> > freeable inodes.
> 
> Gotcha, wrt. slabinfo. Seems 2.4.4 (at least on my box) only knows how to
> allocate skbuff_head_cache entries, not how to free them. Here's the last
> /proc/slabinfo entry before I sysRQ'd the box:
 
> skbuff_head_cache 341136 341136    160 14214 14214    1 :  252  126
> size-2048          66338  66338   2048 33169 33169    1 :   60   30

Hmm... I'd say that you also have a leak in kmalloc()'ed stuff - something
in 1K--2K range. From your logs it looks like the thing never shrinks and
grows prettu fast...

