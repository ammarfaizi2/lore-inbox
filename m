Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUHTUC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUHTUC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268692AbUHTUC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:02:58 -0400
Received: from pop.gmx.de ([213.165.64.20]:28382 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268696AbUHTUCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:02:41 -0400
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Reply-To: stefandoesinger@gmx.at
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Fri, 20 Aug 2004 22:01:54 +0200
User-Agent: KMail/1.6.2
References: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com> <41265443.9050800@optonline.net>
In-Reply-To: <41265443.9050800@optonline.net>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       Nathan Bryant <nbryant@optonline.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408202201.54083.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Something else to watch out for on ICH2 and similar chipsets is that, as
> long as the IRQ router is steering a PCI link onto a certain IRQ, LPC
> ISA device are blocked from triggering that IRQ via the SERIRQ protocol.
> But if we move the all the PCI links elsewhere, the SERIRQ is no longer
> blocked, and if some ISA LPC device is holding a high level, which
> normally wouldn't trigger IRQ's under ISA, then the IRQ line will get
> disabled because the PIC is probably set to level-trigger because it was
> PCI at one point. I've seen this happen with IRQ 12 when the BIOS
> decided there was no PS/2 mouse present so it could re-use the IRQ. The
> real cause is that the i850 has  a register that allows IRQ1 and IRQ12
> to be disabled on the LPC bus, and this register isn't restored on
> resume. This probably doesn't apply to IRQ11 on Stefan's system, though...
If I re-programm the IRQ to something else than IRQ10, the device doesn't 
resume too. So it's not only a problem of IRQ 11.

> Maybe it's time to look at the suspend/resume callbacks on the ipw2100
> driver, anyway.
The ipw2100 driver calls pci_disable_device in it's suspend handler. But I 
think the ipw2100 maintainers need help with suspend/resume because James 
Ketrenos can't test it on his own system.

I'll change another devices IRQ line to test if it's only an ipw2100 issue.

Stefan
