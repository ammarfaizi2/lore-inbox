Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVBUBwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVBUBwt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 20:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVBUBws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 20:52:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54223 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261380AbVBUBw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 20:52:29 -0500
Date: Sun, 20 Feb 2005 17:50:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, raybry@sgi.com, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
Message-Id: <20050220175019.0e588466.pj@sgi.com>
In-Reply-To: <20050220223510.GB14486@wotan.suse.de>
References: <20050215121404.GB25815@muc.de>
	<421241A2.8040407@sgi.com>
	<20050215214831.GC7345@wotan.suse.de>
	<4212C1A9.1050903@sgi.com>
	<20050217235437.GA31591@wotan.suse.de>
	<4215A992.80400@sgi.com>
	<20050218130232.GB13953@wotan.suse.de>
	<42168FF0.30700@sgi.com>
	<20050220214922.GA14486@wotan.suse.de>
	<20050220143023.3d64252b.pj@sgi.com>
	<20050220223510.GB14486@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Give the shared libraries and any other files a suitable policy
> (by mapping them and applying mbind) 

Ah - I think you've said this before, and I'm being a bit retarded.

You're saying that one could horse around with the physical placement of
existing files mapped into another tasks space by mapping them into ones
own space and using mbind, (once mbind is hooked up to page migration,
to quote one of your earlier posts ;).  Ok.

How well does this work with a mapped file if the pages of that file
have been placed (allocated on nodes) using some intricate first-touch
pattern that is only encoded in some inscrutable initialization code of
the application, and that is heavily fragmented, with few contiguous
pages on the same node?

It seems to me that you can't migrate such regions efficiently using the
above explicit mbind'ing -- it could require a vma per page in the
limit.  And you can't migrate such regions using a migrate_pages() for
all anonymous pages in a tasks space, because these aren't anon pages.

Do you have in mind being able to tag such mapped files with an
attribute that causes their pages to be migrated along with the
anon pages on the migrate_pages() call?  That might work ...


> > How would you recommend that the batch manager move that job to the
> > nodes that can run it?   ...
> 
> You have to walk to full node mapping for each array, but
> even with hundreds of nodes that should not be that costly

I presume if you knew that the job only had pages on certain nodes,
perhaps due to aggressive use of cpusets, that you would only have to
walk those nodes, right?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
