Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263613AbUC3LMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUC3LMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:12:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:30350 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263615AbUC3LLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:11:35 -0500
Date: Tue, 30 Mar 2004 03:11:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: tehdely_lkml@metawire.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ohci1394 issues ( 2.6.5-rc2 and beyond )
Message-Id: <20040330031131.06f54c46.akpm@osdl.org>
In-Reply-To: <39a2add7e90d91e09dc3f15bd2ddeb76@localhost.localdomain>
References: <39a2add7e90d91e09dc3f15bd2ddeb76@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Baehr <tehdely_lkml@metawire.org> wrote:
>
> I'm running a linux 2.6.5-rc2-mm5 kernel atm... motherboard is an Abit 
> NF7-s with an onboard firewire controller (I assume Nforce2 chipset).
> 
> I get this loveliness everytime I modprobe ohci1394:
> 
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5]  
> MMIO=[e0084000-e00847ff]  Max
> Packet=[2048]
> Badness in get_phy_reg at drivers/ieee1394/ohci1394.c:238
> Call Trace:
>   [<f8bb710e>] get_phy_reg+0x10e/0x120 [ohci1394]
>   [<f8bb7f3c>] ohci_devctl+0x5c/0x5d0 [ohci1394]
>   [<c03f23c0>] common_interrupt+0x18/0x20
>   [<c0113d54>] delay_tsc+0x14/0x20
>   [<f8bba058>] ohci_irq_handler+0x588/0x830 [ohci1394]
>   [<c012643f>] do_timer+0xdf/0xf0
>   [<c010a8ca>] handle_IRQ_event+0x3a/0x70
>   [<c010ac85>] do_IRQ+0xd5/0x1b0

That's due to a debug patch in -mm which catches out code which calls
mdelay() from hard IRQ context.   It's considered to be unsociable.

But there's nothing very wrong here.

