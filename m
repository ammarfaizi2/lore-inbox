Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbWBUEVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWBUEVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 23:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWBUEVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 23:21:31 -0500
Received: from dsl081-060-252.sfo1.dsl.speakeasy.net ([64.81.60.252]:65166
	"EHLO vitelus.com") by vger.kernel.org with ESMTP id S932701AbWBUEVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 23:21:30 -0500
Date: Mon, 20 Feb 2006 20:21:27 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Promise SATA oops
Message-ID: <20060221042127.GC11106@vitelus.com>
References: <20051202045853.GD3677@vitelus.com> <438FDB9D.2030201@pobox.com> <20051202195109.GE3677@vitelus.com> <20051220201719.GC15466@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220201719.GC15466@vitelus.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This crash kept happening for months, across all versions of the
kernel I tried (up through early 2.6.16 git snapshots). I ended up
buying a different SATA card, and this seems to have fixed the
problem. At around the same frequency as I experienced the nasty
hanging, I'm seeing this error message:

ata1: command 0xea timeout, stat 0x51 host_stat 0x0
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }

...but the system continues running fine. This leads me to believe
that there's a bug in the Promise SATA driver that prevents it from
gracefully handling this error condition, whatever it is. The hard
drives are model WDC WD3200JD-60K, and I couldn't find any bad blocks
on them.


On Tue, Dec 20, 2005 at 12:17:19PM -0800, Aaron Lehmann wrote:
> On Fri, Dec 02, 2005 at 11:51:09AM -0800, Aaron Lehmann wrote:
> > Still isn't stable. It froze within hours after announcing in all
> > terminals that it was disabling a certain IRQ. Now the RAID is so
> > degraded that root can't even be mounted. Was the Promise controller a
> > bad choice for a reliable setup?
> > 
> > I may not have time to look at this further until late next week, but
> > I'll follow up with whatever I learn.
> 
> Argh, died again!! It had been stable for over 12 days. Same error
> message, and the root md is degraded and dirty just like last time.
> This is a very severe state with high risk of data loss. When things
> went sour, terminals and most applications still kept working, but
> anything that touched the filesystem froze up. I had a shell open in a
> chroot on a ramdisk, but dmesg just hung for a few minutes and then
> exited with a "Bus error". I had no other way of examining the kernel
> log since the machine runs X.
> 
> This was running 2.6.15-rc4. Crashes seem to happen less frequently
> with it than with 2.6.14.x, but when they happen they leave the RAID
> in a severe state. I also don't think 2.6.14.2 said anything about
> disabling the IRQ.
> 
> I'm very desperate now. About every week I experience a crash that
> damages my RAID array to the point where it can't boot, as if the
> instability wasn't bad enough. Do I need to buy a hardware RAID card?
