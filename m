Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVCAUNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVCAUNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVCAUND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:13:03 -0500
Received: from waste.org ([216.27.176.166]:9112 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262011AbVCAUM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:12:58 -0500
Date: Tue, 1 Mar 2005 12:12:41 -0800
From: Matt Mackall <mpm@selenic.com>
To: Christophe Saout <christophe@saout.de>
Cc: Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Message-ID: <20050301201241.GM3120@waste.org>
References: <2.416337461@selenic.com> <200502271417.51654.agruen@suse.de> <20050227212536.GG3120@waste.org> <1109703983.16139.16.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109703983.16139.16.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 08:06:22PM +0100, Christophe Saout wrote:
> Am Sonntag, den 27.02.2005, 13:25 -0800 schrieb Matt Mackall:
> 
> > Which kernel? There was an off-by-one for odd array sizes in the
> > original posted version that was quickly spotted:
> > 
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/broken-out/sort-fix.patch
> > 
> > I've since tested all sizes 1 - 1000 with 100 random arrays each, so
> > I'm fairly confident it's now fixed.
> 
> -	int i = (num/2 - 1) * size, n = num * size, c, r;
> +	int i = (num/2) * size, n = num * size, c, r;
> 
> What's probably meant is: ((num - 1)/2) * size
> 
> `i' must cover half of the array or a little bit more (not less, in case
> of odd numbers). `i' (before my patch) is the highest address to start
> with, so that's why it should be ((num + 1)/2 - 1) * size or simpler:
> ((num - 1)/2) * size

Argh. Yes, you're right. This probably deserves a comment since it's
been gotten wrong twice. I'll add something..
 
> Anyway, I was wondering, is there a specific reason you are not using
> size_t for the offset variables? size is a size_t and the only purpose
> of the variables i, n, c and r is to be compared or added to the start
> pointer (also I think it's just ugly to cast size_t down to an int).
> 
> On system where int is 32 bit but pointers are 64 bit the compiler might
> need to extend to adjust the size of the operands for the address
> calculation. Right?
> 
> Since size_t is unsigned I also had to modify the two loops since I
> can't check for any of the variables becoming negative. Tested with all
> kinds of array sizes.

This is good, but I suspect you'll have Andrew pulling his hair out as
I'll then have to go adjust all the callers and this is already a huge
mess because of the ACL bits from Andreas. As the current code
correctly (but slightly suboptimally) sorts any array size less than a
2G, I think it's safe to hold off on this for a bit. I'll queue this
up for after the sort and ACL stuff gets merged.

-- 
Mathematics is the supreme nostalgia of our time.
