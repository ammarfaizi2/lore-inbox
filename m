Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUIXQpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUIXQpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268944AbUIXQml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:42:41 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:3986 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S268950AbUIXQdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:33:18 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andre Eisenbach <int2str@gmail.com>
Subject: Re: USB (OHCI) not working without pci=routeirq
Date: Fri, 24 Sep 2004 10:33:09 -0600
User-Agent: KMail/1.7
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <7f800d9f040923102315e8d400@mail.gmail.com>
In-Reply-To: <7f800d9f040923102315e8d400@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241033.09289.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2004 11:23 am, Andre Eisenbach wrote:
> when booting with a recent kernel (2.6.9-rc2-mm2), usb_ohci fails to
> initialize the USB bus and no USB device will work at that point.
> Adding pci=routeirq fixed the problem.

Can you try this whitespace-damaged patch to see whether you're
seeing the same issue I was?  If this patch fixes it, please post
the "lspci -n" output for your USB controller, so we can add a
quirk for it.

--- 2.6.9-rc2-mm2/drivers/usb/host/ohci-hcd.c.orig 2004-09-24 10:28:16.383160107 -0600
+++ 2.6.9-rc2-mm2/drivers/usb/host/ohci-hcd.c 2004-09-24 10:28:23.089214712 -0600
@@ -564,7 +564,7 @@
   * (SiS, OPTi ...), so reset again instead.  SiS doesn't need
   * this if we write fmInterval after we're OPERATIONAL.
   */
- if (ohci->flags & OHCI_QUIRK_INITRESET) {
+ if (1 || ohci->flags & OHCI_QUIRK_INITRESET) {
   writel (ohci->hc_control, &ohci->regs->control);
   // flush those writes
   (void) ohci_readl (&ohci->regs->control);

