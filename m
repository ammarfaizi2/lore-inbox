Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVCKQua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVCKQua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVCKQu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:50:29 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:55789 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261209AbVCKQsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:48:12 -0500
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>
References: <20050304234622.63e8a335.akpm@osdl.org>
	 <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 09:48:05 -0700
Message-Id: <1110559685.4822.15.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 00:08 +0100, Grzegorz Kulewski wrote:
> Anything new about it?
> 
> Can I provide more usefull info?

Can you check to see whether there are any BIOS updates available
for your box?  It looks to me like your USB controllers are wired
to IRQ9, and that's how the BIOS is leaving them configured.

But ACPI is telling us they're on IRQ10, which seems like a BIOS
bug.

Can you also post the complete dmesg log without "acpi=off"?  There
might be an ACPI interrupt link device for the USB controller, and
maybe there's something wrong there.

> My log (2.6.11 without acpi=off):
> Mar  2 23:36:56 kangur USB Universal Host Controller Interface driver v2.2
> Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: irq 10, io base 0xc800
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
> Mar  2 23:36:56 kangur hub 1-0:1.0: USB hub found
> Mar  2 23:36:56 kangur hub 1-0:1.0: 2 ports detected
> Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: irq 10, io base 0xcc00
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
> Mar  2 23:36:56 kangur hub 2-0:1.0: USB hub found
> Mar  2 23:36:56 kangur hub 2-0:1.0: 2 ports detected

> My log (2.6.11 with acpi=off):
> Mar  3 01:45:48 kangur USB Universal Host Controller Interface driver v2.2
> Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:07.2
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.3
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:0b.0
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: irq 9, io base 0xc800
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
> Mar  3 01:45:48 kangur hub 1-0:1.0: USB hub found
> Mar  3 01:45:48 kangur hub 1-0:1.0: 2 ports detected
> Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:07.3
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.2
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:0b.0
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: irq 9, io base 0xcc00
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
> Mar  3 01:45:48 kangur hub 2-0:1.0: USB hub found
> Mar  3 01:45:48 kangur hub 2-0:1.0: 2 ports detected


