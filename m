Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270471AbTHBXyP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 19:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270473AbTHBXyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 19:54:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:53455 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270471AbTHBXyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 19:54:13 -0400
Date: Sat, 2 Aug 2003 16:42:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3
Message-Id: <20030802164205.5cc42edc.akpm@osdl.org>
In-Reply-To: <20030802223140.GA25501@outpost.ds9a.nl>
References: <20030802152202.7d5a6ad1.akpm@osdl.org>
	<20030802223140.GA25501@outpost.ds9a.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> wrote:
>
> On Sat, Aug 02, 2003 at 03:22:02PM -0700, Andrew Morton wrote:
> 
> > . I don't think anyone has reported on whether 2.6.0-test2-mm2 fixed any
> >   PS/2 or synaptics problems.  You are all very bad.
> 
> Will report 12 hours from now or so, I have synaptics problems currently.
> 
> > -selinux.patch
> (...)
> >  merged
> 
> Sure about this?

yes.

> > +4g-2.6.0-test2-mm2-A5.patch
> > 
> >  4G/4G split
> 
> Linus called this patch 'tasteless' - do you see this being merged?

Bolting 64G of memory onto a 32-bit CPU is tasteless too...

We already have a bucketload of highmem hacks in the kernel, and they are
not sufficient for some people.  We have several more (large) highmem hacks
being proposed.

It is fairly clear that a number of users will need more highmem hacks than
we currenly have.  I'd rather add one more big highmem hack than a whole
bunch more little ones.  And I'd rather that the big highmem hack be in the
base kernel, rather than having different versions floating about in
different vendor trees.

It seems that 4G+4G is the most viable patch at this stage.  Wider testing
will tell.

I rather wish that the patch had been available a year ago, so we would now
have less little highmem hacks in the tree.

wrt long-term kernel purity: one approach would be to not merge 4G+4G into
2.7 at all.  This keeps the long-term kernel codebase saner.  It assumes
that the monster 32-bit boxes will have been obsoleted by 64-bit machines
within 3-4 years and that it is acceptable to end-of-line those machines on
a 2.6-based kernel.  I think that's pretty safe.


The main concern is that I don't want to see vendor kernels madly diverging
from the public kernel right at the outset of the 2.6 series.

