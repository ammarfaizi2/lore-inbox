Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310143AbSCKPNf>; Mon, 11 Mar 2002 10:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSCKPNY>; Mon, 11 Mar 2002 10:13:24 -0500
Received: from mailout.zma.compaq.com ([161.114.64.104]:63246 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S292840AbSCKPNK>; Mon, 11 Mar 2002 10:13:10 -0500
Date: Mon, 11 Mar 2002 10:02:00 -0500
From: Jay Estabrook <Jay.Estabrook@compaq.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Kurt Garloff <garloff@suse.de>, Jochen Friedrich <jochen@scram.de>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Subject: Re: Busmaster DMA broken in 2.4.18 on Alpha
Message-ID: <20020311100200.A1181@linux04.mro.cpqcorp.net>
In-Reply-To: <Pine.NEB.4.33.0203111049580.1675-100000@www2.scram.de> <20020311124511.J2346@nbkurt.etpnet.phys.tue.nl> <20020311171058.A9038@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020311171058.A9038@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Mon, Mar 11, 2002 at 05:10:58PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 05:10:58PM +0300, Ivan Kokshaysky wrote:
> On Mon, Mar 11, 2002 at 12:45:11PM +0100, Kurt Garloff wrote:
> > Unfortunately, your ISA card does not seem to be able to address 32 bits.
> > (I guess no non-on-chip ISA adapter will.)
> 
> No, the ability to address 32 bits is property of an ISA bridge, not
> of any particular ISA card or device. 

That's not quite true, either.

There are ISA cards, regardless of what ISA bus machine they are
plugged into, that are able to generate only something less than
32-bits worth of address. I believe that the Adaptec 1540 SCSI
controller is one of these, since I had some exposure to its
limitations a while ago; it can generate only 24-bit addresses, IIRC.

Since ISA devices don't have pci_dev structures, there's (currently)
no way to pass an ISA device-dependent DMA mask to the IOMMU routines.
Perhaps there needs to be an addition to the API that would allow
for this (pci_set_isa_device_dma_mask()) ???

> Most alphas do have 32-bit ISA DMA.

True. For those notable exceptions (XL, Ruffian, Nautilus), we can still
depend on the MAX_DMA_ADDRESS to override any device-dependent mask.

--Jay++

-----------------------------------------------------------------------------
Jay A Estabrook                            Alpha Engineering - LINUX Project
Compaq Computer Corp. - MRO1-2/K15         (508) 467-2080
200 Forest Street, Marlboro MA 01752       Jay.Estabrook@compaq.com
-----------------------------------------------------------------------------
