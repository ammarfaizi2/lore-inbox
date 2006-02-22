Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWBVLWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWBVLWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWBVLWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:22:13 -0500
Received: from thunk.org ([69.25.196.29]:24509 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750702AbWBVLWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:22:12 -0500
Date: Wed, 22 Feb 2006 06:21:58 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222112158.GB26268@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi,
	gregkh@suse.de, bunk@stusta.de, rml@novell.com,
	linux-kernel@vger.kernel.org, johnstul@us.ibm.com
References: <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 05:06:48PM -0800, Linus Torvalds wrote:
> 
> To some degree, /initrd was supposed to do things like that, and in 
> theory, it still could. However, realistically, 99% of any /initrd is more 
> about the distribution than the kernel, so right now we have to count 
> /initrd as a distribution thing, not a kernel thing.

... and if we're truly going to be pouring more and more complexity
into initrd (such as userspace swsusp), then (a) we probably should
make it more of a kernel-specific thing, and not a distro-specific
thing, since without that you can be pretty much guaranteed that more
and more people will be using and testing swsusp2, and not uswsusp,
and (b) we need to add _way_ better debugging provisions so that if
something dies in early boot, you don't go pulling out your hair
trying to figure out what went wrong, and having to spend a good 20
minutes or so between each try-to-fix the initrd, watch the boot fail,
reboot into a working setup, cursing Red Hat's nash, modifying the
initrd, and trying again.

Usually I break the loop by giving up, and ripping out whatever kernel
feature requires initrd, such as dm, and installing on hard partitions
with all of the kernel modules I need compiled into the kernel.  I
still have no idea why mptscsi fails to detect SCSI disks when loaded
as a module via initrd on various bits of IBM hardware (including the
e326 and ls-20 blade), but works fine when compiled directly into the
kernel....

If we want more and more stuff to be poured into initrd, it's got to
be made easier to debug and consistent across distributions, such that
more people can test initrd configurations, and flush out the bugs,
never mind the question of programs like udev randomly breaking
between kernel releases.  Maybe it's time to consider moving all of
that into the kernel source; if they wanted to be treated as part of
the kernel, then let them liteally become part of the kernel from a
source code and release management perspective.

						- Ted
