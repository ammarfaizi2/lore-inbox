Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUKTSpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUKTSpy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbUKTSpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:45:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9227 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263147AbUKTSpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:45:05 -0500
Date: Sat, 20 Nov 2004 18:45:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.9
Message-ID: <20041120184500.A28206@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <10982257353682@kroah.com> <10982257352301@kroah.com> <20041020091045.D1047@flint.arm.linux.org.uk> <20041022234508.GA28380@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041022234508.GA28380@kroah.com>; from greg@kroah.com on Fri, Oct 22, 2004 at 04:45:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 04:45:08PM -0700, Greg KH wrote:
> On Wed, Oct 20, 2004 at 09:10:45AM +0100, Russell King wrote:
> > On Tue, Oct 19, 2004 at 03:42:15PM -0700, Greg KH wrote:
> > > ChangeSet 1.1997.37.29, 2004/10/06 12:50:32-07:00, kaneshige.kenji@jp.fujitsu.com
> > > 
> > > [PATCH] PCI: warn of missing pci_disable_device()
> > > 
> > > As mentioned in Documentaion/pci.txt, pci device driver should call
> > > pci_disable_device() when it decides to stop using the device. But
> > > there are some drivers that don't use pci_disable_device() so far.
> > 
> > No.  This is wrong.  There are some classes of devices, notably
> > PCMCIA Cardbus drivers where buggy BIOS means this should _NOT_
> > be done.
> 
> But what happens if you reload that driver and try to enable the device?
> Does that "just work" somehow on this kind of hardware?

Why wouldn't it work?  Surely there are no side effects to trying to enable
an already enabled device - if there are, then wouldn't x86 have problems
where PCI devices were enabled before control was passed to the kernel?

> > There are BIOSen out there which refuse to suspend/resume if the
> > Cardbus bridge is disabled.
> > 
> > It's not that the driver is buggy.  It's that the driver has far
> > more information than the PCI layer could ever have.
> 
> Ugh, I hate broken hardware.  I'll revert this in my next round of pci
> changes (sometime next week.)

It's got nothing to do with hardware.  It's BIOS.

Also, upon re-reading the bug report, the problem was putting the Cardbus
bridge into D3 state, not calling pci_disable_device() for it.  However,
if pci_disable_device() puts the bridge into D3, then we'll hit the same
issue.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
