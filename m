Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWBVQZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWBVQZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWBVQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:25:51 -0500
Received: from thunk.org ([69.25.196.29]:62145 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751370AbWBVQZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:25:51 -0500
Date: Wed, 22 Feb 2006 11:25:34 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi,
       gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222162533.GA30316@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi,
	gregkh@suse.de, bunk@stusta.de, rml@novell.com,
	linux-kernel@vger.kernel.org, johnstul@us.ibm.com
References: <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222154820.GJ16648@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 07:48:21AM -0800, Joel Becker wrote:
> On Wed, Feb 22, 2006 at 06:21:58AM -0500, Theodore Ts'o wrote:
> > with all of the kernel modules I need compiled into the kernel.  I
> > still have no idea why mptscsi fails to detect SCSI disks when loaded
> > as a module via initrd on various bits of IBM hardware (including the
> > e326 and ls-20 blade), but works fine when compiled directly into the
> > kernel....
> 
> Ted,
> 	Do you mean that you are using a distro (eg, RHEL4 or something)
> with a mainline kernel?  We've seen something similar, and what we've
> determined is happening is that insmod is returning before the module is
> done initializing.  It's not that mptscsi fails to detect the disks.
> Rather, it's still in the detection process when the boot process tries
> to mount /.  So there's no / yet, and the thing hangs.  

Yep, that's exactly what I'm doing; RHEL4U2 with a 2.6.14 or 2.6.15
kernel.  Thanks for the tip, that should help me investigate further!

> In the case we
> see, it's some interaction between the RHEL4/SLES9 version of
> module-init-tools and the latest version of the kernel.  Our first
> attempt at fixing it was to change the linuxrc to sleep between each
> insmod.  This works, but only if the modules load and initialize
> themsleves fast enough.  Get a FC card in there, and it just doesn't
> work.  So we've taken to compiling the modules in-kernel.

Sounds like this is another of example of system support programs
(insmod in this case) breaking with modern kernels.  Hopefully now
that Linus has laid down the law about how breaking userspace is
uncool, people will agree that it's a bug.  (That is unless Red Hat
made some kind of incompatible change and it's Red Hat's fault, but I
kinda doubt that.)  Anyway, I'll look into this some more and see why
you can't use a mainline kernel with RHEL4, at least not in this
configuration.

						- Ted
