Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbTAATju>; Wed, 1 Jan 2003 14:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbTAATju>; Wed, 1 Jan 2003 14:39:50 -0500
Received: from host194.steeleye.com ([66.206.164.34]:60427 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261581AbTAATjt>; Wed, 1 Jan 2003 14:39:49 -0500
Message-Id: <200301011948.h01JmBo02789@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: akpm@digeo.com, James.Bottomley@SteelEye.com, david-b@pacbell.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update) 
In-Reply-To: Message from "Adam J. Richter" <adam@yggdrasil.com> 
   of "Wed, 01 Jan 2003 11:21:58 PST." <200301011921.LAA02354@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Jan 2003 13:48:11 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam@yggdrasil.com said:
> 	I thought Andrew Morton's request for a gfp flag was for allocating
> memory from a pool (for example, a "read ahead" will want to abort if
> memory is unavailable rather than wait).

Well, yes, but the underlying allocators will also have to take the flag too 
so that all the semantics are correct.


adam@yggdrasil.com said:
> 	Can someone show me or invent an example of two different uses of
> dma_alloc_coherent that really should use different policies on
> whether to block or not? 

The obvious one is allocations from interrupt routines, which must be 
GFP_ATOMIC (ignoring the issue of whether a driver should be doing a memory 
allocation in an interrupt).  Allocating large pools at driver initialisation 
should probably be GFP_KERNEL as you say.

James



