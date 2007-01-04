Return-Path: <linux-kernel-owner+w=401wt.eu-S1030253AbXADWIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbXADWIl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbXADWIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:08:41 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:34623 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030253AbXADWIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:08:40 -0500
Subject: Re: BUG, 2.6.20-rc3 raid autodetection
From: Kasper Sandberg <lkml@metanurb.dk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e0701041405l38641d97jba652ba6645c0d08@mail.gmail.com>
References: <1167936465.6594.5.camel@localhost>
	 <58cb370e0701041107n5369edfdj2efc871de0fe7d24@mail.gmail.com>
	 <1167940677.8595.1.camel@localhost>
	 <58cb370e0701041207s5c2e3e26j434dd7fe6809e50b@mail.gmail.com>
	 <1167944429.8595.3.camel@localhost>
	 <58cb370e0701041306w5c99c974j1137883b7b95a8@mail.gmail.com>
	 <1167947115.8595.6.camel@localhost>
	 <58cb370e0701041405l38641d97jba652ba6645c0d08@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 23:08:34 +0100
Message-Id: <1167948514.8595.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-04 at 23:05 +0100, Bartlomiej Zolnierkiewicz wrote:
> On 1/4/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > On Thu, 2007-01-04 at 22:06 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > On 1/4/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > > On Thu, 2007-01-04 at 21:07 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > > On 1/4/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > > > > On Thu, 2007-01-04 at 20:07 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > > > > On 1/4/07, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > > > > > > Hello.
> > > > > > > >
> > > > > > > > i just attempted to test .20-rc3-git4 on a box, which has 6 drives in
> > > > > > > > raid5. it uses raid autodetection, and 2 ide controllers (via and
> > > > > > > > promise 20269).
> > > > > > > >
> > > > > > > > there are two problems.
> > > > > > > >
> > > > > > > > first, and most importantly, it doesent autodetect, i attempted with
> > > > > > > > both the old ide drivers, and the new pata on libata drivers, the drives
> > > > > > > > appears to be found, but the raid autoassembling just doesent happen.
> > > > > > > >
> > > > > > > > this is .17, which works:
> > > > > > > > http://sh.nu/p/8001
> > > > > > > >
> > > > > > > > this is .20-rc3-git4 which doesent work, in pata-on-libata mode:
> > > > > > > > http://sh.nu/p/8000
> > > > > > > >
> > > > > > > > this is .20-rc3-git4 which doesent work, in old ide mode:
> > > > > > > > http://sh.nu/p/8002
> > > > > > >
> > > > > > > For some reason IDE disk driver is not claiming IDE devices.
> > > > > > >
> > > > > > > Could you please double check that IDE disk driver is built-in
> > > > > > > (CONFIG_BLK_DEV_IDEDISK=y in the kernel configuration)
> > > > > > > and not compiled as module?
> > > > > > i need not check even once, i do not have module support enabled, so
> > > > >
> > > > > OK
> > > > >
> > > > > > everything 1000000% surely is built in. this is the case for .17 too
> > > > > > (and earlier, this box was started with .15 i think.)
> > > > >
> > > > > Could you send me your config?
> > > > > I'll try to reproduce this locally.
> > > > sure thing.
> > > >
> > > > http://sh.nu/p/8004 <-- .17 working
> > >
> > > CONFIG_BLK_DEV_IDEDISK=y
> > >
> > > > http://sh.nu/p/8005 <-- .20-rc3-git4 nonworking, idemode, the one with
> > > > libata i dont have anymore, but the only difference is that i use the
> > > > libata drivers, but as its same result, shouldnt matter
> > >
> > > # CONFIG_BLK_DEV_IDEDISK is not set
> > >
> > > so not everything is "1000000% surely" built-in ;)
> > i see your point, im afraid i may have misinterpreted you, since you
> > said "and not compiled as module", so i thought you meant i had to make
> > sure it wasnt moduled only.
> 
> You were right - I forgot about "CONFIG_BLK_DEV_IDEDISK=n" case.
> 
> > i will try with this now, what about pataonlibata, do i need this for
> 
> Please report if this fixes the issue.
yeah it did.
> 
> > that too?
> 
> for libata you need SCSI disk driver: CONFIG_BLK_DEV_SD=y
> 
> [ libata is not independent subsystem like IDE but depends on SCSI,
>   and I really don't know why this is not mentioned in config help ]
i knew that, i just thought it may select what it required, though i can
see that it isnt strictly required, just what one wishes often. :)

thanks for your help, will try with libata now.
> 

