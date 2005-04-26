Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVDZOXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVDZOXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVDZOXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:23:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:25030 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261558AbVDZOW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:22:57 -0400
Date: Tue, 26 Apr 2005 16:22:52 +0200
From: Andi Kleen <ak@suse.de>
To: Patrick McHardy <kaber@trash.net>
Cc: Andi Kleen <ak@suse.de>, Ed Tomlinson <tomlins@cam.org>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
Message-ID: <20050426142252.GJ5098@wotan.suse.de>
References: <200504240008.35435.kernel-stuff@comcast.net> <1114332119.916.1.camel@localhost.localdomain> <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net> <20050425153541.GC16828@wotan.suse.de> <426E3C6F.6010001@trash.net> <20050426135312.GI5098@wotan.suse.de> <426E48C0.9090503@trash.net> <426E4DD2.8060808@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426E4DD2.8060808@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 04:18:58PM +0200, Patrick McHardy wrote:
> Patrick McHardy wrote:
> >Andi Kleen wrote:
> >
> >>Hmm, thats hard to believe. And are you sure the NMI watchdog
> >>did not trigger? (e.g. did you run it with serial or netconsole)?
> >
> >I ran it with netconsole, but nothing was received. I'm going to retry
> >with and without the patch once more to make sure.
> 
> I tried starting uml with and without the patch, five times each.
> Without the patch it worked fine every time, with the patch it
> instantly rebooted every time. Nothing was logged on netconsole.
> Perhaps also interesting is that if I revert all patches after
> this change up to HEAD, it doesn't always instantly reboot, but
> sometimes just hangs. When using HEAD, it rebooted each time so far.

Ok thanks for the information. I will stare a bit at the patch.

It is very mysterious though. Even if the patch was somehow wrong
the worst thing that could happen is that you end up with interrupts
off when you shouldnt, and the NMI watchdog is very good 
at catching that.

Hmm actually - on some systems I broke the NMI watchdog. Can you
check your dmesg to see if check_nmi_watchdog doesnt report it 
as stuck? If yes please put a return on top of check_nmi_watchdog
that should fix it. You can verify it works by looking at the
per CPU NMI counters in /proc/interrupts. An nmi watchdog
backtrace would be nice to see.

-Andi
