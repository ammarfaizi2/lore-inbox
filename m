Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266549AbUHBOwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266549AbUHBOwK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUHBOwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:52:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34944 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266549AbUHBOus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:50:48 -0400
Date: Mon, 2 Aug 2004 16:50:40 +0200
From: Jens Axboe <axboe@suse.de>
To: tabris <tabris@tabris.net>
Cc: linux-kernel@vger.kernel.org,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       arklinux-list <arklinux-list@arklinux.org>
Subject: Re: ide-cd problems
Message-ID: <20040802145040.GZ10496@suse.de>
References: <20040730193651.GA25616@bliss> <200408020945.05297.tabris@tabris.net> <20040802135615.GX10496@suse.de> <200408021038.17268.tabris@tabris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408021038.17268.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02 2004, tabris wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Monday 02 August 2004 9:56 am, Jens Axboe wrote:
> > On Mon, Aug 02 2004, tabris wrote:
> > > On Sunday 01 August 2004 11:57 am, Jens Axboe wrote:
> > > > On Sun, Aug 01 2004, Alexander E. Patrakov wrote:
> > > > > Zinx Verituse wrote:
> <snip>
> > > > Don't ever use that interface, period. It's not just the cdrecord
> > > > code that may be alpha (I doubt it matters, it's easy to use),
> > > > the interface it uses is not worth the lines of code it occupies.
> > >
> > > 	Then we have a severe disagreement between the cdrecord code (or
> > > at least the runtime warnings) and the Linux-Kernel IDE folks.
> > > specifically, these lines, while running with cdrecord
> > > dev=/dev/cdrom
> <snip>
> > Warning: Open by 'devname' is unintentional and not supported.
> >
> > just says that open-by-device name is unintentional, it doesn't give
> > you warnings on the transport.
> >
> > So in short (and repeating): don't use ATAPI (CDROM_SEND_PACKET), it
> > sucks. Use SG_IO (which means using open-by-device, which works at
> > least as well as the stupid faked ATAPI bus/id/lun crap and has the
> > much better transport). Don't compare apples and oranges.
> I'll take your point on the technical merits.
> 
> But now I get to wondering what to do about all the old HOWTOs. the
> cdrecord folks aren't helping.
> 
> Maybe instead what should be done is a BIG FAT WARNING in the syslog?
> that the CDROM_SEND_PACKET interface is deprecated in kernel 2.6? I
> know that I personally can listen and take your advice, but I worry
> more about the rest of the users, who either will not hear, or will
> hear too many conflicting things. Perhaps it won't help, but I'd
> really like to be able to sell this stuff. And among the necessary
> things is to be able to have sane warnings, and not have warnings that
> will scare my customers off!

CDROM_SEND_PACKET isn't anymore deprecated in 2.6 than it is in 2.4.
It's equally silly to use it with cdrecord in either kernel. In hind
sight, adding that interface was a mistake. It was never meant for
anything serious like a cd burning interface. It lacks good error
reporting, and it basically could not do worse when it comes to
performance. So if you are in 2.4, use ide-scsi! If you are in 2.6, use
ide-cd with SG_IO (eg ATA: method from cdrecord). As it was mentioned a
little up in this thread, you can actually use x,y,z naming to adresse
your given devices, if you have some weird urge to do so. This will kill
the open-by-devname warning from cdrecord. Or you can just ignore this
warning, it means absolutely nothing.

> Yes, this isn't really your (you==Jens) problem, but probably the
> distro maintainers (cc:d ArkLinux) to put in patches silencing some of
> these warnings, and/or change the default behaviour of their front-end
> tools.

And we did, SUSE killed that stupid warning :-)

> I merely hope to find some sanity. Though I have a feeling I'm looking
> in the wrong places (Free and Open Source).

Like any other place, free/open source communities have their sane and
insane members.

-- 
Jens Axboe

