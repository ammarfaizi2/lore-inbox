Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292859AbSCFBQI>; Tue, 5 Mar 2002 20:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292858AbSCFBPs>; Tue, 5 Mar 2002 20:15:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41604 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292854AbSCFBPr>;
	Tue, 5 Mar 2002 20:15:47 -0500
Date: Tue, 05 Mar 2002 17:13:33 -0800 (PST)
Message-Id: <20020305.171333.72710637.davem@redhat.com>
To: adam@yggdrasil.com
Cc: sp@scali.com, linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200203051708.JAA05742@adam.yggdrasil.com>
In-Reply-To: <200203051708.JAA05742@adam.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Tue, 5 Mar 2002 09:08:20 -0800

   Steffen Persvold writes:
   >I know pci_map_single (and _sg) will
   >use bounce buffers on platforms without an IOMMU [...]
   
   	For a moment I thought that must be the point that I
   was missing, but I don't see any such bounce buffer support
   in linux-2.5.6-pre2/include/asm-i386/pci.h or arch/i386/kernel/pci-dma.c.
   I do not see how this is currently implemented on x86 systems with >4GB
   of RAM.

You won't get HIGHMEM pages in your driver unless you are using
2.5.x and tell the scsi layer you are capable to DMA to/from
HIGHMEM pages.

Similarly for networking drivers, and setting NETIF_F_HIGHDMA in
the net device feature flags.
