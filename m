Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVGQR6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVGQR6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 13:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVGQR6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 13:58:53 -0400
Received: from totor.bouissou.net ([82.67.27.165]:38553 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261332AbVGQR6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 13:58:52 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: bjorn.helgaas@hp.com,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
Date: Sun, 17 Jul 2005 19:58:49 +0200
User-Agent: KMail/1.7.2
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C5D@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C5D@USRV-EXCH4.na.uis.unisys.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, liste@jordet.nu,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507171958.49770@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Natalie Protasevich and Alan Stern have worked a lot on helping me out with a 
VIA KT400 chipset / kernel 2.6.12 / IO-APIC / IRQ problem "irq 21: nobody 
cared!", which so far hasn't found its solution.

Research done with Alan shows that, on my system, the USB 2.0 controller seems 
to generate interrupts on the IRQ line attributed to the USB 1.1 controller, 
which isn't supposed to happen, and puzzles the system, when IO-APIC is 
enabled.

However, this didn't cause problems with 2.4 series kernels.

For the time being, there is no solution (Natalie is still investigating 
this), and it boils down to the following:

- If I boot with USB 2.0 enabled in BIOS, AND IO-APIC enabled in the kernel, 
then it badly breaks.

- If I either disable USB 2.0 in BIOS, or IO-APIC in the kernel, then it's OK.

I found today the thread between Bjorn Helgaas and Mathieu Bérard on LKML, 
where Mathieu reported the same problem, and Bjorn advised him to reverse a 
kernel patch (http://lkml.org/lkml/2005/6/21/243 ).

Mathieu (I don't have his email address, Bjorn, could you be so kind to 
forward this message to him) reports that it apparently solved this problem, 
so I tried to do the same, and reversed the same patch.

At first boot it seems to solve the issue, but when I rebooted again, it broke 
again, so this is not the solution -- the problem is not completely stable, 
sometimes it doesn't happen for some reason unknown to me... But most of the 
times it _does_ happen :-/

So this message is to inform different people who have suffered from this same 
problem, or are working for finding it a fix...

I'll be on travel for the coming week, and may or may not have occasional 
access to my email. (Please copy me on answers, as I'm not subscribed to the 
linux-kernel ML).

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
