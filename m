Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUJRTSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUJRTSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUJRTQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:16:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267555AbUJRTON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:14:13 -0400
Date: Mon, 18 Oct 2004 20:14:12 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       "Martin K. Petersen" <mkp@wildopensource.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] General purpose zeroed page slab
Message-ID: <20041018191412.GJ16153@parcelfarce.linux.theplanet.co.uk>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0236348B@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0236348B@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 12:03:04PM -0700, Luck, Tony wrote:
> >It's probably worth doing this with a static cachep in slab.c and only
> >exposing a get_zeroed_page() / free_zeroed_page() interface, with the
> >latter doing the memset to 0.  I disagree with Andi over the dumbness
> >of zeroing the whole page.  That makes it cache-hot, which is what you
> >want from a page you allocate from slab.
> 
> We started this discussion with the plan of using this interface to
> allocate/free page tables at all levels in the page table hierarchy
> (rather than maintain a special purpose "quicklist" allocator for each
> level).  This is a somewhat specialized usage in that we know that we
> have a completely zeroed page when we free ... so we really don't
> want the overhead of zeroing it again.

Ah, I'm not a VM weenie, so I didn't know this was guaranteed ;-)

> There is also somewhat limited
> benefit to the cache hotness argument here as most page tables (especially
> higher-order ones) are used very sparsely.
> 
> That said, the idea to expose this slab only through a specific API
> should calm fears about accidental mis-use (with people freeing a page
> that isn't all zeroes).

So alloc_zeroed_page(), free_zeroed_page(), zero_and_free_page()
interfaces with a CONFIG option to check that the page passed to
free_zeroed_page() is already zero?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
