Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWCFXAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWCFXAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbWCFXAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:00:24 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:1930 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750976AbWCFXAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:00:23 -0500
Date: Mon, 6 Mar 2006 15:00:10 -0800
From: Greg KH <gregkh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060306230010.GA21190@suse.de>
References: <20060306223545.GA20885@kroah.com> <20060306224705.GA29509@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306224705.GA29509@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 11:47:05PM +0100, Sam Ravnborg wrote:
> On Mon, Mar 06, 2006 at 02:35:45PM -0800, Greg KH wrote:
> > Here's a summary of the current state of the Linux PCI and PCI Hotplug
> > subsystems as of 2.6.16-rc5
> > 
> > If the information in here is incorrect, or anyone knows of any
> > outstanding issues not listed here, please let me know.
> 
> Not an direct outstanding issue, but more a TODO.
> The section mismatch check that is now part of a regular kernel build
> (in -mm) detected a number of cases with inconsistency in __devinit
> versus __init usage. Some are still outstanding and needs to be fixed.
> 
> The natural next step is to extend the check to cover __devinit,
> __devinitdata so we to some extent knows things are consistent should
> someone decide to build a kernel without hotplug enabled.
> 
> The task is simple enough:
> Add a new section for __devinit, __devinitdata
> Add consistency check in modpost.

Yes, thanks for reminding me.

> I took a short look at it, but done right stuff from vmlinux.lds ought
> to be consolidated in asm-generaic/vmlinux.lds.h, but my head started
> spinning when I went through the different $(ARCH)/kernel/vmlinux.lds
> files.

It's not that bad, you really only have to touch
include/asm-generic/vmlinux.lds.h from which all the other .lds files
are generated.  There are 2 others, arch/m68knommu/kernel/vmlinux.lds.S
and arch/v850/kernel/vmlinux.lds.S which seem to not use this file, and
that's it.

See my EXPORT_SYMBOL_GPL_FUTURE() patch for an example of all that
should need to be done to modify this file for this feature.

And yes, I agree that we should do it to fix the issues you have pointed
out.

thanks again,

greg k-h
