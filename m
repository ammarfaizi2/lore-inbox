Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314094AbSEISqi>; Thu, 9 May 2002 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314095AbSEISqh>; Thu, 9 May 2002 14:46:37 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:61831 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314094AbSEISqg>; Thu, 9 May 2002 14:46:36 -0400
Date: Thu, 9 May 2002 13:46:28 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Patrick Mochel <mochel@osdl.org>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] PCI reorg fix
In-Reply-To: <Pine.LNX.4.33.0205091121450.762-100000@segfault.osdl.org>
Message-ID: <Pine.LNX.4.44.0205091338170.11642-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, Patrick Mochel wrote:

> Actually, the point _is_ to break everything. 
> 
> The fact that there are wrappers emulating old PCI behavior is the reason 
> the SCSI drivers don't use the 2.4 interface. If we provide wrappers for 
> alloc_consistent, they'll never change those, either. 

I surely can see your point there. However, new-style and old-style PCI 
init are conceptually different, and there's no easy way to emulate the 
old behavior on top of the new one. That is equivalent to saying that 
converting drivers is in many cases non-trivial. It's painful, and that's 
why it doesn't happen (or only slowly), unless you force people to do so.

However, the issue here is IMO different. Not having the wrappers only
means lots of trivial changes to the drivers, along the lines of

pci_set_dma_mask(pdev,) -> device_set_dma_mask(&pdev->dev,)

which is pointless IMO. Actually, as far as I understood things, the plan 
with the device tree is not expose it to drivers, but let them still
act on pci_dev / usb_dev / whatever, and only base the implementation of
struct pci_dev / usb/dev / ... on struct device.

So keeping these pci_* functions makes sense to me, only base the 
implementation on struct device.

--Kai


