Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbUJ1AcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUJ1AcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbUJ1A3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:29:50 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:39059 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262669AbUJ1A1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:27:00 -0400
Date: Thu, 28 Oct 2004 02:26:39 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041028002639.GJ14325@dualathlon.random>
References: <20041025170128.GF14325@dualathlon.random> <Pine.LNX.4.44.0410252147330.30224-100000@chimarrao.boston.redhat.com> <20041026015825.GU14325@dualathlon.random> <417DC8F2.7000902@yahoo.com.au> <20041026040429.GW14325@dualathlon.random> <417DCFDD.50606@yahoo.com.au> <20041027002536.GM14325@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027002536.GM14325@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 02:25:37AM +0200, Andrea Arcangeli wrote:
> On Tue, Oct 26, 2004 at 02:17:33PM +1000, Nick Piggin wrote:
> > OK that makes sense... it isn't the length of the name, but the fact
> > that that naming convention hasn't proliferated thoughout the 2.6 tree;
> 
> I don't see any other equivalent teminology besides my "classzone" word
> existing, if we standardize on "alloc_type" to only mean a classzone
> then I'd be fine to giveup on my wording, I don't care to retain my
> wording, but to me classzone sounds more self explanatory than
> alloc_type (though I must be biased having invented that word).
> 
> > maybe could you add a little comment along the lines of the above?
> 
> sure. done here:
> 
> 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/lowmem_reserve-2

sorry there was a small buglet, when testing I must have tweaked the
sysctl before sysrq+m so I overlooked it until now when I was playing
with a new feature (the other version of the patch against 2.6.5 that I
tested more closely didn't miss the below)

So it was disabled by default *still* ;)

--- 1-lowmem_reserve/mm/page_alloc.c.~1~	2004-10-28 01:56:50.000000000 +0200
+++ 1-lowmem_reserve/mm/page_alloc.c	2004-10-28 02:18:39.160567304 +0200
@@ -1916,6 +1916,7 @@ static int __init init_per_zone_pages_mi
 	if (min_free_kbytes > 16384)
 		min_free_kbytes = 16384;
 	setup_per_zone_pages_min();
+	setup_per_zone_lowmem_reserve();
 	return 0;
 }
 module_init(init_per_zone_pages_min)


full update ready to be merged is here:

	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/lowmem_reserve-3

thanks.
