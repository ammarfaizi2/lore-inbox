Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbTAAWtf>; Wed, 1 Jan 2003 17:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbTAAWte>; Wed, 1 Jan 2003 17:49:34 -0500
Received: from host194.steeleye.com ([66.206.164.34]:15629 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265187AbTAAWta>; Wed, 1 Jan 2003 17:49:30 -0500
Message-Id: <200301012257.h01Mvpq03439@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: rmk@arm.linux.org.uk
cc: parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: "vmalloc", friends and GFP flags 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Jan 2003 16:57:51 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've just been looking over the state of the ARM {dma,pci}_alloc_consis
> tent wrt interrupts etc in 2.5.53, and decided to have a look around
> this area for other users.  I stumbled across the following unsafe
> areas.

> a) parisc.  Looking at pa11_dma_alloc_consistent:

I agree with the flow analysis.  However, there is a condition attached to 
getting from pte_alloc_kernel to pte_alloc_one_kernel which makes the 
GFP_KERNEL allocation.  That condition looks to be that the pmd is not 
present.  I don't believe that's possible for an area of memory we just got 
from __get_free_pages (otherwise the kernel could fault when accessing that 
region which isn't allowed).

If the above analysis is correct (which I'll defer to better opinion) then we 
can in practice never get down the problem path, and dma_ allocation from 
interrupt is safe on parisc.

James


