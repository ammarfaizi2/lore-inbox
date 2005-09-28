Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVI1UX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVI1UX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVI1UX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:23:27 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:39594 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1750775AbVI1UX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:23:26 -0400
X-ORBL: [69.107.75.50]
Date: Wed, 28 Sep 2005 13:23:14 -0700
From: David Brownell <david-b@pacbell.net>
To: rjw@sisk.pl, daniel.ritz@gmx.ch
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Cc: torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org>
 <200509182349.17632.daniel.ritz@gmx.ch>
 <200509231852.15950.rjw@sisk.pl>
 <200509282205.49316.daniel.ritz@gmx.ch>
In-Reply-To: <200509282205.49316.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050928202314.54672E3723@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > BTW, please have a look at:
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c36
> > > > and
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c37

What's with the bogus dates in those reports ... claiming some of you
were testing 2.6.13-rc2-mm2 more than two months ago, mid-July ?????


> > > interesting. i'd say we get interrupt storms from usb which then hurt when
> > > yenta has it's handler installed but usb has not. usb/hcd-pci.c frees the
> > > irq on suspend...so it may be enough not to do that (survives suspend-to-ram
> > > and suspend-to-disk here. yes, restore too :)
> > > 
> > > could you give that a tree w/o any free_irq-patches for yenta and co?
> > 
> > I've tried and it apparently works provided that _none_ of the IRQ-sharing
> > devices drops the IRQ on suspend.
>
> ok. i didn't look too close, but i think ohci-hcd does not fully disable
> interrupts in it's suspend callback...needs a closer look.
> cc:ing linux-usb-devel...

It's handled in hcd-pci.c ... All PCI based HCDs release their IRQs
when they suspend.  Including OHCI.  Your diagnosis is incorrect.

- Dave


