Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWAPWsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWAPWsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWAPWsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:48:14 -0500
Received: from xenotime.net ([66.160.160.81]:43910 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751246AbWAPWsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:48:13 -0500
Date: Mon, 16 Jan 2006 14:48:13 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jens Axboe <axboe@suse.de>
cc: Erik Mouw <erik@harddisk-recovery.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jgarzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
In-Reply-To: <20060116224626.GS3945@suse.de>
Message-ID: <Pine.LNX.4.58.0601161447230.24990@shark.he.net>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
 <20060116115607.GA18307@harddisk-recovery.nl> <20060116140713.GB18307@harddisk-recovery.com>
 <20060116224626.GS3945@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Jens Axboe wrote:

> On Mon, Jan 16 2006, Erik Mouw wrote:
> > On Mon, Jan 16, 2006 at 12:56:07PM +0100, Erik Mouw wrote:
> > > On Fri, Jan 13, 2006 at 10:42:52PM -0800, Randy.Dunlap wrote:
> > > > --- linux-2615-g9.orig/drivers/scsi/Kconfig
> > > > +++ linux-2615-g9/drivers/scsi/Kconfig
> > > > @@ -599,6 +599,11 @@ config SCSI_SATA_INTEL_COMBINED
> > > >  	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
> > > >  	default y
> > > >
> > > > +config SCSI_SATA_ACPI
> > > > +	bool
> > > > +	depends on SCSI_SATA && ACPI
> > > > +	default y
> > > > +
> > >
> > > Could you add some help text over here? At first glance I got the
> > > impression this was a host driver that works through ACPI calls, but by
> > > reading the rest of your patches it turns out it is a suspend/resume
> > > helper.
> >
> > Something like this should already be enough:
> >
> >   This option enables support for SATA suspend/resume using ACPI.
> >
> > If you really need this enabled to be able to use suspend/resume at
> > all, you could add a line like:
> >
> >   It's safe to say Y. If you say N, you might get serious disk
> >   corruption when you suspend your machine.
>
> That's simply not true. If you say N (if you could), you could risk
> having a non-responsive disk after resume. However, it would have been
> synced a suspend time so you wont corrupt anything.
>
> Maybe you don't know what the patch actually does. The main
> suspend/resume support is in libata, all this adds is the ability to
> retrieve the taskfiles that the BIOS/acpi thinks should be issued on
> resume. That may be things like security unlocking the drive. There are
> no data consistency issues involved.

Right.  Some examples that I have seen are for performance (caching),
power management options, and security.

-- 
~Randy
