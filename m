Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268503AbUIXGHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268503AbUIXGHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUIXGHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:07:09 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:11177 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S268306AbUIXGFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:05:32 -0400
From: David Brownell <david-b@pacbell.net>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.9-rc2-mm2 ohci_hcd doesn't work
Date: Thu, 23 Sep 2004 23:04:51 -0700
User-Agent: KMail/1.6.2
Cc: Roman Weissgaerber <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net,
       David Brownell <dbrownell@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200409231457.16979.bjorn.helgaas@hp.com>
In-Reply-To: <200409231457.16979.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409232304.51478.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2004 1:57 pm, Bjorn Helgaas wrote:
> 
>  ACPI: PCI interrupt 0000:00:0f.2[A] -> GSI 10 (level, low) -> IRQ 10
>  ohci_hcd 0000:00:0f.2: ServerWorks OSB4/CSB5 OHCI USB Controller
>  ohci_hcd 0000:00:0f.2: irq 10, pci mem 0xf5e70000
>  ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
>  ohci_hcd 0000:00:0f.2: init err (00002edf 0000)

The "2edf" is fine but the "0000" isn't what was _just_ written
to that second register ... some chips are a bit tricky about
initialization.  Ideally, OHCI_QUIRK_INITRESET would be set
for those chips ... the need for that is new, Linux previously
did it in all cases even though only a few implementations
seemed to want it.  (And some strongly dislike it.)

Maybe ServerWorks needs it.  The flag is tested in ohci-hcd.c;
what happens if you kick in that quirk handling?

- Dave

>  ohci_hcd 0000:00:0f.2: can't start
>  ohci_hcd 0000:00:0f.2: init error -75
>  ohci_hcd 0000:00:0f.2: remove, state 0
>  ohci_hcd 0000:00:0f.2: USB bus 1 deregistered
>  ohci_hcd: probe of 0000:00:0f.2 failed with error -75

