Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310155AbSCKPXo>; Mon, 11 Mar 2002 10:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310157AbSCKPXZ>; Mon, 11 Mar 2002 10:23:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55487 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310155AbSCKPXG>;
	Mon, 11 Mar 2002 10:23:06 -0500
Date: Mon, 11 Mar 2002 07:16:56 -0800 (PST)
Message-Id: <20020311.071656.15433588.davem@redhat.com>
To: Jay.Estabrook@compaq.com
Cc: ink@jurassic.park.msu.ru, garloff@suse.de, jochen@scram.de,
        linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: Busmaster DMA broken in 2.4.18 on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020311100200.A1181@linux04.mro.cpqcorp.net>
In-Reply-To: <20020311124511.J2346@nbkurt.etpnet.phys.tue.nl>
	<20020311171058.A9038@jurassic.park.msu.ru>
	<20020311100200.A1181@linux04.mro.cpqcorp.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jay Estabrook <Jay.Estabrook@compaq.com>
   Date: Mon, 11 Mar 2002 10:02:00 -0500
   
   Since ISA devices don't have pci_dev structures, there's (currently)
   no way to pass an ISA device-dependent DMA mask to the IOMMU routines.
   Perhaps there needs to be an addition to the API that would allow
   for this (pci_set_isa_device_dma_mask()) ???

What you could do currently is whip up a dummy pci_dev structure with
the mask you want and pass that into the PCI dma routines.  So you
could, for example, default to 24-bit DMA mask when you get "NULL"
as pci_dev, but cook up a special one using a 32-bit DMA mask for the
floppy ISA device in question.

The idea in 2.5.x is to move to a generic struct device, at which time
something like this can be done much more cleanly.
