Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUCPPQa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUCPPNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:13:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53419 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262691AbUCPPKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:10:08 -0500
Date: Tue, 16 Mar 2004 16:10:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: The verdict on the future of suspending to disk?
Message-ID: <20040316151003.GA24837@atrey.karlin.mff.cuni.cz>
References: <1079408330.3403.5.camel@calvin.wpcb.org.au> <20040316113717.GB2282@elf.ucw.cz> <20040316121524.GI2175@elf.ucw.cz> <opr4yiu1ar4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr4yiu1ar4evsfm@smtp.pacific.net.th>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Without reliability and being able to suspend at any load
> (when the batteries/UPS go flat)  software suspend is all
> but useless.  What for suspend if it does not resume and
> eats work left in RAM?

It should suspend at any load, but AFAICR those hooks are not for
that. They are neccessary for "crashed nfs server case", which kill
-SIGSTOP does not handle. (IMNSHO thats bug in -SIGSTOP and pretty
orthogonal to swsusp).

> Common users objectives for a software suspend mechanism are:
> 
> 1. To not impair system reliability. It must run without crash
>       and reboots between kernel upgrades.
>       100 cycles in 2 hours is a quickie
>       1000 cycles in a day are a short test
>       xxxx cycles in a month are a life test

There's even more important goal. I'd call it

O. Do not impair system reliablity *when swsusp is not in use*.
   Do not make further development of system harder by putting too
   much hooks into other code.

> 2. To handle any cpu and io load
> 	10+ concurrent unixbenchs, 4 concurrent dd loops, nfs and ssh
>       cross accesses, Load avg 20-40, cs of 100,000, 20MB io
>       sustained for days at a cycle a minute... No freezing failures
> 
> 3. To support the spectrum of user requirements wrt functionality
> 	for portable, desktop, and embedded apps
> 
> 4. To handle driver suspend and resume at any time. Apps should not
>       have to be terminated.
> 
> Swsusp2 meets 1. and 2. and many of 3. Swsusp2 is also modular and can be
> expanded to add things like NFS suspend/resume.
> 
> 1. and 2. require a sophisticated freezing mechanism and kernel level
> "intrusion". Most of this "intrusion" is simetrical and easily understood.
> This is what UGLY macros are for.

I still do not believe 1. and 2. *require* that ugly hooks (as long as
your NFS server is up).

Now, what if NFS server is down? I'd not handle it for now; if your
harddrive stops working you can't suspend, too, and NFS is too similar
to disk.

> 3. Can be argued about: Compression or no compression, reboot functionality
>    for multi boot or not, Escape or no Escape (I need it every day) -
>    If you ever would dare to suspend you would want an Escape function too! 
>    :-)

For first merge, I'd like to have simplest possible version, that's no
compression, powerdown at the end, no escape.

> 4. Requires PM fixes and driver level intrusion, can be worked around by
>    killing apps and unloading drivers. Eventually this has to be fixed.

Yes. People are working on that.
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
