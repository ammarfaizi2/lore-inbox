Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWCHF1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWCHF1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 00:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWCHF1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 00:27:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:50850
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750810AbWCHF1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 00:27:32 -0500
Date: Tue, 7 Mar 2006 21:27:23 -0800
From: Greg KH <greg@kroah.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060308052723.GD29867@kroah.com>
References: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org> <4408CEC8.7040507@garzik.org> <20060308020028.GB26028@kroah.com> <440E4203.7040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440E4203.7040303@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 11:31:31AM +0900, Tejun Heo wrote:
> Greg KH wrote:
> >On Fri, Mar 03, 2006 at 06:18:32PM -0500, Jeff Garzik wrote:
> >
> >>I have a similar situation:
> >>
> >>BIOS initializes PCI device to mode A, I need to switch it to mode B. 
> >>To do this, I must assign a value to an MMIO PCI BAR that was not 
> >>initialized at boot.
> >>
> >>How to do this?
> >
> >
> >I really don't know, what kind of device wants to do this?
> >
> 
> Jeff is probably talking about ABAR of ICH controllers. ABAR (AHCI BAR, 
> memory mapped IO region covering all AHCI registers) isn't needed for 
> IDE mode operation and the BAR register is disabled when the chip is in 
> IDE mode. However, ABAR becomes necessary for 1. accessing SCR registers 
> (for SATA phy monitor and control) or 2. switching on AHCI mode manually 
> (some notebook BIOSes always initalize ICH6/7m's into IDE mode even when 
> the controller does support AHCI mode.
> 
> So, the problem is that the chip actually disables the PCI BAR if 
> certain switches aren't turned on and thus BIOSes are likely not to 
> reserve mmio address for the BAR. We can turn on proper switches during 
> driver initialization but we don't know how to wiggle the BAR into mmio 
> address space.

Thanks for the explaination, that makes more sense.  Unfortunatly I do
not know how to do this right now :(

Anyone with any ideas?

thanks,

greg k-h
