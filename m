Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264933AbRGEL5I>; Thu, 5 Jul 2001 07:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbRGEL46>; Thu, 5 Jul 2001 07:56:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5639 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264933AbRGEL4o>; Thu, 5 Jul 2001 07:56:44 -0400
Subject: Re: DMA memory limitation?
To: pvvvarma@techmas.hcltech.com (Vasu Varma P V)
Date: Thu, 5 Jul 2001 12:53:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (kernel Linux)
In-Reply-To: <3B4453E6.F4342781@techmas.hcltech.com> from "Vasu Varma P V" at Jul 05, 2001 05:17:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15I7hZ-0002Q3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any limitation on DMA memory we can allocate using
> kmalloc(size, GFP_DMA)? I am not able to acquire more than
> 14MB of the mem using this on my PCI SMP box with 256MB ram.
> I think there is restriction on ISA boards of 16MB.

Yes. GFP_DMA allocates memory below 16Mbytes for ISA devices and that is
a physical wiring issue. For PCI devices you can allocate a lot more using
the pci_alloc_* and pci_map_* interface to allocate memory for PCI in a
CPU independant manner. It'll also then look after cache coherency issues
for you

