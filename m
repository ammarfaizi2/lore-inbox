Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291504AbSBHJgt>; Fri, 8 Feb 2002 04:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291508AbSBHJgj>; Fri, 8 Feb 2002 04:36:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55054 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291504AbSBHJgX>;
	Fri, 8 Feb 2002 04:36:23 -0500
Date: Fri, 8 Feb 2002 10:36:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Craig Rich <craig_rich@sundanceti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scatter Gather List Questions
Message-ID: <20020208103615.N4942@suse.de>
In-Reply-To: <3C62FE47.6020708@sundanceti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C62FE47.6020708@sundanceti.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07 2002, Craig Rich wrote:
> 	One question I can start with is, how do you use pci_dma_sg?
> 
> pci_map_sg(dev, sglist, nents, direction);
> 
> 	I'm assuming I supply the dev and direction fields. How about the nents 

Of course, dev being your pci device and direction the data direction --
PCI_DMA_TODEVICE etc, see linux/pci.h.

> field? Is that supposed to be the largest number of fragments I can 
> handle (that's what I assumed.) Finally, the sglist argument has me 

nents is the number if segments in the sglist you are supplying as well.
not the maximum number of entries the driver can handle.

> really confused. Do I have to create this structure in advance (and if 
> so how) or is pci_map_sg supposed to simply give me a pointer back via 
> the sglist argument (that's what I assumed, but that doesn't seem to be 
> the case unless I'm doing something else wrong.)

No you have to allocate this structure yourself.

> 	Also, were in the source code is pci_map_sg located? I'll admit I'm not 
> an expert at looking through the source code of an OS like Linux, but 
> I'm frustrated by the fact that a simple grep of /usr/src/linux-2.4.2 
> does not show where this function is coded.

You are not terribly good a grepping, it seems :-). The function is in
asm/pci.h, depending on the architecture you may have to look inside
arch/ for helpers too.

-- 
Jens Axboe

