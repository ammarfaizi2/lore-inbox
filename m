Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbTANPdE>; Tue, 14 Jan 2003 10:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTANPdE>; Tue, 14 Jan 2003 10:33:04 -0500
Received: from host194.steeleye.com ([66.206.164.34]:65031 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263544AbTANPdD>; Tue, 14 Jan 2003 10:33:03 -0500
Message-Id: <200301141541.h0EFfpA02417@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "David S. Miller" <davem@redhat.com>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Update arm implementation of DMA API to include GFP_
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Jan 2003 10:41:51 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James.Bottomley@SteelEye.com said:
> Is this really safe?  Maybe ARM needs to use GFP_ATOMIC all the time
> for a specific reason, such as where and how it maps the cpu side
> mappings of the memory? 

According to Russell King, yes.

The PA-RISC one should also be correct.  Actually, to be honest, there's a 
longstanding issue in the pa-risc code where we can potentially allocate a 
page table using GFP_KERNEL in pci_alloc_consistent() when we obtain the 
mapping resources.  I can argue that we never go down this path in practice, 
but it does make GFP_ATOMIC allocations look unsafe on the platform.

James


