Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTFKX1D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 19:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTFKX1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 19:27:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50659 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264607AbTFKX07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 19:26:59 -0400
Date: Thu, 12 Jun 2003 01:40:11 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christophe Saout <christophe@saout.de>
cc: Andy Pfiffer <andyp@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- IDE Problem?
In-Reply-To: <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
Message-ID: <Pine.SOL.4.30.0306120136580.22297-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mm/msync.c:
<...>
 * MS_ASYNC does not start I/O (it used to, up to 2.5.67).
<...>

You can revert changes to mm/msync.c from 2.5.68 patch
and see whether it helps.

Regards,
--
Bartlomiej

On 12 Jun 2003, Christophe Saout wrote:

> Am Don, 2003-06-12 um 00.08 schrieb Andy Pfiffer:
> > On Fri, 2003-05-09 at 13:55, Andy Pfiffer wrote:
> > > On Fri, 2003-05-09 at 13:04, Christophe Saout wrote:
> > > > Am Fre, 2003-05-09 um 21.04 schrieb Andy Pfiffer:
> > > >
> > > > > [...]
> > > > >  I had an unrelated
> > > > > delay in posting this due to some strange behavior of late with LILO and
> > > > > my ext3-mounted /boot partition (/sbin/lilo would say that it updated,
> > > > > but a subsequent reboot would not include my new kernel)
> > > >
> > > > So I'm not the only one having this problem... I think I first saw this
> > > > with 2.5.68 but I'm not sure.
> > >
> > > Well, that makes two of us for sure.
> > >
> > > >
> > > > My boot partition is a small ext3 partition on a lvm2 volume accessed
> > > > over device-mapper (I've written a lilo patch for that, but the patch is
> > > > working and) but I don't think that has something to do with the
> > > > problem.
> > > >
> > > > When syncing, unmounting and waiting some time after running lilo, the
> > > > changes sometimes seem correctly written to disk, I don't know when
> > > > exactly.
> > >
> > > My /boot is an ext3 partition on an IDE disk.  My symptoms and your
> > > symptoms match -- wait awhile, and it works okay.  If you don't wait
> > > "long enough" the changes made in /etc/lilo.conf are not reflected in
> > > the after running /sbin/lilo and rebooting normally.
> > >
> > > I have been unable to reproduce this on a uniproc system with SCSI
> > > disks.
> > >
> > > 2.5.67 seems to work in this regard as expected.
> > >
> > > > Could it be that the location of /boot/map is not written to the
> > > > partition sector of /dev/hda? Or not flushed correctly or something?
> > > >
> > > > After reboot the old kernel came up again (though it was moved to
> > > > vmlinuz.old).
> > >
> > > I don't know -- I haven't isolated it yet.
> > >
> > > Anyone else?
> >
> > I have taken another look at this, and can confirm the following:
> >
> > 1. 2.5.67 works as expected.
> > 2. 2.5.68, 2.5.69, and 2.5.70 do not.
> > 3. ext2 vs. ext3 for /boot: no effect (ie, .68, .69, .70 demonstrate the
> > problem independent of the filesystem used for /boot).
>
> I found out that flushb /dev/<boot_device> helps, syncing doesn't. Not
> 100% sure if that's right, because right now I'm always doing both, but
> I remember having only synced before and that didn't help.
>
> > Relative to a 2.5.68 pure BK tree, the deltas from 2.5.67 to 2.5.68 are:
> > 1.971.76.10	/* 2.5.67 */
> > 1.1124		/* 2.5.68 */
> >
> > The patch exported by BK between these 2 revs is 297K lines ( a sizeable
> > haystack ).  Any ideas about where I should dig for my needle first
> > would be welcomed...
>
> There don't seem to be too much changes in /drivers/block or /fs, mostly
> cleanups. I personally have no idea where to start, except trying out
> each -bk version inbetween. Hmmm. And I'm not going to do that now...
> :-/
>
> --
> Christophe Saout <christophe@saout.de>



