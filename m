Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTHaO7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTHaO7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:59:11 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54992
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261885AbTHaO7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:59:09 -0400
Date: Sun, 31 Aug 2003 16:59:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
Message-ID: <20030831145932.GU24409@dualathlon.random>
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva> <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva> <Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva> <20030830231904.GL24409@dualathlon.random> <1062339003.10208.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062339003.10208.1.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 03:10:04PM +0100, Alan Cox wrote:
> On Sul, 2003-08-31 at 00:19, Andrea Arcangeli wrote:
> > I've an algorithm that will work, and that will provide very good
> > guarantees to kill the "best" task to make the machine usable again,
> > with the needed protection against the security DoSes, but it's in
> > no-way similar to the current oom killer.
> 
> And -ac has trivial code so you can avoid OOM killing every happening,
> which is pretty much essential for big servers. Perhaps merging that
> as well would be a good idea.

the reservation that you've to do can generate a less optimal
utilization of ram (some buggy app can also fail with it), but I agree
it's a nice feature to be able to return -ENOMEM out of malloc (for
desktops too), instead of killing the task.

However you have the exact same oom deadlocks problem with all non
userspace allocations, like a select, select will deadlock the box in
-ac if you're out of lowmemory, no matter of the non-overcommit
behaviour, same goes for mlock.

And I don't see how you can avoid oom killing to ever happen if the apps
recurse on the stack and growsdown some hundred megs. In such case
you've to oom kill, since there's no synchronous failure path during the
stack growsdown walk.

this of course doesn't change the fact that providing the non overcommit
behaviour (optional), sounds a very good idea, I'm all for it.

I just don't think it solves or hides the other issues, it seems
completely orthogonal to me, because you can still run oom during stack
growsdown.

Andrea
