Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUCZKWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264001AbUCZKWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:22:20 -0500
Received: from gprs214-227.eurotel.cz ([160.218.214.227]:43136 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263995AbUCZKWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:22:18 -0500
Date: Fri, 26 Mar 2004 11:22:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Message-ID: <20040326102206.GD388@elf.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz> <200403250857.08920.matthias.wieser@hiasl.net> <1080247142.6679.3.camel@calvin.wpcb.org.au> <20040325222745.GE2179@elf.ucw.cz> <opr5gf93ik4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr5gf93ik4evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>upgraded my laptop's hard drive, and found I wasn't getting the
> >>performance improvements in suspending I expected. It turns out that the
> >>CPU is now the limiting factor. Because I had the /proc interface, I
> >>could easily adjust the debug settings to show me throughput and then
> >>try a couple of suspend cycles with compression enabled and with it
> >>disabled. Without the /proc interface, I would have had to have
> >>recompiled the kernel to switch settings. (I didn't try gzip because I
> >>knew it wasn't going to be a contender for me).
> >
> 
> /proc is needed a lot
> 
> - enable escape
> - select reboot mode
> 	which is essential for multibooting. We use it all the time to
> 	boot various installations of Linux

Perhaps reboot() can have parameter for that.

> - select compression none, lzw or gzip
> 	none is used when disk faster that cpu-limited lzf
> 	lzf is used when cpu is fast enough to compress to disk
> 		Fast CPU can do 100MB/s+ to 50MB/s drives
> 	gzip is used by some who care about image size eg flash users

If you are doing "resume=swap:<something>", why not "resume=lzw-swap:something"?

> - keep image mode (when compiled in)
> 	which is used for embedded kiosks for example
> 		Boeing requested and uses it

Boeing can keep external patch, this seems like pretty dangerous
feature for joe user. And it should not be selected at /proc, but as
command line parameter.

> - default console level
> 	Controls console messages or nice display
> - access debug info header
> 	This is needed to analyze swsusp2 performance
> - access resume parameters
> 	Saves a reboot when changing parameters
> - activate
> 	swsusp2 activation independent of apci, apm

Should not be needed. There's reboot() syscall to do that.

> - last result
> 	info on why swsusp2 did not suspend such as out of
> 	memory or swap or freezing failure

That should be return value of reboot() syscall.

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
