Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWAPPmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWAPPmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWAPPmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:42:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60260 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751003AbWAPPmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:42:54 -0500
Date: Mon, 16 Jan 2006 16:44:50 +0100
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Message-ID: <20060116154450.GK3945@suse.de>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116123112.GZ3945@suse.de> <Pine.LNX.4.58.0601160736360.24990@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601160736360.24990@shark.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16 2006, Randy.Dunlap wrote:
> On Mon, 16 Jan 2006, Jens Axboe wrote:
> 
> > On Fri, Jan 13 2006, Randy.Dunlap wrote:
> > > From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> > >
> > > Add ata_acpi in Makefile and Kconfig.
> > > Add ACPI obj_handle.
> > > Add ata_acpi.c to libata kernel-doc template file.
> >
> > Randy,
> >
> > Any chance you can add PATA support as well for this? Many of the
> > notebooks out there with SATA controllers really have PATA devices
> > behind a bridge, I think it's pretty much a pre-requisite for this to be
> > considered complete that this is supported as well. The code should be
> > the same, it just needs to lookup the right taskfiles. Right now on this
> > T43, it finds nothing.
> 
> I'll add that to my list but I don't yet think that it's quite
> as simple as you make it sound...

It might not be, I'm totally acpi clueless :-)

But the code factoring should look something like this:

- Lookup taskfiles needed for resume (and suspend might need some,
  too?). This step requires looking for sata and pata taskfiles listed,
  so you'd need code for both.

- Submit and check status of said taskfiles. This step is independent of
  the drive type.

So step 1 is the one that needs extending, how much work that is I
dunno since I have no clue on the actual lookup or the acpi data.

-- 
Jens Axboe

