Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVB1Tfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVB1Tfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVB1Tfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:35:38 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:17580 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261523AbVB1Tfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:35:30 -0500
Date: Mon, 28 Feb 2005 19:35:30 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy + prezeroing
In-Reply-To: <1109607127.6921.14.camel@localhost>
Message-ID: <Pine.LNX.4.58.0502281930490.29288@skynet>
References: <20050227134219.B4346ECE4@skynet.csn.ul.ie> <1109607127.6921.14.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005, Dave Hansen wrote:

> On Sun, 2005-02-27 at 13:42 +0000, Mel Gorman wrote:
> > In the two following emails are the latest version of the placement policy
> > for the binary buddy allocator to reduce fragmentation and the prezeroing
> > patch. The changelogs are with the patches although the most significant change
> > to the placement policy is a fix for a bug in the usemap size calculation
> > (pointed out by Mike Kravetz).
> >
> > The placement policy is Even Better than previous versions and can allocate
> > over 100 2**10 blocks of pages under loads in excess of 30 so I still
> > consider it ready for inclusion to the mainline.
> ...
>
> This patch does some important things for memory hotplug: it explicitly
> marks the different types of kernel allocations, and it separates those
> different types in the allocator.  When it comes to memory hot-remove
> this is certainly something we were going to have to do anyway.  Plus, I
> believe there are already at least two prototype patches that do this.
>

I have read through Matt Tolentino's version at least and this version of
the placement policy should be an easier merge for hotplug. Particularly,
stuff from his patch like the removal of magic numbers (which I should
have done anyway) are present in this version of the placement policy
patch. I will also move how a MAX_ORDER-1 block of pages is removed from
the global list and put it in it's own inline function.

> Anything that makes future memory hotplug work easier is good in my
> book. :)
>

If there are any other changes that might make hotplug's life easier, I'm
sure someone will shout :)

-- 
Mel Gorman
