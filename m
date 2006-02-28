Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWB1PS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWB1PS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWB1PS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:18:59 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:50876 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751052AbWB1PS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:18:58 -0500
Date: Tue, 28 Feb 2006 10:18:56 -0500
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: col-pepper@piments.com, linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
Message-ID: <20060228151856.GB27601@csclub.uwaterloo.ca>
References: <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com> <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com> <op.s5nm6rm5j68xd1@mail.piments.com> <Pine.LNX.4.61.0602280745500.9291@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602280745500.9291@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 08:10:44AM -0500, linux-os (Dick Johnson) wrote:
> 
> On Mon, 27 Feb 2006 col-pepper@piments.com wrote:
> 
> > On Mon, 27 Feb 2006 22:32:07 +0100, linux-os (Dick Johnson)
> > <linux-os@analogic.com> wrote:
> >
> >> Flash does not get zeroed to be written! It gets erased, which sets all
> >> the bits to '1', i.e., all bytes to 0xff.
> >
> > Thanks for the correction, but that does not change the discussion.
> >
> >> Further, the designers of
> >> flash disks are not stupid as you assume. The direct access occurs
> >> to static RAM (read/write stuff).
> >
> > I'm not assuming anything . Some hardware has been killed by this issue.
> > http://lkml.org/lkml/2005/5/13/144
> 
> No. That hardware was not killed by that issue. The writer, or another
> who had encountered the same issue, eventually repartitioned and
> reformatted the device. The partition table had gotten corrupted by
> some experiments and the writer assumed that the device was broken.
> It wasn't.
> 
> Also, if you read other elements in this thread, you would have
> learned about something that has become somewhat of a red herring.
> 
> It takes about a second to erase a 64k physical sector. This is
> a required operation before it is written. Since the projected
> life of these new devices is about 5 to 10 million such cycles,
> (older NAND flash used in modems was only 100-200k) the writer
> would have to be running that "brand new device" for at least
> 5 million seconds. Let's see:

How come I can write to my compact flash at about 2M/s if you claim it
takes 1s to erase a 64k sector?  Somehow I think your number is much too
high.  Or it can do multiple erases at the same time.

Also the 5 to 10 million is a lot higher than the numbers the makers of
the compact flash cards I use claim.

> 60 seconds per minute
> 3600 seconds per hour
> 86400 seconds per day.
> 
> 5,000,000 / 86400 = 57 days of continuous writes to the same
> sector. The writer surely would have a strange file because
> he states that even a single large file can destroy the drive
> if it is mounted with the "sync" option.
> 
> Also, the failure mode of NAND flash is not that it becomes
> "destroyed". The failure mode is a slow loss of data. The
> devices no longer retain data for a zillion years, only a
> few hundred, eventually, only a year or so. So when somebody
> claims that the flash has gotten destroyed, they need to have
> written it for a few months, then waited for a few years before
> reporting the event.

Some flash devices can be "destroyed" by loosing power in the middle of
a write, since this causes them to corrupt their table of blocks and
only the manufacturer has the ability to reset that.  Fortunately this
doesn't seem like too common a design.

Len Sorensen
