Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVHCM3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVHCM3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVHCM3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:29:16 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:62359 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262246AbVHCM3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:29:15 -0400
Subject: Re: BTTV - experimental no_overlay patch
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Burgess <aab@cichlid.com>, LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <20050803060640.GC1399@elf.ucw.cz>
References: <1123040424.5607.46.camel@localhost>
	 <20050803060640.GC1399@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 03 Aug 2005 09:29:05 -0300
Message-Id: <1123072145.9082.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

Em Qua, 2005-08-03 às 08:06 +0200, Pavel Machek escreveu:
> Hi!
> 
> > 	This small patch will allow no_overlay flag to disable BTTV driver to
> > report OVERLAY capabilities. It should fix your troubles by enabling
> > no_overlay=1 when inserting bttv module.
> > 
> > 	This patch is against our CVS tree, but should apply with some hunk on
> > 2.6.13-rc4 or 2.6.13-rc5.
> > 
> > 	I'll generate a new one at morning, against 2.6.13-rc5 hopefully to
> > have it applied at 2.6.13, since it fixes an OOPS.
> 
> You have to pass option for it not to oops? That does not seem
> right....
	This OOPS is caused by bad implementation of PCI2PCI data transfers
(hardware related). It is not related to V4L.

	In fact, bttv code uses also a blacklist from PCI code, activating
no_overlay option on bad chipsets:

void __devinit bttv_check_chipset(void)
{
        int pcipci_fail = 0;
        struct pci_dev *dev = NULL;

        if (pci_pci_problems & PCIPCI_FAIL)
                pcipci_fail = 1;

...
        if (pcipci_fail) {
                printk(KERN_WARNING "bttv: BT848 and your chipset may
not work together.\n");
                if (!no_overlay) {
                        printk(KERN_WARNING "bttv: going to disable
overlay.\n");
                        no_overlay = 1;
                }
        }

	I don't know for sure if these new chipsets are at PCI fail blacklist.
After Bodo and Andrew Burgess made these tests, we may submit some info
to PCI guys for them to add the chipsets to PCI blacklist, by setting
PCIPCI_FAIL flag at pcipci_fail global var.

Mauro.

