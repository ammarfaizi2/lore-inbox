Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTKYAau (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTKYAau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:30:50 -0500
Received: from thunk.org ([140.239.227.29]:36051 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261731AbTKYAas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:30:48 -0500
Date: Mon, 24 Nov 2003 19:30:33 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Larry McVoy <lm@work.bitmover.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Larry McVoy <lm@bitmover.com>, Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: data from kernel.bkbits.net
Message-ID: <20031125003033.GA9269@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Larry McVoy <lm@work.bitmover.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Larry McVoy <lm@bitmover.com>, Ricky Beam <jfbeam@bluetronic.net>,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <20031124155034.GA13896@work.bitmover.com> <Pine.GSO.4.33.0311241405070.13188-100000@sweetums.bluetronic.net> <20031124192432.GA20839@work.bitmover.com> <Pine.LNX.4.53.0311241459320.2333@chaos> <20031124203321.GA9036@thunk.org> <Pine.LNX.4.53.0311241628230.3173@chaos> <20031124222413.GA27604@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124222413.GA27604@work.bitmover.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 02:24:13PM -0800, Larry McVoy wrote:
> > Yes but an attempt to read beyond the limits of the physical
> > drive will provide you with a lot of **interesting** hardware
> > errors. This happens if the file-system gets corrupt.

Sure, but not that those kinds of errors.  You'll see errors like this
instead:

 kernel: attempt to access beyond end of device
 kernel: 08:05: rw=0, want=198500353, limit=5779456
 kernel: attempt to access beyond end of device
 kernel: 08:05: rw=0, want=4294934529, limit=5779456 

ATA device timeouts, which is what Larry reported, are not caused by
attempting to read beyond the limits of the physical device.

> Yeah, I think Richard may be right.  Anyway, the drive sort of reads
> from the raw partition.  It gets a IDE reset and then it reads.  I can
> read it a second time with no reset.  Haven't tried a reboot between
> reads, hang on, yeah, a reboot brings the errors back.

It really, really sounds like the disk is pooched.  I don't know if it
was bad luck, cooincidence, or the fact that it was powered down for a
while.  But I'm guessing that it's taking a long time for disk to read
a sector, which is causing the disk driver to timeout and reset the
bus, but then the sector is first cached in the IDE disk cache (where
it can be read quickly) and then it ends up getting cached in the
system memory.  That would explain why a reboot brings the errors backed.

> But, fscking the dd-ed image gets me less errors so I'm trying that 
> route to get the data back.

If using the dd'ed image is giving you less errors, combined with your
other description, it's causing me to be really suspicious about the
hard drive.  If you're really brave, or foolish, (or have already
backed up the image), you might try doing a non-destructive read/write
test using the badblocks(8) command.  I'm pretty confident that it
will turn up all sorts of problems, though, since the low-level device
driver errors you were describing really are not consistent with
filesystem corruption, but with a hardware failure of some kind.

						- Ted
