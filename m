Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310168AbSCKP4R>; Mon, 11 Mar 2002 10:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310171AbSCKP4H>; Mon, 11 Mar 2002 10:56:07 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:52746 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S310168AbSCKP4E>; Mon, 11 Mar 2002 10:56:04 -0500
Date: Mon, 11 Mar 2002 10:44:41 -0500
From: Jay Estabrook <Jay.Estabrook@compaq.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ink@jurassic.park.msu.ru, garloff@suse.de, jochen@scram.de,
        linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: Busmaster DMA broken in 2.4.18 on Alpha
Message-ID: <20020311104441.A1628@linux04.mro.cpqcorp.net>
In-Reply-To: <20020311124511.J2346@nbkurt.etpnet.phys.tue.nl> <20020311171058.A9038@jurassic.park.msu.ru> <20020311100200.A1181@linux04.mro.cpqcorp.net> <20020311.071656.15433588.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020311.071656.15433588.davem@redhat.com>; from davem@redhat.com on Mon, Mar 11, 2002 at 07:16:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 07:16:56AM -0800, David S. Miller wrote:
>    From: Jay Estabrook <Jay.Estabrook@compaq.com>
>    Date: Mon, 11 Mar 2002 10:02:00 -0500
>    
>    Since ISA devices don't have pci_dev structures, there's (currently)
>    no way to pass an ISA device-dependent DMA mask to the IOMMU routines.
>    Perhaps there needs to be an addition to the API that would allow
>    for this (pci_set_isa_device_dma_mask()) ???
> 
> What you could do currently is whip up a dummy pci_dev structure with
> the mask you want and pass that into the PCI dma routines.  So you
> could, for example, default to 24-bit DMA mask when you get "NULL"
> as pci_dev, but cook up a special one using a 32-bit DMA mask for the
> floppy ISA device in question.

Yup, that'd work, though it would put the floppy's resources in with
the PCI devices, rather than kept separate as ISA. Should work fine,
though.

> The idea in 2.5.x is to move to a generic struct device, at which time
> something like this can be done much more cleanly.

Sounds good, if only it'd compile on Alpha... ;-}

--Jay++

-----------------------------------------------------------------------------
Jay A Estabrook                            Alpha Engineering - LINUX Project
Compaq Computer Corp. - MRO1-2/K15         (508) 467-2080
200 Forest Street, Marlboro MA 01752       Jay.Estabrook@compaq.com
-----------------------------------------------------------------------------
