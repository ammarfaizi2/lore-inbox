Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269310AbUJVXvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269310AbUJVXvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUJVXtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:49:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:51631 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269310AbUJVXsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:48:40 -0400
Date: Fri, 22 Oct 2004 16:45:08 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.9
Message-ID: <20041022234508.GA28380@kroah.com>
References: <10982257353682@kroah.com> <10982257352301@kroah.com> <20041020091045.D1047@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020091045.D1047@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 09:10:45AM +0100, Russell King wrote:
> On Tue, Oct 19, 2004 at 03:42:15PM -0700, Greg KH wrote:
> > ChangeSet 1.1997.37.29, 2004/10/06 12:50:32-07:00, kaneshige.kenji@jp.fujitsu.com
> > 
> > [PATCH] PCI: warn of missing pci_disable_device()
> > 
> > As mentioned in Documentaion/pci.txt, pci device driver should call
> > pci_disable_device() when it decides to stop using the device. But
> > there are some drivers that don't use pci_disable_device() so far.
> 
> No.  This is wrong.  There are some classes of devices, notably
> PCMCIA Cardbus drivers where buggy BIOS means this should _NOT_
> be done.

But what happens if you reload that driver and try to enable the device?
Does that "just work" somehow on this kind of hardware?

> There are BIOSen out there which refuse to suspend/resume if the
> Cardbus bridge is disabled.
> 
> It's not that the driver is buggy.  It's that the driver has far
> more information than the PCI layer could ever have.

Ugh, I hate broken hardware.  I'll revert this in my next round of pci
changes (sometime next week.)

thanks,

greg k-h
