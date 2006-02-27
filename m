Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWB0QYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWB0QYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 11:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWB0QYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 11:24:22 -0500
Received: from postage-due.permabit.com ([66.228.95.230]:10985 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S1751482AbWB0QYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 11:24:21 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 hangs, no information on console or serial port
References: <7yirr8hh0z.fsf@questionably-configured.permabit.com>
	<20060221152949.GA31273@kvack.org>
From: David Golombek <daveg@permabit.com>
Date: 27 Feb 2006 11:24:10 -0500
In-Reply-To: <20060221152949.GA31273@kvack.org>
Message-ID: <7yfym4lqhh.fsf@questionably-configured.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Feb 21, 2006 at 10:23:56AM -0500, David Golombek wrote:
> > I have a box running a modified Debian/woody system and 2.4.31.  It is
> > intermittently hanging such that:
> > 
> > * All logging to /var/log ceases.
> > * Machine is still pingable.
> > * Machine can be telneted to on time port, but no time is echoed.
> > * After attaching a console+keyboard, console would not unblank.
> > * Nothing responded when attaching a serial console.
> > * Machine does not respond to Ctrl-Alt-Del
> > * No DMI messages are logged.
> > * Hang is persistent until physical reboot.
> > 
> > This has happened 4 times, on 2 separate machines (under roughly
> > similar conditions).  Machines are up variable amounts of time before
> > crashing, between many weeks and less than 1 day.  Nothing unusual is
> > logged in /var/log/{deamon.log,kern.log,messages,syslog} prior the
> > hang, except that /var/log/messages includes the "TCP: Treason
> > uncloaked!" warnings that are fixed in 2.4.32.  No users were logged
> > on at the time of 3 of the 4 crashes, and no local user activity was
> > present at the time of the 4th.
> > 
> > The machines are Intel P4's with 2GB of memory
> > 
> > The machine is under relatively high load and has a custom userspace
> > nfs server running on it (which is potentially to blame, but we've
> > been unable to determine how).  The custom userspace nfs server and
> > tomcat4 are the primary applications running.
> > 
> > Any suggestions as to how we might debug this or possible causes would
> > be greatly appreciated.
>
> Benjamin LaHaise <bcrl@kvack.org> writes:
> Have you tried turning on the NMI watchdog (nmi_watchdog=1)?  It
> should be able to kick the machine out of the locked state, as these
> symptoms would hint at a spinlock deadlock with interrupts disabled.
> Also, try to reproduce on the latest 2.4.33pre.  That said, for an
> io intensive workload like you're running, 2.6 is much better,
> especially for systems using highmem.

After a week of intensive testing, we were finally able to reproduce
this hang.  Sadly, the nmi watchdog did not appear to trigger (I'm
pretty sure it was configured correctly, I did see NMIs occurring).
No information appeared on serial or console (although this time they
weren't blanked).  We're building 2.4.33pre kernel now to try and test
on now to see if we're still able to reproduce using it.

We're beginning to suspect that a hung loopback NFS mount might be to
blame, although we can't reproduce this trivially.  Is there anyway in
which a mount that was behaving badly could affect the kernel in this
manner?

Dave

