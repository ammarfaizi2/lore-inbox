Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752039AbWCFWrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbWCFWrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWCFWrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:47:19 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14862 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751308AbWCFWrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:47:18 -0500
Date: Mon, 6 Mar 2006 23:47:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060306224705.GA29509@mars.ravnborg.org>
References: <20060306223545.GA20885@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306223545.GA20885@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 02:35:45PM -0800, Greg KH wrote:
> Here's a summary of the current state of the Linux PCI and PCI Hotplug
> subsystems as of 2.6.16-rc5
> 
> If the information in here is incorrect, or anyone knows of any
> outstanding issues not listed here, please let me know.

Not an direct outstanding issue, but more a TODO.
The section mismatch check that is now part of a regular kernel build
(in -mm) detected a number of cases with inconsistency in __devinit
versus __init usage. Some are still outstanding and needs to be fixed.

The natural next step is to extend the check to cover __devinit,
__devinitdata so we to some extent knows things are consistent should
someone decide to build a kernel without hotplug enabled.

The task is simple enough:
Add a new section for __devinit, __devinitdata
Add consistency check in modpost.

I took a short look at it, but done right stuff from vmlinux.lds ought
to be consolidated in asm-generaic/vmlinux.lds.h, but my head started
spinning when I went through the different $(ARCH)/kernel/vmlinux.lds
files.

2.6.18 material - we are not in a hurry.
Fixes for the warnings always generated are 2.6.17 material if people
start fixing them soon (when the check hits mainline I assume this will
happen).

> Was this summary useful for people?  Anything that I should add to it?

Useful - maybe. But indeed interesting reading (also the USB part).

	Sam
