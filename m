Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUHKWoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUHKWoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUHKWnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:43:12 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:9449 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S268292AbUHKWnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:43:02 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ralf Gerbig <rge-news@quengel.org>
Subject: Re: rc4-mm1 pci-routing
Date: Wed, 11 Aug 2004 16:42:59 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111642.59938.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

Thanks very much for your report.  It looks like this device is the problem:

	0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)

and it should get IRQ 21:

	ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
	ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21

The driver for this should be intel8x0.o, and it looks like you are
loading it as a module.  Could you build it in statically to the kernel
and collect the complete dmesg from a boot with "pci=routeirq" (one
from the boot that hangs would be nice as well, but that is a pain to
collect unless you're using a serial console)?

The usual problem is that a driver looks at pci_dev->irq before calling
pci_enable_device(), but intel8x0.c seems to be doing the right thing
in this regard.

Bjorn
