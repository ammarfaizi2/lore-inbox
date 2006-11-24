Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935086AbWKXVvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935086AbWKXVvI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935089AbWKXVvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:51:08 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36051
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S935086AbWKXVvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:51:06 -0500
Date: Fri, 24 Nov 2006 13:51:15 -0800 (PST)
Message-Id: <20061124.135115.26533586.davem@davemloft.net>
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Removal of pci_dma_* functions
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061124170359.GA9355@linux-mips.org>
References: <20061124170359.GA9355@linux-mips.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 24 Nov 2006 17:03:59 +0000

> A grep for
> 
>   pci_dac_dma_supported()
>   pci_dac_page_to_dma()
>   pci_dac_dma_to_page()
>   pci_dac_dma_to_offset()
>   pci_dac_dma_sync_single_for_cpu()
>   pci_dac_dma_sync_single_for_device()
> 
> reveals that only a some platforms implement these functions and there seems
> to be no single user.  Any objections against removing?  Or why did we ever
> add them anyay ...

They were meant for things like those Dolphin clustering cards that
can map arbitrary amounts of remote memory on the local system.

Unfortunately, none of the drivers for these things are upstream, but
I can nearly guarentee you that those drivers use these interfaces
because they map so much memory that they cannot tolerate the
limitations imposed by IOMMUs, even the ones with 2GB mapping windows
like on sparc64.
