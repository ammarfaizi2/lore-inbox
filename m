Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUEYTms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUEYTms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUEYTlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:41:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54671
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265081AbUEYTlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:41:20 -0400
Date: Tue, 25 May 2004 21:41:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-ID: <20040525194115.GE29378@dualathlon.random>
References: <20040524124834.GB29378@dualathlon.random> <Pine.LNX.4.44.0405251514490.26157-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405251514490.26157-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 03:15:14PM -0400, Rik van Riel wrote:
> On Mon, 24 May 2004, Andrea Arcangeli wrote:
> > On Mon, May 24, 2004 at 10:25:22AM +0200, Ingo Molnar wrote:
> > > on how quickly 'x86 with more than 4GB of RAM' and 
> > 
> > s/4GB/32GB/
> > 
> > my usual x86 test box has 48G of ram (though to keep an huge margin of
> > safety we assume 32G is the very safe limit).
> 
> Just how many 3GB sized processes can you run on that
> system, if each of them have a hundred or so VMAs ?

with 400m of normal zone we can allocate 5000000 vmas, if each task uses
100 of them that's around 50000 processes. The 3G size doesn't matter.

I think you meant each task using some _dozen_thousand_ of vmas (not
hundreds), that's what actually happens with 32k large vmas spread over
2G of shared memory on some database (assuming no merging, with merging
it goes down to the few thousands), but remap_file_pages has been
designed exactly to avoid allocating several thousands of VMA per task,
no? So it's just 1 vma per task (plus a few more vmas for the binary
shared libs and anonymous memory).

Clearly by opening enough files or enough network sockets or enough vmas
or similar, you can still run out of normal zone, even on a 2G system,
but this is not the point or you would be shipping 4:4 on the 2G systems
too, no? We're not trying to make it impossible to run out of zone
normal, even 4:4 can't make that impossible to happen on >4G boxes.
