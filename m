Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbULKRug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbULKRug (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbULKRud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:50:33 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:63964 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261982AbULKRuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:50:16 -0500
Subject: Re: PCI IRQ problems -- update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Paris <jim@jtan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041211173538.GA21216@jim.sh>
References: <20041211173538.GA21216@jim.sh>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102783555.7267.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Dec 2004 16:45:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-11 at 17:35, Jim Paris wrote:
> In short, all PCI IRQs are routed via ACPI to PIC IRQ 9.  When the
> PIIX IDE device is enabled, it pulls on that interrupt until it gets
> disabled ("nobody cared").  ide0 then continues to work on IRQ 14, but
> all other devices are broken since IRQ 9 is disabled.

The PIIX should be in legacy mode by default in which case it would be
on
IRQ 14/15 only. Can you post boot messages ?

> I'm not sure how to get to the root cause of the problem, though.  For
> starters: where _should_ the INTA of the IDE card go, if anywhere?  If

Quite possibly nowhere. IDE controllers have two modes one in which they
are normal PCI devices (and use INTA) and one in which they are "legacy"
compatible and use IRQ14/15 directly so they work with pre-PCI operating
systems.

> my laptop's IDE is routed to and pulling on IRQ 9, how can it still be
> functioning on IRQ 14?  Or, if the routing doesn't matter, is there
> anything I can do to prevent it from pulling on 9?

In legacy mode (the mode I would expect at boot) it shouldn't be using
INTA at all.

