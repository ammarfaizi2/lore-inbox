Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbTDEVzD (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 16:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTDEVzD (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 16:55:03 -0500
Received: from mail-3.tiscali.it ([195.130.225.149]:47746 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S262682AbTDEVzC (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 16:55:02 -0500
Date: Sun, 6 Apr 2003 00:06:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030405220621.GG1326@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random> <20030405132406.437b27d7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405132406.437b27d7.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 01:24:06PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> > > Andrew Morton <akpm@digeo.com> wrote:
> > > >
> > > > Nobody has written an "exploit" for this yet, but it's there.
> > > 
> > > Here we go.  The test app is called `rmap-test'.  It is in ext3 CVS.  See
> > > 
> > > 	http://www.zip.com.au/~akpm/linux/ext3/
> > > 
> > > It sets up N MAP_SHARED VMA's and N tasks touching them in various access
> > > patterns.
> > 
> > I'm not questioning during paging rmap is more efficient than objrmap,
> > but your argument about rmap having lower complexity of objrmap and that
> > rmap is needed is wrong. The fact is that with your 100 mappings per
> > each of the 100 tasks case, both algorithms works in O(N) where N is
> > the number of the pagetables mapping the page.
> 
> Nope.  To unmap a page, full rmap has to scan 100 pte_chain slots, which is 3
> cachelines worth.  objrmap has to scan 10,000 vma's, 9,900 of which do not map
> that page at all.

I see what you mean, you're right. That's because all the 10,000 vma
belongs to the same inode.

Andrea
