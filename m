Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbTDEUCF (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 15:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTDEUCF (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 15:02:05 -0500
Received: from [12.47.58.55] ([12.47.58.55]:26761 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262641AbTDEUCE (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 15:02:04 -0500
Date: Sat, 5 Apr 2003 12:14:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030405121432.20659d8c.akpm@digeo.com>
In-Reply-To: <20030405190153.GF1326@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com>
	<12880000.1049508832@flay>
	<20030405024414.GP16293@dualathlon.random>
	<20030404192401.03292293.akpm@digeo.com>
	<20030405040614.66511e1e.akpm@digeo.com>
	<20030405163003.GD1326@dualathlon.random>
	<20030405190153.GF1326@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 20:13:27.0103 (UTC) FILETIME=[D16A04F0:01C2FBAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Sat, Apr 05, 2003 at 06:30:03PM +0200, Andrea Arcangeli wrote:
> > On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> > > The -aa VM failed in this test.
> > > 
> > > 	__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > 	VM: killing process rmap-test
> > 
> > I'll work on it. Many thanks. I wonder if it could be related to the
> > mixture of the access bit with the overcomplexity of the algorithm that
> > makes the passes over so many vmas useless. Certainly this workload
> > isn't common. I guess what I will try to do first is to simply ignore
> > the accessed bitflag after half of the passes failed. What do you think?

Yes, I agree.  If we're getting close to OOM, who cares about accuracy of
page replacement decisions?

> unfortunately I can't reproduce. Booted with mem=256m on a 4-way xeon 2.5ghz:

I only saw it the once.  I'd hit ^C on the test and noticed the message on
the console some 5-10 seconds later.  It may have been from before the ^C
though.  So it _might_ be related to the exit path tearing down pagetables
and setting tons of dirty bits.

> Or maybe it's ext3 related

Conceivably.  It wouldn't be the first one.  But all the pages were mapped to
disk, so the writepage path is really the same as ext2 in that case.


