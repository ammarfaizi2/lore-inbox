Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUHBRRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUHBRRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUHBRRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:17:32 -0400
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:47807 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S266680AbUHBRQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:16:23 -0400
Date: Mon, 2 Aug 2004 12:16:20 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems
Message-ID: <20040802171620.GA802@bliss>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <20040731210257.GA22560@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731210257.GA22560@bliss>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 04:02:57PM -0500, Zinx Verituse wrote:
> On Sat, Jul 31, 2004 at 10:00:36PM +0200, Jens Axboe wrote:
> > On Sat, Jul 31 2004, Zinx Verituse wrote:
> > > On Sat, Jul 31, 2004 at 05:36:10PM +0200, Jens Axboe wrote:
> > > > On Fri, Jul 30 2004, Zinx Verituse wrote:
> > > > > I'm going to bump this topic a bit, since it's been a while..
> > > > > There are still some issues with ide-cd's SG_IO, listed from
> > > > > most important as percieved by me to least:
> > > > > 
> > > > >  * Read-only access grants you the ability to write/blank media in the drive
> > > > >  * (with above) You can open the device only in read-only mode.
> > > > 
> > > > That's by design. Search linux-scsi or this list for why that is so.
> > > 
> > > The only thing I can find on the linux-scsi list is refering to sg
> > > devices, which are on a different device node from the non-generic
> > > device.  This means you can still allow users read access to the disk
> > > without allowing them to send random commands to the disk -- this isn't
> > > currently possible with the IDE interface, since the device with
> > > generic access is the same as the one with the original read/cdrom
> > > commands access.
> > > 
> > > As it is, it's impossible grant users read-only access to an IDE cd-rom
> > > without allowing them to do things like replacing the firmware with a
> > > malicious/non-working one.
> > > 
> > > Generic access allowing such things is fine; but only if we can grant
> > > non-generic access without granting generic access.
> > 
> > If you want it to work that way, you have the have a pass-through filter
> > in the kernel knowing what commands are out there (including vendor
> > specific ones). That's just too ugly and not really doable or
> > maintainable, sorry.
> > 
> > If you have access to issue ioctls to the device, you have access to
> > send it arbitrary commands - period.
> 
> I don't believe command filtering is neccessary, since all of the
> ide-cd ioctls are still there (ioctls that allow playing, reading, etc)
> Only the SG_IO ioctl itself would have to be checked (i.e., not each
> individual command available with SG_IO, just the overall ioctl itself,
> categorizing all of SG_IO more or less as raw IO.  If this isn't doable
> with the current design, then the ide-cd interface should at least be
> very conspicuously documented as being extremely insecure as far as
> "read" access is concerned, as I know I wouldn't expect users to be able
> to overwrite my drive's firmware simply by granting the read access.

I'm replying to this because this message was never addressed, and
instead fell in to Yet Another war on cdrecord's stupid naming scheme.
The two have nothing to do with each other, and this issue (i.e., not
the stupid naming scheme) needs addressed.

-- 
Zinx Verituse                                    http://zinx.xmms.org/
