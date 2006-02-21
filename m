Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWBURE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWBURE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWBURE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:04:57 -0500
Received: from xenotime.net ([66.160.160.81]:206 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932313AbWBURE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:04:56 -0500
Date: Tue, 21 Feb 2006 09:04:51 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jens Axboe <axboe@suse.de>
cc: Ariel Garcia <garcia@iwr.fzk.de>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
In-Reply-To: <20060219191859.GJ8852@suse.de>
Message-ID: <Pine.LNX.4.58.0602210903260.8603@shark.he.net>
References: <200602191958.38219.garcia@iwr.fzk.de> <20060219191859.GJ8852@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006, Jens Axboe wrote:

> On Sun, Feb 19 2006, Ariel Garcia wrote:
> > Hi Jens,
> >
> > regarding your suspend support patch for libata:
> >
> > > author  Jens Axboe <axboe@suse.de>
> > >    Fri, 6 Jan 2006 08:28:07 +0000 (09:28 +0100)
> > > commit  9b847548663ef1039dd49f0eb4463d001e596bc3
> >
> > >  [PATCH] Suspend support for libata
> > >  This patch adds suspend patch to libata, and ata_piix in particular.
> > > For most low level drivers, they should just need to add the 4 hooks to
> > > work. As I can only test ata_piix, I didn't enable it for more though.
> >
> > i tested the trivial "4-hooks" patch on kernel 2.6.16-rc4, on my laptop
> > (i915, ICH6 chipset, sata hd - a Fujitsu-Siemens 7020)
> > but it doesn't work as it should:
> >    after resume the drive fails to respond to the commands so it
> >    ends up remounted read-only.
> >
> > I am attaching:
> >    - the trivial patch i used
> >    - the output of lsmod (lsmod-clean.txt)
> >    - the output of lspci -vv  before (lspci-clean.txt)
> >         and after resuming (lspci-resume.txt)
> >    - the output of dmesg (glueing the full boot + resuming messages)
> >
> > All this was done running in single mode. I also tried suspending after
> > removing all unnecessary modules (usb, snd,ide,...), same result.
> >
> > BTW, running a    'diff lspci-clean.txt lspci-resume.txt'
> > i also noticed that after resume some pci devices get a different
> > "BusMaster" polarity, but the SATA controller doesn't.
> >
> > I would be glad to test patches/debug other things, feel free to ask.
>
> The first thing to try is to add the acpi addon from Randy and see if
> that helps at all. Looking at the log, the first command we issue after
> resume times out which smells a lot like an unlock command missing
> (which is typically in the GTF list from acpi).

Ariel-
These patches (for 2.6.16-rc3) are at
http://www.xenotime.net/linux/SATA/2.6.16-rc3/libata-rollup-2616-rc3.patch

in case you didn't find them yet.

> So try this patch on 2.6.16-rc3 (or -rc4, if it applies, haven't
> checked) and make sure to keep the ahci patch you have that adds the 4
> needed hooks as well.

-- 
~Randy
