Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVFWRnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVFWRnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVFWRnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:43:45 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:23717 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262645AbVFWRni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:43:38 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: 2.6.12 breaks 8139cp
Date: Thu, 23 Jun 2005 11:43:34 -0600
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx>
In-Reply-To: <42BA69AC.5090202@drzeus.cx>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GTvuCxsolS9dCb+"
Message-Id: <200506231143.34769.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GTvuCxsolS9dCb+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 23 June 2005 1:50 am, Pierre Ossman wrote:
> >On Wednesday 22 June 2005 3:03 pm, Pierre Ossman wrote:
> >>Upgrading from 2.6.11 to 2.6.12 caused my 8139cp network card to stop
> >>working. No error messages are emitted and everything seems to work
> >>(from the local computers point of view). But nothing can be recieved
> >>from the network.
> 
> dmesg:s included. But they don't really differ more than some cosmetic
> changes in the output strings.
> 
> The problem is I can't find anything that differs. 2.6.12 behaves more
> or less like someone cut of the rx pins in the connector. ifconfig
> doesn't report any errors so it isn't a problem with packets getting
> dropped. tcpdump only shows the outgoing packets.

Your 2.6.11 dmesg mentions the VIA IRQ fixup, but the 2.6.12 one
doesn't.  I bet something's broken there.

Can you try the attached debugging patch?  And please collect the
output of lspci, too.

--Boundary-00=_GTvuCxsolS9dCb+
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="via-irq"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via-irq"

Index: work/drivers/pci/quirks.c
===================================================================
--- work.orig/drivers/pci/quirks.c	2005-06-21 13:43:29.000000000 -0600
+++ work/drivers/pci/quirks.c	2005-06-23 10:40:55.000000000 -0600
@@ -510,7 +510,7 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * PIIX3 USB: We have to disable USB interrupts that are

--Boundary-00=_GTvuCxsolS9dCb+--
