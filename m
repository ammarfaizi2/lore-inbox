Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263420AbVCEAhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbVCEAhD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbVCEAGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:06:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48586 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263111AbVCDWHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:07:41 -0500
Date: Fri, 4 Mar 2005 23:07:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, mjg59@scrf.ucam.org, hare@suse.de,
       "Barry K. Nathan" <barryn@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: allow resume from initramfs
Message-ID: <20050304220709.GE2385@elf.ucw.cz>
References: <20050304101631.GA1824@elf.ucw.cz> <20050304030410.3bc5d4dc.akpm@osdl.org> <20050304175038.GE9796@ip68-4-98-123.oc.oc.cox.net> <1109971327.3772.280.camel@desktop.cunningham.myip.net.au> <20050304214329.GD2385@elf.ucw.cz> <1109973035.3772.291.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109973035.3772.291.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > You guys are reinventing the wheel a lot at the moment and I'm in the
> > > middle of doing it for x86_64 lowlevel code :> Can we see if we can work
> > > a little more closely - perhaps we can get some shared code going that
> > > will allow us to handle these issues without stepping on each others'
> > > feet? In particular, shared code for
> > > 
> > > - initramfs and initrd support
> > 
> > Its actually done, and it was few strategically placed lines of code
> > (like 20 lines). I do not think it can be meaningfully shared.
> 
> Mmm. But if we're both putting hooks in the same places...

There are very little hooks... But we may want to make sure we have
same userland interface. swsusp uses "echo 3:5 > /sys/power/resume" to
trigger resume from device major 3 minor 5.

> > > - lowlevel suspend & resume
> > 
> > This makes very good sense to share. We have i386, x86-64 and ppc
> > versions. They simply walk list of pbe's; that should be simple enough
> > to be usable for suspend2, too....
> 
> The CPU save and restore, yes. But I use a different format for
> recording the image metadata (I use bitmaps to record the locations of
> pages). Perhaps I should hasten to mention the bitmaps are discontiguous
> - single pages connected by a kmalloc'd list. The copyback itself will
> need to stay distinct.

Hmm, bitmaps? Okay, then low-level code needs to stay separate. (And
thats bad, I wanted that one to be shared most).
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
