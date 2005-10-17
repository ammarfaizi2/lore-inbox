Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVJQPhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVJQPhf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVJQPhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:37:35 -0400
Received: from serv01.siteground.net ([70.85.91.68]:47249 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751397AbVJQPhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:37:34 -0400
Date: Mon, 17 Oct 2005 08:37:24 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017153724.GA8684@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain> <20051017025007.35ae8d0e.akpm@osdl.org> <200510171153.56063.ak@suse.de> <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 08:27:40AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 17 Oct 2005, Andi Kleen wrote:
> > 
> > The patch is actually not quite correct - in theory node 0 could be too small 
> > to contain the full swiotlb bounce buffers.
> 
> Is node 0 guaranteed to be all low-memory? What if it allocates stuff at 
> the end of memory on NODE(0)?
> 
> Anyway, it sounds like "alloc_bootmem_low_pages()" is seriously buggered 
> if it allocates non-low pages, if only because of its name...
> 
> > The real fix would be to get rid of the pgdata lists and just walk the 
> > node_online_map on bootmem.c. The memory hotplug guys have
> > a patch pending for this.
> 
> Argh. Which one should I pick? The NODE(0) one looks simpler, but is it 
> sufficient for now in practice (with the real one going into 2.6.14+)?

That's the reason I made a small patch.  It does work on the boxes we use.
But I like Yasunori-san's patch.  Mine is just a chewing gum fix.

Thanks,
Kiran 
