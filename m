Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTGXO2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 10:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271330AbTGXO2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 10:28:11 -0400
Received: from dhcp900.linuxsymposium.org ([209.151.11.142]:40064 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S261825AbTGXO2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 10:28:09 -0400
Subject: Re: 2.4.22pre6aa1
From: Chris Mason <mason@suse.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>
In-Reply-To: <200307241356.57793.m.c.p@wolk-project.de>
References: <20030717102857.GA1855@dualathlon.random>
	 <200307221427.01519.m.c.p@wolk-project.de>
	 <20030722135957.GA1961@x30.linuxsymposium.org>
	 <200307241356.57793.m.c.p@wolk-project.de>
Content-Type: text/plain
Organization: 
Message-Id: <1059056049.2575.17.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Jul 2003 10:14:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-24 at 08:27, Marc-Christian Petersen wrote:
> On Tuesday 22 July 2003 15:59, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > performance degradation when? note that we're only talking about
> > contigous I/O here, not contest. I can't measure any performance
> > degradation during contigous I/O and if something it could be explained
> > by the now shorter queue, but you tried enlarging it and it went even
> > slower (this was good btw, confirming a larger queue was completely
> > worthless and it only hurts the VM without providing any I/O bandwidth
> > pipelining benefit). The elevator-lowlatency should have no other effect
> > other than a shorter queue during pure contigous I/O.
> Well, contigous I/O isn't a big problem, though I saw performance degradation 
> in contigous I/O. The problem is, that I still see mouse stops while heavy 
> I/O, that I still see keyboard stops while heavy I/O, X is dog slow while 
> heavy I/O (renicing X to -20 doesn't really help). I really miss the 2.4.18 
> time where this wasn't a problem at all!
> Contest was not the reason. An easy reproducable scenario is:
> 
>  dd if=/dev/zero of=/home/largefile bs=16384 count=131072
> 
> This will kill your mouse, keyboard and X. The only "workaround" not to see 
> mouse stops, keyboard stops and X dogstyle was decreasing nr_requests from 
> 128 to 4. Anything higher resulted in pauses (e.g. 8 for nr_requests).
> Maybe SCSI behaves totally different, dunno. ATM I don't have SCSI around to 
> test it, only IDE (ATA100/ATA133).
 
Ok, there's something fundamental we're missing here, the IDE boxes I
test on don't show this ;-)  Can you setup a serial console and capture
sysrq-t during the pause?  Or better yet setup kgdb.  

What kind of keyboard/mouse do you have?  

I'll give you an updated q->full patch on Monday, including the
__get_request_wait latency stats.

-chris


