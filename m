Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWCHLjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWCHLjy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWCHLjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:39:54 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:28042 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932495AbWCHLjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:39:54 -0500
Date: Wed, 8 Mar 2006 14:39:52 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060308143952.B4851@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org> <4408CEC8.7040507@garzik.org> <20060308020028.GB26028@kroah.com> <440E4203.7040303@gmail.com> <20060308052723.GD29867@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060308052723.GD29867@kroah.com>; from greg@kroah.com on Tue, Mar 07, 2006 at 09:27:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 09:27:23PM -0800, Greg KH wrote:
> On Wed, Mar 08, 2006 at 11:31:31AM +0900, Tejun Heo wrote:
> > So, the problem is that the chip actually disables the PCI BAR if 
> > certain switches aren't turned on and thus BIOSes are likely not to 
> > reserve mmio address for the BAR. We can turn on proper switches during 
> > driver initialization but we don't know how to wiggle the BAR into mmio 
> > address space.
> 
> Thanks for the explaination, that makes more sense.  Unfortunatly I do
> not know how to do this right now :(
> 
> Anyone with any ideas?

We have 'pci_fixup_early' stuff exactly for that sort of hardware.
IOW, just add a quirk routine that turns on desired mode of the
device and use DECLARE_PCI_FIXUP_EARLY() for it.
The new BAR will be discovered an assigned automatically then.

Ivan.
