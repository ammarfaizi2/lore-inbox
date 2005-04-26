Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVDZQXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVDZQXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVDZQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:20:31 -0400
Received: from colo.lackof.org ([198.49.126.79]:57307 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261618AbVDZQQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:16:38 -0400
Date: Tue, 26 Apr 2005 10:19:07 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426161907.GD2612@colo.lackof.org>
References: <1114458325.983.17.camel@localhost.localdomain> <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org> <20050426154149.GA2612@colo.lackof.org> <Pine.LNX.4.61.0504261156470.15142@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504261156470.15142@chaos.analogic.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 12:07:41PM -0400, Richard B. Johnson wrote:
> DMAs don't go on "forever"

They don't. But we also don't know when they will stop.
E.g. NICs will stop DMA when the RX descriptor ring is full.
I don't know when USB stop on it's own.

>   and at the time they are started they
> are doing DMA to or from memory that is "owned" by the user of
> the DMA device. In order for DMAs to continue past that point,
> there needs to be something that got notified of a previous
> completion to start the next one that you state is erroneous.
> If such an erroneous DMA is occurring, it can only occur as
> as result of an interrupt and ISR that is still in-place to
> reprogram and restart DMA on the interrupting device.

No. BIOS (parisc PDC in my case) left the device enabled.
PDC does NOT use interrupts which is exactly why they've left
the device enabled for DMA.

> Therefore,
> all you need to do to quiet any such erroneous DMA operations,
> if they are occurring at all, is to mask off the interrupts
> on anything that hasn't been initialized yet.
> 
> The newer PCI code design has a built-in problem that you
> can't find out the interrupt it will use until you enable
> the device.

DMA does not need to be enabled to read PCI_INTERRUPT_LINE (config space).
Or grab the IRQ # from pci_dev->irq if PCI is already initialized.

grant

>  This means that there is some possibility of
> a race between getting that information and putting in a
> ISR to quiet the device which may still be active because
> it was used during the boot. It think this is the more
> likely scenario than some DMA that is still active.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
