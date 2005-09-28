Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVI1WEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVI1WEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVI1WEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:04:23 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:55778 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751097AbVI1WEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:04:23 -0400
X-ORBL: [69.107.75.50]
Date: Wed, 28 Sep 2005 15:04:09 -0700
From: David Brownell <david-b@pacbell.net>
To: rjw@sisk.pl
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Cc: torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, daniel.ritz@gmx.ch,
       akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org>
 <200509282237.12750.rjw@sisk.pl>
 <20050928205609.77623E371B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <200509282334.58365.rjw@sisk.pl>
In-Reply-To: <200509282334.58365.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050928220409.DE48BE3724@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My other point still stands though.  The IRQ for all HCDs _are_ freed
> > on suspend, and re-requested on resume ... so lack of such free/request
> > calls can't possibly be an issue.
>
> Yes it can.  Apparently on my box the call to request_irq() from a USB HCD
> driver (OHCI or EHCI) causes a screaming interrupt to be generated,
> which kills any other driver that shares the IRQ with the USB and has not
> called free_irq() on suspend.

So it's as I said:  _lack_ of such calls can't be an issue.

So _which_ device is generating this IRQ??


>	Of course this only happens with the patch
> at http://www.ussg.iu.edu/hypermail/linux/kernel/0507.3/2234.html
> unapplied, as it masks the problem.

Hmm, an ACPI patch.  With tabs completely trashed; that
mail archive needs to learn about <pre>...</pre.  :(


>		Actually it also depends on the
> order in which the drivers' resume routines are called, but unfortunately
> on my box the USB drivers' are called first.

Suggesting that the issue comes from the non-USB driver
sharing that IRQ line...

- Dave

