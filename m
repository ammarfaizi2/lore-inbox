Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSE3KF0>; Thu, 30 May 2002 06:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSE3KFZ>; Thu, 30 May 2002 06:05:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46006 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316542AbSE3KFY>;
	Thu, 30 May 2002 06:05:24 -0400
Date: Thu, 30 May 2002 02:49:59 -0700 (PDT)
Message-Id: <20020530.024959.65186398.davem@redhat.com>
To: adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does pci_alloc_consisent really need to zero memory?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200205300911.CAA01655@adam.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Thu, 30 May 2002 02:11:12 -0700

   	Is it really necessary for pci_alloc_consistent() to
   fill the memory that it returns with all zeroes?  I don't
   see anything in Documentation/DMA-mapping.txt that specifies
   it.  I have been on the lookout for drivers that rely on it
   for the past couple of months, and I haven't seen any.  It's
   only one line of code in arch/i386/kernel/pci-dma.c, but it
   is potentially a lot of cycles, even if only zeroes the
   space you requested (rather than the full pages that it
   actually allocates).

pci_alloc_consistent is so rare, I doubt it matters performance
wise.

I'd rather see a patch to DMA-mapping.txt that specifies the memory
returned is zeroed out, as this is what every implementation appears
to do.
