Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTKYCEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 21:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTKYCEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 21:04:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:9385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261825AbTKYCEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 21:04:42 -0500
Date: Mon, 24 Nov 2003 18:03:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: jt@hpl.hp.com
cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Pavel Roskin <proski@gnu.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
In-Reply-To: <20031124235727.GA2467@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0311241759470.1599@home.osdl.org>
References: <20031124235727.GA2467@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 24 Nov 2003, Jean Tourrilhes wrote:
>
> 	I have a new Ricoh PCI-Carbus bridge and the kernel
> 2.6.0-test9 doesn't seem to configure it properly (see below).

Have you tried with ACPI? And conversely, if you're already using ACPI for
PCI irq routing, have you tried with "pci=noacpi"?

Basically, it looks like there is no irq routing information for the chip.
Which is deadly for any PCI device - we can figure out pretty much
everything else, but not the irq.

We don't ever try to autoprobe for PCI interrupts, because it's fragile
and tends to cause lockups on any hardware where the irq is shared with
something else. So PCI devices require irq routing information somewhere
(usually PIRQ table in the BIOS or the ACPI tables).

		Linus
