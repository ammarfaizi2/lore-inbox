Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUJRSpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUJRSpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUJRSnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:43:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13219 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267254AbUJRSmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:42:12 -0400
Date: Mon, 18 Oct 2004 19:42:10 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: "Martin K. Petersen" <mkp@wildopensource.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
Message-ID: <20041018184210.GI16153@parcelfarce.linux.theplanet.co.uk>
References: <yq1oej5s0po.fsf@wilson.mkp.net> <20041014180427.GA7973@wotan.suse.de> <yq1ekjvrjd6.fsf@wilson.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ekjvrjd6.fsf@wilson.mkp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 02:06:45PM -0400, Martin K. Petersen wrote:
> Andi> The means every user has to memset it to zero before free.  Add
> Andi> a comment for that at least.
> 
> Andi> Also that's pretty dumb. How about keeping track how much of the
> Andi> page got non zeroed (e.g. by using a few free words in struct
> Andi> page for a coarse grained dirty bitmap)
> 
> Andi> Then you could memset on free only the parts that got actually
> Andi> changed, and never waste cache lines for anything else.
> 
> Ayup.  I'll ponder this a bit.  For now I think I'm going to leave the
> page table cache stuff as is and make the general purpose slab a
> separate project.  It'll be easy to switch the page tables over later.

It's probably worth doing this with a static cachep in slab.c and only
exposing a get_zeroed_page() / free_zeroed_page() interface, with the
latter doing the memset to 0.  I disagree with Andi over the dumbness
of zeroing the whole page.  That makes it cache-hot, which is what you
want from a page you allocate from slab.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
