Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSLaXj2>; Tue, 31 Dec 2002 18:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbSLaXj2>; Tue, 31 Dec 2002 18:39:28 -0500
Received: from host194.steeleye.com ([66.206.164.34]:11027 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264925AbSLaXj1>; Tue, 31 Dec 2002 18:39:27 -0500
Message-Id: <200212312347.gBVNlnK04199@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: Andrew Morton <akpm@digeo.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update) 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Tue, 31 Dec 2002 15:23:43 PST." <3E1226FF.9010407@pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Dec 2002 17:47:49 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david-b@pacbell.net said:
> USB device drivers tend to either allocate and reuse one dma buffer
> (kmalloc/kfree usage pattern) or use dma mapping ... so far. 

Please be careful with this in drivers.  Coherent memory can be phenomenally 
expensive to obtain on some hardware.  Sometimes it has to be implemented by 
turning off caching  and globally flushing the tlb.  Thus it really makes 
sense most of the time for drivers to allocate all the coherent memory they 
need initially and not have it go through the usual memory allocate/free cycle 
except under extreme conditions.  That's sort really what both pci_pool and 
mempool aim for.

James


