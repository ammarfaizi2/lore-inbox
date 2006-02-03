Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWBCQ6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWBCQ6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWBCQ6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:58:03 -0500
Received: from xenotime.net ([66.160.160.81]:26825 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751224AbWBCQ6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:58:01 -0500
Date: Fri, 3 Feb 2006 08:57:59 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       nigel@suspend2.net, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Shaohua Li <shaohua.li@intel.com>
Subject: Re: [ 00/10] [Suspend2] Modules support.
In-Reply-To: <58cb370e0602030844v6af78df8w5716a5beae97ac0f@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0602030854140.32067@shark.he.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> 
 <1138916079.15691.130.camel@mindpipe>  <20060202142323.088a585c.akpm@osdl.org>
  <20060203105100.GD2830@elf.ucw.cz>  <58cb370e0602030322u4c2c9f9bm21a38be6d35d2ea6@mail.gmail.com>
  <20060203113543.GA3056@elf.ucw.cz>  <58cb370e0602030546q2ea4b70bq1dc66306d5ef1b12@mail.gmail.com>
  <E1F51dd-0005cc-00@chiark.greenend.org.uk> 
 <58cb370e0602030632p2168fbeaga2a1089b1eea8dfc@mail.gmail.com> 
 <Pine.LNX.4.58.0602030832240.32067@shark.he.net>
 <58cb370e0602030844v6af78df8w5716a5beae97ac0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Bartlomiej Zolnierkiewicz wrote:

> On 2/3/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Fri, 3 Feb 2006, Bartlomiej Zolnierkiewicz wrote:
> >
> > > On 2/3/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
> > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > >
> > > > > This is untrue as Linux has support for setting IDE controller
> > > > > and drives.  It was added by Benjamin Herrenschmidt in late
> > > > > 2.5.x or early 2.6.x (I don't remember exact kernel version).
> > > >
> > > > In generic_ide_resume, rqpm.pm_step gets set to
> > > > ide_pm_state_start_resume and ide_do_drive_cmd gets called. This ends up
> > > > being passed through to start_request. start_request waits for the BSY
> > > > bit to go away. On the affected hardware I've seen, this never happens
> > > > unless the ACPI calls are made. As far as I can tell, there's nothing in
> > > > the current driver code that does anything to make sure that the bus is
> > > > in a state to accept commands at this point - the pci drivers don't (for
> > > > the most part) seem to have any resume methods. Calling the ACPI _STM
> > > > method before attempting to do this magically makes everything work.
> > >
> > > I don't see anything that prevents addition of ->suspend and ->resume
> > > for IDE PCI host drivers (not IDE core issue) if some special sequence
> > > is needed.
> > >
> > > I see that we may be doing PIO/DMA setup too late (IDE core issue)
> > > for some controllers.
> > >
> > > Could you fill a bug at kernel bugzilla with data as much data about
> > > affected hardware as possible (dmesg, kernel config, lspci -vvv -xxx
> > > before susped and if possible PCI configuration dumped from kernel
> > > after suspend)?
> > >
> > > What is the current state of IDE ACPI patches?
> > > Were the issues raised on linux-ide addressed?
> >
> > I haven't seen any updates to the drivers/ide/ patch from
> > Shaohua Li <shaohua.li@intel.com>.  I'm beginning to work on
> > PATA ACPI object support that is similar to the current SATA ACPI
> > patches -- all for libata.  Is this the right or wrong thing
> > to do?
>
> Working on patches is always right thing to do... 8)

Of course.  That wasn't really the question.  8;)

> Just one remark: please try to make ACPI part
> as libata/SCSI independent as possible.

You sort of replied obliquely to my "all for libata" comment.
These patches are all libata-specific.
At least they are SCSI-independent.  :)

-- 
~Randy
