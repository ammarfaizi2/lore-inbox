Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTAXUSN>; Fri, 24 Jan 2003 15:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbTAXUSN>; Fri, 24 Jan 2003 15:18:13 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:55563 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S265134AbTAXUSM>; Fri, 24 Jan 2003 15:18:12 -0500
Date: Fri, 24 Jan 2003 15:24:53 -0500
From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@redhat.com>, willy@debian.org,
       linux-kernel@vger.kernel.org, Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030124152453.A4081@dsnt25.mro.cpqcorp.net>
References: <20030124212748.C25285@jurassic.park.msu.ru> <20030124193135.GA30884@gtf.org> <20030124150006.A2882@dsnt25.mro.cpqcorp.net> <20030124200538.GB30884@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030124200538.GB30884@gtf.org>; from jgarzik@pobox.com on Fri, Jan 24, 2003 at 03:05:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 03:05:38PM -0500, Jeff Garzik wrote:
> On Fri, Jan 24, 2003 at 03:00:06PM -0500, Wiedemeier, Jeff wrote:
> > The problem is that if the chip is configured for MSI (through config
> > space) and the platform's irq mapping code therefore filled in
> > pci_dev->irq with an appropriate vector for the MSI interrupt the chip
> > is assigned instead of the LSI interrupt it may also be assigned, then
> > unless MSGINT_MODE matches PCI_MSI_FLAGS_ENABLE, the driver will grab
> > wrong interrupt.
> 
> That implies we should be disabling PCI_MSI_FLAGS_ENABLE when we first
> initialize each board, if hardware reset does not automatically do that
> for us...

A true hardware reset does reset this bit. It should only be disabled
arbitrarily if the intent is to *never* use MSI. 

The PCI 2.2 spec states about PCI_MSI_FLAGS_ENABLE:

    If 1, the function is permitted to use MSI to request service
    and is prohibited from using it's INTx# pin (if implemented).

The fact that the tg3 has an extra config register that has to be set on
top of this is not consistent with the spec. 

If the intent is to just not use MSI on tg3 devices, I can use the pci
quirks to make sure that MSI gets turned off for tg3 devices.

/jeff
