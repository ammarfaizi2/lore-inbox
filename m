Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVADTsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVADTsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVADTrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:47:15 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:30945 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262059AbVADTl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:41:26 -0500
Subject: Re: dmesg: PCI interrupts are no longer routed
	automatically.........
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-os@analogic.com
Cc: aryix <aryix@softhome.net>, lug-list@lugmen.org.ar,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com>
References: <20041229095559.5ebfc4d4@sophia>
	 <1104862721.1846.49.camel@eeyore>
	 <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 12:41:18 -0700
Message-Id: <1104867678.1846.80.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 13:53 -0500, linux-os wrote:

> I note that pci_enable_device() needs to be executed __before__
> the IRQ is obtained on 2.6.10, otherwise you get the wrong IRQ
> (IRQ10 on this system)B.

Right.

> This doesn't seem to be correct since the IRQ connection was set
> by the BIOS and certainly shouldn't be changed. On this system,
> interrupts that were not shared on 2.4.n and early 2.6.n end
> up being shared... See IRQ18 below.

It's not that we are changing the IRQ, it's just that we now
do the ACPI routing at the time the driver claims the device,
rather than doing all the ACPI routing at boot-time.  The
old strategy messed with IRQs that might never be used (which
broke some things), and also didn't work for hot-plug PCI
root bridges.

Back to my original question, do you have a device that
only works when you use "pci=routeirq"?  If so, what is
it and what driver does it use?

