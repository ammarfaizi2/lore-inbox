Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292582AbSCELTG>; Tue, 5 Mar 2002 06:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292872AbSCELS6>; Tue, 5 Mar 2002 06:18:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24192 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292582AbSCELSr>;
	Tue, 5 Mar 2002 06:18:47 -0500
Date: Tue, 05 Mar 2002 03:16:36 -0800 (PST)
Message-Id: <20020305.031636.63129004.davem@redhat.com>
To: adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200203051112.DAA03159@adam.yggdrasil.com>
In-Reply-To: <200203051112.DAA03159@adam.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Tue, 5 Mar 2002 03:12:52 -0800

   If not, then I guess I can use
   pci_alloc_consistent and pci_map_single as necessary, since they
   should can potentially know that I am using a device that
   only understands 32-bit addresses, from my earlier call to
   pci_set_dma_mask.  However, I assume that it is considered
   simpler and therefore better to avoid these routines when possible.

Just use pci_alloc_consistent, it never gives you
anything larger than 32-bit addresses, please read the
documentation :-)

On 64-bit platforms without CONFIG_HIGHMEM, kmalloc can return any
pointer, but that is fine since your DMA mask will instruct the
IOMMU layer of the platform to map it in the low 32-bits of DMA
address space.

If you follow DMA-mapping.txt to the letter, it will just work, trust
us. :-)
