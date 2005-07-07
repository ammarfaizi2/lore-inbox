Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVGGNG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVGGNG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVGGMtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:49:03 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:47007 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S261449AbVGGMsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:48:02 -0400
Date: Thu, 7 Jul 2005 15:47:58 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 hangs at boot
In-Reply-To: <20050707163140.A4006@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.4.58.0507071546560.29406@tukki.cc.jyu.fi>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
 <9e47339105070618273dfb6ff8@mail.gmail.com> <20050707135928.A3314@jurassic.park.msu.ru>
 <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi> <20050707163140.A4006@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Thu, 07 Jul 2005 15:47:59 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Ivan Kokshaysky wrote:

> On Thu, Jul 07, 2005 at 01:33:46PM +0300, Tero Roponen wrote:
> > 00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 02)
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> > 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
> > 	Latency: 64
> > 	Region 0: Memory at <unassigned> (32-bit, prefetchable)
> 			    ^^^^^^^^^^^^
> I'd bet this is the cause of your problem.
> The pci_assign_unassigned_resources() is not aware of potential
> problems with i386 host bridges and just reassigns this region.
> Which effectively turns the DMA off on your machine, I guess.
>
> The patch here (against clean 2.6.13-rc2) should fix that.
>
> Ivan.

Hi,

I just tested the patch, but it didn't help. It still hangs.

-
Tero Roponen
