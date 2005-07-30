Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbVG3Kan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbVG3Kan (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 06:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbVG3Kan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 06:30:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4251 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263040AbVG3Kaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 06:30:39 -0400
Date: Sat, 30 Jul 2005 12:30:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] S3 and sigwait (was Re: 2.6.13-rc3: swsusp works (TP 600X))
Message-ID: <20050730103034.GC1942@elf.ucw.cz>
References: <20050723003544.GC1988@elf.ucw.cz> <E1DyfYO-0006oI-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DyfYO-0006oI-00@skye.ra.phy.cam.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> One other glitch is that pdnsd (a nameserver caching daemon) has crashed
> >> when the system wakes up from swsusp.  It also happens when waking up
> >> from S3, which was working with 2.6.11.4 although not with 2.6.13-rc3.
> >> Many people have said mysql also does not suspend well.  Is their use of
> >> a named pipe or socket causing the problem?
> 
> > No idea, strace?
> 
> The upshot of stracing is in tthe Debian BTS <bugs.debian.org>
> #319572.  Paul Rombouts, an author of pdnsd, reproduced the strace
> crash and found the problem:
> 
> > Apparently strace causes sigwait to return EINTR, which is
> > inconsistent with the documentation I could find on sigwait.
> 
> Which is true.  The sigwait man entry (Debian 'etch') says:
>        The !sigwait! function never returns an error.
> 
> His patch (available in the BTS and included below) fixed the problem
> of strace or S3 sleep crashing pdnsd.

If you think it is a linux bug, can you produce small test case doing
just the sigwait, and post it on l-k with big title "sigwait() breaks
when straced, and on suspend"?

That way it is going to get some attetion, and you'll get either
documentation or kernel fixed.
								Pavel


-- 
teflon -- maybe it is a trademark, but it should not be.
