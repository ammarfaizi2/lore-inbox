Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTERTGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 15:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTERTGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 15:06:49 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:8710 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S262163AbTERTGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 15:06:48 -0400
Date: Sun, 18 May 2003 21:26:33 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SIS-650+CPQ Presario 3045US+USB ...
In-Reply-To: <Pine.LNX.4.55.0305172022440.4235@bigblue.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0305181052210.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 May 2003, Davide Libenzi wrote:

> I've spent a few horrible hours terrified by the idea of a possible XP
> install on my new laptop. It's a Compaq Presario 3045US with SIS-650
> chipset and there was no way to have USB bits work with it because of a
> IRQ routing issue.

What are the device/revision id's of the pci irq router function?

> The PCI routing table of that machine issues requests
> for 0x60, 0x61 and 0x63 that, to have everything to work out, must be
> handled like the 0x4* cases.

This sounds different wrt. what we have documented for the older 85C503 
ISA bridge which is used in the 5595 chipset family.

> Now, while 0x60 and 0x63 were ot documented
> at all, 0x61 was documented as IDEIRQ and I was a bit worried about that.

0x61=IDEIRQ / 0x62=USBIRQ is definitely correct for the 5595/85C503 rev 01 
- according to the data sheet and playing with setpci ;-)

> But this is not the case since the machine issue 0x60..0x63 for the four
> OHCI devices. Now USB is working great with keyboard, mouse and drives. I
> still have to say bye to the Broadcom 54g wireless interface though ...

Looks like your chipset uses a different irq routing register layout. When 
the existing sis pci-irq routing stuff was added, the primary concern was 
to handle the ambigous link values (0x40-43 vs. 0x00-03) used by different 
BIOS's. The IDEIRQ case was merely added for documentation, it's unused.

I think this might need some special treatment in pirq_sis_[sg]et(), 
either checking for the revision id or a different pci device id.

Btw, have you tried with acpi interrupt routing enabled?

Martin

