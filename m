Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTFKXH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 19:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTFKXH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 19:07:58 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:44449 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S264540AbTFKXH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 19:07:56 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- IDE Problem?
From: Christophe Saout <christophe@saout.de>
To: Andy Pfiffer <andyp@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1055369326.1158.252.camel@andyp.pdx.osdl.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 01:21:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2003-06-12 um 00.08 schrieb Andy Pfiffer:
> On Fri, 2003-05-09 at 13:55, Andy Pfiffer wrote:
> > On Fri, 2003-05-09 at 13:04, Christophe Saout wrote:
> > > Am Fre, 2003-05-09 um 21.04 schrieb Andy Pfiffer:
> > > 
> > > > [...]
> > > >  I had an unrelated
> > > > delay in posting this due to some strange behavior of late with LILO and
> > > > my ext3-mounted /boot partition (/sbin/lilo would say that it updated,
> > > > but a subsequent reboot would not include my new kernel)
> > > 
> > > So I'm not the only one having this problem... I think I first saw this
> > > with 2.5.68 but I'm not sure.
> > 
> > Well, that makes two of us for sure.
> > 
> > > 
> > > My boot partition is a small ext3 partition on a lvm2 volume accessed
> > > over device-mapper (I've written a lilo patch for that, but the patch is
> > > working and) but I don't think that has something to do with the
> > > problem.
> > > 
> > > When syncing, unmounting and waiting some time after running lilo, the
> > > changes sometimes seem correctly written to disk, I don't know when
> > > exactly.
> > 
> > My /boot is an ext3 partition on an IDE disk.  My symptoms and your
> > symptoms match -- wait awhile, and it works okay.  If you don't wait
> > "long enough" the changes made in /etc/lilo.conf are not reflected in
> > the after running /sbin/lilo and rebooting normally.
> > 
> > I have been unable to reproduce this on a uniproc system with SCSI
> > disks.
> > 
> > 2.5.67 seems to work in this regard as expected.
> > 
> > > Could it be that the location of /boot/map is not written to the
> > > partition sector of /dev/hda? Or not flushed correctly or something?
> > > 
> > > After reboot the old kernel came up again (though it was moved to
> > > vmlinuz.old).
> > 
> > I don't know -- I haven't isolated it yet.
> > 
> > Anyone else?
> 
> I have taken another look at this, and can confirm the following:
> 
> 1. 2.5.67 works as expected.
> 2. 2.5.68, 2.5.69, and 2.5.70 do not.
> 3. ext2 vs. ext3 for /boot: no effect (ie, .68, .69, .70 demonstrate the
> problem independent of the filesystem used for /boot).

I found out that flushb /dev/<boot_device> helps, syncing doesn't. Not
100% sure if that's right, because right now I'm always doing both, but
I remember having only synced before and that didn't help.

> Relative to a 2.5.68 pure BK tree, the deltas from 2.5.67 to 2.5.68 are:
> 1.971.76.10	/* 2.5.67 */
> 1.1124		/* 2.5.68 */
> 
> The patch exported by BK between these 2 revs is 297K lines ( a sizeable
> haystack ).  Any ideas about where I should dig for my needle first
> would be welcomed...

There don't seem to be too much changes in /drivers/block or /fs, mostly
cleanups. I personally have no idea where to start, except trying out
each -bk version inbetween. Hmmm. And I'm not going to do that now...
:-/

-- 
Christophe Saout <christophe@saout.de>

