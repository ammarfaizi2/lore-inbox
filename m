Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbULKRhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbULKRhE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbULKRg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:36:58 -0500
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:52963 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S261983AbULKRfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:35:42 -0500
Date: Sat, 11 Dec 2004 12:35:38 -0500
From: Jim Paris <jim@jtan.com>
To: linux-kernel@vger.kernel.org
Subject: PCI IRQ problems -- update
Message-ID: <20041211173538.GA21216@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update on my laptop's IRQ problem I mentioned back in Oct:
  http://lkml.org/lkml/2004/10/15/20
    
In short, all PCI IRQs are routed via ACPI to PIC IRQ 9.  When the
PIIX IDE device is enabled, it pulls on that interrupt until it gets
disabled ("nobody cared").  ide0 then continues to work on IRQ 14, but
all other devices are broken since IRQ 9 is disabled.

My previous solution was to use Alan Cox's "irqpoll" patch which
allowed the other devices to still function.  That's a hack and I
wanted to find a real way to fix it.

It turns out that IDE is the only device connected to LNKC.  I changed
the ACPI DSDT so that LNKC points to the unused IRQ 5, and all of my
problems magically went away.  This is still a hack, but seems to work.

I'm not sure how to get to the root cause of the problem, though.  For
starters: where _should_ the INTA of the IDE card go, if anywhere?  If
my laptop's IDE is routed to and pulling on IRQ 9, how can it still be
functioning on IRQ 14?  Or, if the routing doesn't matter, is there
anything I can do to prevent it from pulling on 9?

-jim
