Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbULIRET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbULIRET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbULIRES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:04:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:52390 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261469AbULIRED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:04:03 -0500
Date: Thu, 9 Dec 2004 09:03:53 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
In-Reply-To: <41B8060A.4050402@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0412090858420.10400@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
 <41B8060A.4050402@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004, Nick Piggin wrote:

> > For more than 8 cpus the page fault rate increases by orders
> > of magnitude. For more than 64 cpus the improvement in performace
> > is 10 times better.
>
> Those numbers are pretty impressive. I thought you'd said with earlier
> patches that performance was about doubled from 8 to 512 CPUS. Did I
> remember correctly? If so, where is the improvement coming from? The
> per-thread RSS I guess?

Right. The per-thread RSS seems to have made a big difference for high CPU
counts. Also I was conservative in the estimates in earlier post since I
did not have the numbers for the very high cpu counts.

> On another note, these patches are basically only helpful to new
> anonymous page faults. I guess this is the main thing you are concerned
> about at the moment, but I wonder if you would see improvements with
> my patch to remove the ptl from the other types of faults as well?

I can try that but I am frankly a bit sceptical since the ptl protects
many other variables. It may be more efficient to have the ptl in these
cases than doing the atomic ops all over the place. Do you have any number
you could post? I believe I send you a copy of the code that I use for
performance tests last week or so,

> The downside of my patch - well the main downsides - compared to yours
> are its intrusiveness, and the extra cost involved in copy_page_range
> which yours appears not to require.

Is the patch known to be okay for ia64? I can try to see how it
does.

> As I've said earlier though, I wouldn't mind your patches going in. At
> least they should probably get into -mm soon, when Andrew has time (and
> after the 4level patches are sorted out). That wouldn't stop my patch
> (possibly) being merged some time after that if and when it was found
> worthy...

I'd certainly be willing to poke around and see how beneficial this is. If
it turns out to accellerate other functionality of the vm then you
have my full support.
