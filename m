Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVI2AJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVI2AJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVI2AJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:09:35 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:28816 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751268AbVI2AJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:09:34 -0400
X-ORBL: [69.107.75.50]
Date: Wed, 28 Sep 2005 17:09:29 -0700
From: David Brownell <david-b@pacbell.net>
To: daniel.ritz@gmx.ch
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Cc: torvalds@osdl.org, rjw@sisk.pl, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org>
 <200509282334.58365.rjw@sisk.pl>
 <20050928220409.DE48BE3724@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <200509290032.26815.daniel.ritz@gmx.ch>
In-Reply-To: <200509290032.26815.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050929000929.2CEACE372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So it's as I said:  _lack_ of such calls can't be an issue.
>
> yep, but doing the free_irq() on suspend can be. and is in some cases.

Your other theory is more interesting:


> > So _which_ device is generating this IRQ??
>
> USB ohci controller having no handler. yenta shares the line, has the
> correct handler installer, sees the interrupt, does not handle it since
> it was not the cardbus bridge generating the interrupt but ohci.

You could try adding

	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);

near the end of ohci_pci_suspend().  

- Dave
