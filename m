Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTLEJgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 04:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTLEJgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 04:36:40 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:13011 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263448AbTLEJgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 04:36:38 -0500
Date: Fri, 5 Dec 2003 20:34:25 +1100
From: Nathan Scott <nathans@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       pinotj@club-internet.fr, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031205203425.B2091516@wobbly.melbourne.sgi.com>
References: <mnet1.1070562461.26292.pinotj@club-internet.fr> <Pine.LNX.4.58.0312041035530.6638@home.osdl.org> <Pine.LNX.4.58.0312041050050.6638@home.osdl.org> <20031204212110.GB567@frodo> <20031205071455.A19514@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031205071455.A19514@infradead.org>; from hch@infradead.org on Fri, Dec 05, 2003 at 07:14:55AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 07:14:55AM +0000, Christoph Hellwig wrote:
> On Fri, Dec 05, 2003 at 08:21:10AM +1100, Nathan Scott wrote:
> > Yeah, thats pretty silly stuff - and should be fairly easy to
> > fix by using a pagebuf flag to differentiate the two.  Will do.
> 
> IMHO a flags is wrong here.  Just maek pb_addr always a pointer and
> for the case it's the preallocated array make it point pb_page_array
> or something like that.  Then check whether pb_addr is pointing to the
> preallocated array.

You might be mixing up pb_pages and pb_addr there?  pb_addr is
always a pointer.  We need to distinguish whether it was slab
alloc'd or whether it points into page cache pages, so we know
whether to page_cache_release the pages or kfree the pointer
when we're done with the pagebuf.

The pb_page_array works just as you describe, with a prealloc'd
array of page pointers, and pb_pages either points to the array
of to a larger kmalloc'd array as necessary.

cheers.

-- 
Nathan
