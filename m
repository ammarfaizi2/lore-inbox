Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUHSQvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUHSQvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUHSQvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:51:31 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:6540 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S266680AbUHSQvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:51:17 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Michael Geithe <warpy@gmx.de>
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Date: Thu, 19 Aug 2004 10:51:11 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040819092654.27bb9adf.akpm@osdl.org>
In-Reply-To: <20040819092654.27bb9adf.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191051.11891.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> kernel 2.6.8.1-mm2 booting here with acpi_os_name=Linux and pci=routeirq.
> Without pci=routeirq hangs at startx (nvidia).

I assume this problem is with the Nvidia binary-only driver?  My guess
is that the driver doesn't call pci_enable_device() before using
pci_dev->irq.  I don't have source for that driver, so I can't verify
this.

If the driver is from Nvidia, please contact their technical support
and request that they fix the driver.  I can help explain the issue if
necessary.

I also noticed this in your dmesg:

	floppy: controller ACPI FDC0 at I/O 0x3f7-0x3f7 irq 6 dma channel 2
	Using anticipatory io scheduler
	Floppy drive(s): fd0 is 1.44M
	floppy0: no floppy controllers found

I hope that you have the floppy controller disabled in your BIOS,
or at least have no floppy drives connected.  Can you confirm that?
I expected that ACPI would not report the controller at all in such
a case, but it looks like yours reports the controller with a zero-
length I/O port region.  I probably should check for that.

If you do have a floppy drive, it probably doesn't work anymore
unless you specify "floppy=no_acpi".  If this is the case, we'll
have to figure out a quirk or something to make it work.

Thanks for the testing report!

