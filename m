Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWCBTN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWCBTN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWCBTN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:13:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11539 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751675AbWCBTNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:13:25 -0500
Date: Thu, 2 Mar 2006 19:13:05 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Message-ID: <20060302191305.GF28895@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302180025.GC28895@flint.arm.linux.org.uk> <44073593.60703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44073593.60703@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 01:12:35PM -0500, Jeff Garzik wrote:
> Russell King wrote:
> >It's not really "I/O port resource allocation" though - the resources
> >have already been allocated and potentially programmed into the BARs
> >well before the driver gets anywhere near the device.
> [...]
> >Are you implying that somehow resources are allocated at pci_enable_device
> >time?  If so, shouldn't we be thinking of moving completely to that model
> >rather than having yet-another-pci-setup-model.
> 
> Actually, that's has been the rule ever since the cardbus days: 
> resources -- bars and irqs -- should not be considered allocated until 
> after pci_enable_device().

However, practically, cardbus have always had and continue to have their
resources setup prior to driver probe.

> Documentation/pci.txt reflects this reality as well:
> 
> >3. Enabling and disabling devices
> >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   Before you do anything with the device you've found, you need to enable
> >it by calling pci_enable_device() which enables I/O and memory regions of
> >the device, allocates an IRQ if necessary, assigns missing resources if
> >needed and wakes up the device if it was in suspended state. Please note
> >that this function can fail.
> 
> Any PCI driver that presumes -anything- about resources before calling 
> pci_enable_device() is buggy, and that's been the case for many years. 
> Some platform-specific PCI drivers violate this with special knowledge, 
> but overall that's the rule.

Nevertheless, my basic point that the no_ioport solution only addresses
one problem area, while being far too late for the other methods still
stands.

Maybe the setup-* stuff needs to be rewritten (in which case cardbus
will also convert to the "new" system automatically)?

Given the problems of allocating resources for bridges inside cardbus
cards, it would be nice if this could happen, so the limited IO range
provided to cardbus could be more efficiently (and selectively) used.

Wouldn't you think that's a sane idea?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
