Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265756AbUFDMDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUFDMDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUFDMDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:03:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10933 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265756AbUFDMBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:01:48 -0400
Date: Fri, 4 Jun 2004 14:01:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040604120140.GX1946@suse.de>
References: <1085689455.7831.8.camel@localhost> <200406040722.14026.edt@aei.ca> <20040604113226.GU1946@suse.de> <200406041357.58813.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406041357.58813.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> On Friday 04 of June 2004 13:32, Jens Axboe wrote:
> > On Fri, Jun 04 2004, Ed Tomlinson wrote:
> > > On June 4, 2004 05:42 am, Jens Axboe wrote:
> > > > On Thu, Jun 03 2004, Andrew Morton wrote:
> > > > > Ed Tomlinson <edt@aei.ca> wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I am still getting these ide errors with 7-rc2-mm2.  I  get the
> > > > > > errors even if I mount with barrier=0 (or just defaults).  It would
> > > > > > seem that something is sending my drive commands it does not
> > > > > > understand...
> > > > > >
> > > > > > May 27 18:18:05 bert kernel: hda: drive_cmd: status=0x51 {
> > > > > > DriveReady SeekComplete Error } May 27 18:18:05 bert kernel: hda:
> > > > > > drive_cmd: error=0x04 { DriveStatusError }
> > > > > >
> > > > > > How can we find out what is wrong?
> > > > > >
> > > > > > This does not seem to be an error that corrupts the fs, it just
> > > > > > slows things down when it hits a group of these.  Note that they
> > > > > > keep poping up - they do stop (I still get them hours after
> > > > > > booting).
> > > > >
> > > > > Jens, do we still have the command bytes available when this error
> > > > > hits?
> > > >
> > > > It's not trivial, here's a hack that should dump the offending opcode
> > > > though.
> > >
> > > Hi Jens,
> > >
> > > I applied the patch below and booted into the new kernel (the boot
> > > message showed the new compile time).  The error messages remained the
> > > same - no extra info.  Is there another place that prints this (or
> > > (!rq) is true)?
> >
> > !rq should not be true, strange... are you sure it just doesn't to go
> > /var/log/messages, it should be there in dmesg. Alternatively, add a
> > KERN_ERR to that printk.
> 
> Probably !rq is true.

Don't think so, see my other mail. It's the crap duplicate dump_status()
functions.

> Hint: this is what you get for playing tricks with hwrgroup->wrq
> (do you now understand why it is evil?).

Oh give it up, the code is complete crap in so many places as it is.
->rq would just point to &wrq instead. Testament to how hard it is just
to provide a dump opcode (and that you missed it to) is how convoluted
it is. And almost a handful of different command types, with as many
ways to submit it.

This is not blaming you btw, just the code. You've done some nice
cleanups. The main culprit is no longer active :)

-- 
Jens Axboe

