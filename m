Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUBOIYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 03:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUBOIYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 03:24:13 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:50866 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264363AbUBOIYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 03:24:07 -0500
Date: Sun, 15 Feb 2004 03:24:05 -0500
From: Marc Heckmann <mh@nadir.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: oops w/ 2.6.2-mm1 on ppc32
Message-ID: <20040215082404.GA1761@nadir.org>
References: <20040215074140.GA3840@nadir.org> <1076831383.6958.38.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076831383.6958.38.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 06:49:43PM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2004-02-15 at 18:41, Marc Heckmann wrote:
> > It happened while the machine was waking up from sleep. There were no
> > UDF or ISO filesystems mounted at the time, in fact, there wasn't even
> > a cd in the drive. The "autorun" process was running though (polls the
> > cdrom drive, to see if a disc has been inserted...). There were some
> > request timeouts on the cdrom drive (hdc) just before, it went to
> > sleep (system was idle at the time, I wasn't even at home).
> > 
> > Here is the kernel output before and after the machine went to sleep. The Oops
> > is at the bottom.
> 
> Looks like CD went berserk, and something didn't deal with the
> error correctly... I don't know those code path in there
> very well... Can you paste more of the ide-cd errors,
> those are weird.

the last cd related errors were half a month ago. As a side note, the
cdrom drive in this powerbook G3 (Lombard) only really worked right,
if at all, 50% (or less) of the time in 2.6 (it's fine in 2.4). It
does seem to work now (maybe due to the pmac patches in -mm?) though.
I'll continue to test the drive after more uptime and a few
sleep/wakeup cycles.


Jan 31 00:01:30 claw kernel: ide-cd: cmd 0x3 timed out
Jan 31 00:01:30 claw kernel: hdc: irq timeout: status=0xd0 { Busy }
Jan 31 00:01:30 claw kernel: hdc: irq timeout: error=0xd0LastFailedSense 0x0d
Jan 31 00:01:30 claw kernel: hdc: DMA disabled
Jan 31 00:02:00 claw kernel: hdc: ATAPI reset timed-out, status=0x80
Jan 31 00:02:21 claw su(pam_unix)[10335]: session closed for user root
Jan 31 00:02:30 claw kernel: ide1: reset timed-out, status=0x80
Jan 31 00:02:30 claw kernel: hdc: status timeout: status=0x80 { Busy }
Jan 31 00:02:30 claw kernel: hdc: status timeout: error=0x80LastFailedSense 0x08
Jan 31 00:02:30 claw kernel: hdc: drive not ready for command
Jan 31 00:03:00 claw kernel: hdc: ATAPI reset timed-out, status=0x80
Jan 31 00:03:30 claw kernel: ide1: reset timed-out, status=0x80
Jan 31 00:03:31 claw kernel: end_request: I/O error, dev hdc, sector 4291125764
Jan 31 00:03:31 claw kernel: end_request: I/O error, dev hdc, sector 4548260
Jan 31 00:03:31 claw kernel: end_request: I/O error, dev hdc, sector 4548036
Jan 31 00:03:31 claw kernel: UDF-fs: No partition found (1)
Jan 31 00:03:31 claw kernel: end_request: I/O error, dev hdc, sector 4547076
Jan 31 00:03:31 claw kernel: isofs_fill_super: bread failed, dev=hdc, iso_blknum=1136
769, block=1136769

-m
