Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbULPFTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbULPFTc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 00:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbULPFTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 00:19:32 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40771 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261833AbULPFT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 00:19:29 -0500
Date: Thu, 16 Dec 2004 05:18:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       Dave Airlie <airlied@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
In-Reply-To: <20041215234141.GA9268@kroah.com>
Message-ID: <Pine.LNX.4.44.0412160455520.4496-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, Greg KH wrote:
> On Wed, Dec 15, 2004 at 11:48:26PM +0100, Andrea Arcangeli wrote:
> > On Wed, Dec 15, 2004 at 08:03:43PM +0100, Andrea Arcangeli wrote:
> > > +			if (page->mapping)
> > > +				page_remove_rmap(page);
> > 
> > This had to be page_mapping, since I believe the page->mapping can go
> > away with the truncate while the page is still being mapped.

Actually, the patch tests page_mapped(page) not page_mapping(page).

And is correct (though weak) to do so, in the context of Andrea's
other changes (which I intentionally omitted when merging anon_vma,
yes - but let's concentrate on Greg's crash for now, and leave the
flames about that merge until dessert).

I'm afraid it is trivial that that hunk alone will avoid the problem,
just as simply removing the page_remove_rmap's BUG_ON would.   But
neither sheds any light on what is going on here.

Something is happening that we don't expect.  I say "we" - or do you
understand it, Andrea?  We need to understand it before deciding how
to handle it, perhaps at the mm end or perhaps at the DRM end.

> No oops with this patch or odd messages in the syslog!  It works fine
> for me, thanks a lot.
> 
> I'll let the mm developers battle it out to determine if this is a good
> fix or not :)

Bug avoidance rather than fix, I'm afraid.  Once we understand what's
going on, such avoidance may be the right course of action; but not yet.

Hugh

