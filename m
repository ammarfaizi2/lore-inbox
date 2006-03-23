Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWCWXt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWCWXt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWCWXt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:49:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422728AbWCWXt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:49:28 -0500
Date: Thu, 23 Mar 2006 15:51:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       hpa@zytor.com, alan@lxorguk.ukuu.org.uk, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, discuss@x86-64.org, pazke@donpac.ru,
       Matt_Domsch@dell.com
Subject: Re: [PATCH] DMI: move dmi_scan.c from arch/i386 to
 drivers/firmware/
Message-Id: <20060323155118.17028026.akpm@osdl.org>
In-Reply-To: <200603231408.49675.bjorn.helgaas@hp.com>
References: <200603231337.53657.bjorn.helgaas@hp.com>
	<200603232141.09924.ak@suse.de>
	<200603231408.49675.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
> On Thursday 23 March 2006 13:41, Andi Kleen wrote:
> > On Thursday 23 March 2006 21:37, Bjorn Helgaas wrote:
> > > dmi_scan.c is arch-independent and is used by i386, x86_64, and ia64.
> > > Currently all three arches compile it from arch/i386, which means that
> > > ia64 and x86_64 depend on things in arch/i386 that they wouldn't
> > > otherwise care about.
> > > 
> > > This is simply "mv arch/i386/kernel/dmi_scan.c drivers/firmware/"
> > > (removing trailing whitespace) and the associated Makefile changes.
> > > All three architectures already set CONFIG_DMI in their top-level
> > > Kconfig files.
> > > 
> > > Built and booted on ia64 and i386.
> > 
> > This conflicts with at least three patches in my upcomming x86-64 patchkit.

akpm:/usr/src/25> grep -l arch/i386/kernel/dmi_scan.c patches/*.patch
patches/dmi-only-ioremap-stuff-we-actually-need.patch
patches/efi-fixes.patch
patches/efi-keep-physical-table-addresses-in-efi-structure.patch
patches/ia64-use-i386-dmi_scanc.patch
patches/x86_64-mm-dmi-early.patch
patches/x86_64-mm-dmi-year.patch


> > Since it doesn't fix anything I would request that such cleanup patches be
> > delayed.
> 
> Sure, that's fine with me.  Do you want to let me know when your
> patches are in?  Or maybe it would be easier for you to incorporate
> my patch into your patchkit.  I just don't know how to tell when
> the cleanup window is open.
> 

I'm reluctant to attempt to merge the efi patches until ia64, acpi and
x86_64 have merged.  Only ia64 has merged at this time.  acpi might need to
be bypassed, dunno.

I'd expect things to be settled down in a couple of weeks.  Patches which
move files around are hard.
