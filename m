Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUDCFON (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 00:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUDCFON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 00:14:13 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:45289 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261443AbUDCFOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 00:14:06 -0500
Date: Fri, 2 Apr 2004 21:12:58 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 5/23] mask v2 - Add new mask.h file
Message-Id: <20040402211258.0540497f.pj@sgi.com>
In-Reply-To: <1080937563.9787.109.camel@arrakis>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131129.4329336f.pj@sgi.com>
	<1080937563.9787.109.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not a bit fan of the names of these macros ... MASK_ALL1 ...

Hmmm ... the way these names were, in this patch a couple of days
ago, they spanned files (defined in mask.h, used in cpumask.h).
So making the names a little "bigger" might make sense.  I use "big"
names for stuff that is intended to be visible in larger namespaces.

However:

 1) With yesterdays 24/23 patch, these names only span a few
    lines in mask.h, so short cryptic names are perhaps more
    appropriate.

 2) The key issue here is whether the mask.h type is intended to
    usable in its own right, only to generate various named
    mask types.

    We _could_ have three levels of coding multiword bit masks:

        cpumask, nodemask, ...
        mask
        bitmap, bitops, plain old C

    When I first started thinking about these a few months ago,
    I intended to make both the mask and cpumask/nodemask level
    widely usable.  Now I don't think that's a good idea.  Others
    only need two levels:

        cpumask, nodemask, ...
        bitmap, bitops, plain old C

    The 'mask.h' stuff now exists only to provide a common implementation
    basis for the named mask types.  Perhaps I should rename 'mask.h'
    to something such as 'mask_innards.h' ... ;).

    Notice the comment in mask.h, after the lengthy explanation of
    bitmap, bitops, mask and cpumask/nodemask:

        Summary:
            Don't use mask.h directly - use cpumask.h and nodemask.h.

So, to make a long story short, the "unfriendly" names MASK_ALL1
fit their use.  The solution to the problem of remembering what
they mean is ... don't use them ;).

What am I missing?  What itch is not yet being scratched?

 ... hmmm ... "mask_innards.h" ... I rather like that.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
