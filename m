Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271687AbTG2MHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271688AbTG2MHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:07:32 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:41123 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S271687AbTG2MHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:07:25 -0400
To: "Kathy Frazier" <kfrazier@mdc-dayton.com>
Cc: <linux-kernel@vger.kernel.org>, <herbert@13thfloor.at>
Subject: Re: Problems related to DMA or DDR memory on Intel 845 chipset?
References: <PMEMILJKPKGMMELCJCIGCEIOCDAA.kfrazier@mdc-dayton.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 29 Jul 2003 01:14:04 +0200
In-Reply-To: <PMEMILJKPKGMMELCJCIGCEIOCDAA.kfrazier@mdc-dayton.com>
Message-ID: <m3u1962qir.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kathy Frazier" <kfrazier@mdc-dayton.com> writes:

> Sorry for the confusion!  My driver sets up our device for a DMA (address
> and length) and then gives the command
> for the DMA to start.  Once the device has completed the transfer, it
> asserts its interrupt, the driver clears it and proceeds to set up the next
> data transfer.  It runs for awhile, but then eventually hangs (I don't get
> interrupts and neither does anything else - keyboard, ethernet, etc).  I
> simply added debug to do_IRQ in the kernel to track the desired IRQ.  I also
> added a routine to read the 8259 Interrupt Controller Registers when
> requested.  Then I had a user app and driver which simply called this new
> new routine in the kernel to return the status of the 8259 and the debug
> counters I added to do_IRQ.  Once the system failed, this debug information
> showed that not only was Linux NOT receiving the interrupt, but neither was
> the 8259.  When I changed my driver to poll the device for DMA completion
> instead of rely on an interrupt, it still locked up.

I understand this is your device doing DMA (= access) - i.e. your
PCI card is transfering to/from system RAM? This has nothing to do with
any UDMA and it works with any Linux kernel and system hardware which
support PCI.

Are you using some standard PCI bridge by chance? Are you sure it isn't
a hardware (design or manufacturing) problem with the device (bridge)?
How do you check interrupt request state?
-- 
Krzysztof Halasa
Network Administrator
