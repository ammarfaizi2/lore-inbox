Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTKONnd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 08:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbTKONnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 08:43:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28857 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261748AbTKONnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 08:43:31 -0500
Date: Sat, 15 Nov 2003 14:43:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031115134325.GV4441@suse.de>
References: <20031113070627.GU21141@suse.de> <Pine.LNX.3.96.1031115080431.2903C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1031115080431.2903C-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 15 2003, Bill Davidsen wrote:
> On Thu, 13 Nov 2003, Jens Axboe wrote:
> 
> > On Wed, Nov 12 2003, bill davidsen wrote:
> 
> > > capability working again. I presume eventually one of the commercial
> > > vendors will fix it, since it's easier than rewriting all the SCSI
> > > applications in the world. oddly there are people writing useful things
> > > using other operating systems, under 2.4 almost all of those work.
> > 
> > It's not about applications, we can fix that differently. You still
> > don't seem to get that moving from ide-scsi is a _good_ thing, from the
> > application point of view. It's about hardware that doesn't work well
> > with atapi drivers yet, for whatever reason. ide-scsi is nice to have to
> > fill those holes.
> 
> Sorry, as far as I can tell it's just the wrong direction. Devices mounted
> by USB look like... SCSI. And ZIP drives and tapes mounted on parallel
> (ppa) look like... SCSI. If Linux had one fully functional ide-scsi driver
> it would then present a consistant all-SCSI interface to the applications.

Crap. 2.6 block layer can pass "looks like SCSI" commands through the
plain queue just fine, why on earth would I need to go through two extra
layers to send a command to ide-cd? Presenting all-SCSI interface to
applications is bogus. The number of actual SCSI devices is going down
by the minute. Basically all storage-like devices talk some packetized
commands that looks like SCSI, but they are not.

What we do need is something that allows you to submit commands to a
device, no matter where it's attached. You still don't seem to grasp
that.

> No more ide-floppy, ide-cd, ide-tape, just one driver. And that would
> allow use of applications from BSD, Sun, and SysV.

One drive to manage different device types? What are you smoking.

> Clearly the ide-scsi driver currently available isn't fully capable, and
> as long as Linus doesn't agree that having a single application interface
> is elegant and desirable, I can't see anyone doing the things needed.

Once again you fail to understand the simplest of points. Linus doesn't
disagree that one single application interface is what we want, and I
don't disagree. What you don't understand is that sg (and having to
carry the full SCSI stack around) is anything but elegant and desired.

And if you can't see anyone doing the things needed, then you are blind
as well. I've mentioned bsg (block sg) many times on lkml.

Further mails from you go to /dev/null, you are wasting everybodies
time.

-- 
Jens Axboe

