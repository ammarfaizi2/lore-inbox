Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270846AbTGVNt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270833AbTGVNqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:46:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25984
	"EHLO x30.random") by vger.kernel.org with ESMTP id S270777AbTGVNpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:45:39 -0400
Date: Tue, 22 Jul 2003 09:59:57 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030722135957.GA1961@x30.linuxsymposium.org>
References: <20030717102857.GA1855@dualathlon.random> <200307180024.17523.m.c.p@wolk-project.de> <20030717225002.GY1855@dualathlon.random> <200307221427.01519.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307221427.01519.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 03:34:16PM +0200, Marc-Christian Petersen wrote:
> On Friday 18 July 2003 00:50, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > Can you try to change include/linux/blkdev.h like this:
> > -#define MAX_QUEUE_SECTORS (4 << (20 - 9)) /* 4 mbytes when full sized */
> > +#define MAX_QUEUE_SECTORS (16 << (20 - 9)) /* 4 mbytes when full sized */
> > This will raise the queue from 4 to 16M. That is the first(/only) thing
> > that can explain a drop in performnace while doing contigous I/O.
> > However I didn't expect it to make a difference, or at least not so
> > relevant.
> > If this doesn't help at all, it might not be an elevator/blkdev thing.
> > At least on my machines the contigous I/O still at the same speed.
> well, it doesn't help at all. I/O gets more worse with that change. (8mb/s 
> less). How can this happen? *wondering*
> 
> > You also where the only one reporting a loss of performance with
> > elevator-lowlatency, it could be still the same problem that you've
> > seen at that time.
> The only one? Surely not. Also Con tested your elevator-lowlatency and we both 
> saw performance degration :)

performance degradation when? note that we're only talking about
contigous I/O here, not contest. I can't measure any performance
degradation during contigous I/O and if something it could be explained
by the now shorter queue, but you tried enlarging it and it went even
slower (this was good btw, confirming a larger queue was completely
worthless and it only hurts the VM without providing any I/O bandwidth
pipelining benefit). The elevator-lowlatency should have no other effect
other than a shorter queue during pure contigous I/O.

> > can you try with data=writeback (or ext2) or hdparm -W1 and see if you
> > can still see the same delta between the two kernels? (careful with -W1
> > as it invalidates journaling)
> Yes, I'll do it later this day.

please try plain ext2, this sounds like some fs effect of some sort. The
fs must throttle on the shorter queue or seek differently somehow.

> Sorry for my late reply. I've been very busy.

No problem ;)

Andrea
