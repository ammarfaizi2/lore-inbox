Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315546AbSEHXLQ>; Wed, 8 May 2002 19:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315547AbSEHXLP>; Wed, 8 May 2002 19:11:15 -0400
Received: from host194.steeleye.com ([216.33.1.194]:32004 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S315546AbSEHXLO>; Wed, 8 May 2002 19:11:14 -0400
Message-Id: <200205082311.g48NBAh01729@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: mochel@osdl.org, Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Problems with 2.5.14 PCI reorg and non-PCI architectures
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 May 2002 19:11:10 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

You've moved arch/i386/kernel/pci-dma.c under your pci subdirectory.  This 
means that it is now compiled in only when CONFIG_PCI is defined whereas 
previously it was always compiled.

This file contains all of the DMA memory manipulation functions (like 
pci_alloc_consistent et al.) which you need for device driver memory mapping 
even in a non PCI bus machine.

I think the solution is to move it back up to the i386/kernel level and make 
it always compiled in (perhaps keeping the name as dma.c, though).

James


