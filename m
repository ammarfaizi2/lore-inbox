Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSLEOz6>; Thu, 5 Dec 2002 09:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSLEOz6>; Thu, 5 Dec 2002 09:55:58 -0500
Received: from host194.steeleye.com ([66.206.164.34]:54031 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261836AbSLEOz5>; Thu, 5 Dec 2002 09:55:57 -0500
Message-Id: <200212051503.gB5F3Q601998@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Gibson <david@gibson.dropbear.id.au>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from David Gibson <david@gibson.dropbear.id.au> 
   of "Thu, 05 Dec 2002 16:05:36 +1100." <20021205050536.GE1500@zax.zax> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Dec 2002 09:03:24 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david@gibson.dropbear.id.au said:
> But if you have the sync points, you don't need a special allocater
> for the memory at all - any old RAM will do.  So why not just use
> kmalloc() to get it. 

Because with kmalloc, you have to be aware of platform implementations.  Most 
notably that cache flush/invalidate instructions only operate at the level of 
certain block of memory (called the cache line width).  If kmalloc returns 
less than a cache line width you have the potential for severe cockups because 
of the possibility of interfering cache operations on adjacent kmalloc regions 
that share the same cache line.

the dma_alloc... function guarantees to avoid this for you by passing the 
allocation to the platform layer which knows the cache characteristics and 
requirements for the machine (and dma controller) you're using.

James


