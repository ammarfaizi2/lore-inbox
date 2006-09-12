Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWILPcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWILPcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWILPcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:32:25 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:32148 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751326AbWILPcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:32:24 -0400
In-Reply-To: <4505F030.3020207@pobox.com>
References: <1157947414.31071.386.camel@localhost.localdomain>	 <200609111139.35344.jbarnes@virtuousgeek.org>	 <1158011129.3879.69.camel@localhost.localdomain>	 <4505DB10.7080807@pobox.com> <1158015394.3879.82.camel@localhost.localdomain> <4505F030.3020207@pobox.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <632CC6D1-65AB-448F-B680-06E350AFD432@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
Date: Tue, 12 Sep 2006 17:32:13 +0200
To: Jeff Garzik <jgarzik@pobox.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> prepare_to_read_dma_memory() is the operation that an ethernet  
> driver's RX code wants.  And this is _completely_ unrelated to  
> MMIO.  It just wants to make sure that the device and host are  
> looking at the same data.  Often this involves polling a DMA  
> descriptor (or index, stored inside DMA-able memory) looking for  
> changes.
>
> flush_my_writes_to_dma_memory() is the operation that an ethernet  
> driver's TX code wants, to precede either an MMIO "poke" or any  
> other non-MMIO operation where the driver needs to be certain that  
> the write is visible to the PCI device, should the PCI device  
> desire to read that area of memory.

Because those are the operations, those should be the actual
function names, too (well, prefixed with pci_).  Architectures
can implement them whatever way is appropriate, or perhaps default
to some ultra-strong semantics if they prefer;  driver writers
should not have to know about the underlying mechanics (like why
we need which barriers).


Segher

