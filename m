Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUEDV3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUEDV3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUEDV3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:29:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42383 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264501AbUEDV3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:29:38 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Tue, 4 May 2004 23:29:25 +0200
User-Agent: KMail/1.5.3
Cc: Allen Martin <AMartin@nvidia.com>, linux-kernel@vger.kernel.org,
       Ross Dickson <ross@datscreative.com.au>,
       Len Brown <len.brown@intel.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com> <200405040111.01514.bzolnier@elka.pw.edu.pl> <409806C6.3060300@pobox.com>
In-Reply-To: <409806C6.3060300@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405042329.25285.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 of May 2004 23:10, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > +/*
> > + * Fixup for C1 Halt Disconnect problem on nForce2 systems.
> > + *
> > + * From information provided by "Allen Martin" <AMartin@nvidia.com>:
> > + *
> > + * A hang is caused when the CPU generates a very fast CONNECT/HALT
> > cycle + * sequence.  Workaround is to set the SYSTEM_IDLE_TIMEOUT to 80
> > ns. + * This allows the state-machine and timer to return to a proper
> > state within + * 80 ns of the CONNECT and probe appearing together. 
> > Since the CPU will not + * issue another HALT within 80 ns of the initial
> > HALT, the failure condition + * is avoided.
> > + */
> > +static void __devinit pci_fixup_nforce2(struct pci_dev *dev)
>
> Minor nit:  is __devinit really needed?

No, it's not needed.

I was mislead by the fact that all fixups there are marked with __devinit.

> You're changing a northbridge or a southbridge, not a PCI card, I
> presume...?  That would only need to be done once, when the kernel is
> booted, regardless of CONFIG_HOTPLUG AFAICS.

Yep, the same is probably true for:

static void __devinit pci_fixup_i450nx(struct pci_dev *d)
static void __devinit pci_fixup_i450gx(struct pci_dev *d)
static void __devinit  pci_fixup_umc_ide(struct pci_dev *d)
static void __devinit  pci_fixup_latency(struct pci_dev *d)
static void __devinit pci_fixup_piix4_acpi(struct pci_dev *d)
static void __devinit pci_fixup_via_northbridge_bug(struct pci_dev *d)
static void __devinit pci_fixup_transparent_bridge(struct pci_dev *dev)

Bartlomiej

