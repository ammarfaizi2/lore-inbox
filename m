Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSLFQkx>; Fri, 6 Dec 2002 11:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbSLFQkw>; Fri, 6 Dec 2002 11:40:52 -0500
Received: from host194.steeleye.com ([66.206.164.34]:18444 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264771AbSLFQkv>; Fri, 6 Dec 2002 11:40:51 -0500
Message-Id: <200212061648.gB6GmNX01862@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "David S. Miller" <davem@redhat.com>
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Dec 2002 10:48:23 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These systems simply do not exist.

Yes, they do.  The parisc pcxs and pcxt processors are the prime example that 
has annoyed me for a while.  This has no ability to control the cache at the 
page level  (it doesn't even seem to allow fully disabling the processor 
cache---not that you'd want to do that).  The result is that it cannot ever 
return consistent memory, so pci_alloc_consistent always fails (see 
arch/parisc/kernel/pci-dma.c:fail_alloc_consistent).  I have one of these 
machines (A HP9000/715) and I maintain the driver for the SCSI chip, which 
also needs to work efficiently on the intel platform, which is what got me 
first thinking about the problem.

Let me say again:  I don't envisage any driver writer worrying about this edge 
case, unless they're already implementing work arounds for it now.

I plan to maintain the current pci_ DMA API exactly as it is, with no 
deviations.  Thus the dma_ API too can be operated in full compatibility mode 
with the pci_ API.  That's the design intent.  However, I want the dma_ API to 
simplify this driver edge case for me (and for others who have to maintain 
similar drivers), which is why it allows a deviation from the pci_ API *if the 
driver writer asks for it*.

James




