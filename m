Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbULANUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbULANUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 08:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbULANUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 08:20:05 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:45538 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261231AbULANUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 08:20:00 -0500
From: kernel-stuff@comcast.net
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OHCI1394:sleeping function called from invalid context [need idea for fixing]
Date: Wed, 01 Dec 2004 13:19:48 +0000
Message-Id: <120120041319.21474.41ADC4F3000DDF24000053E2220075894200009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 22 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay - So the dma_pool_destroy problem can be solved by schedule_work() (that's what I think allows to create and schedule work queues, correct me if I am wrong). For allocation - I think it cannot be scheduled as the driver needs memory then and there.  How can that be handled? (dma_pool_create doesn't seem to be taking any flags like SLAB_ATOMIC - which would have solved the problem..)

Thanks!

Parry


> Am Mittwoch, 1. Dezember 2004 06:22 schrieb kernel-stuff@comcast.net:
> > I am trying to debug  a problem with the OHCI1394 module. Basically i get 
> "sleeping function called from invalid context" in dmesg whenever I capture 
> video from my camcorder. Looking at the stack trace - dma_pool_create is called 
> from within IRQ handler - or so it seems. Similarly the ohci1394 module also 
> calls dma_pool_destroy in IRQ. This happens when I connect and disconnect the 
> camcorder.
> > I am thinking of ways to fix this - and have no clue so far. I fixed couple 
> other similar but easy-to-fix ones in ohci1394.c - by changing from GFP_KERNEL 
> to GFP_ATOMIC but this one looks more complicated - DMA Pool needs to be freed 
> when device disconnects - how to do this outside of the IRQ? More complicated 
> (to me of course :) is the allocaction part - driver needs a DMA pool on device 
> connect - no idea how to get it outside of the IRQ path.
> > 
> > Can anyone give an idea how to go about fixing this? Normally what's the 
> correct place for a module to call dma_pool_create/destroy?
> 
> You might switch to work queues.
> 
> 	HTH
> 		Oliver
