Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbRETMNf>; Sun, 20 May 2001 08:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbRETMN0>; Sun, 20 May 2001 08:13:26 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:7174 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261868AbRETMNO>; Sun, 20 May 2001 08:13:14 -0400
Date: Sun, 20 May 2001 16:12:34 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520161234.B8223@jurassic.park.msu.ru>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru> <20010520044013.A18119@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010520044013.A18119@athlon.random>; from andrea@suse.de on Sun, May 20, 2001 at 04:40:13AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 04:40:13AM +0200, Andrea Arcangeli wrote:
> I was only talking about when you get the "pci_map_sg failed" because
> you have not 3 but 300 scsi disks connected to your system and you are
> writing to all them at the same time allocating zillons of pte, and one
> of your drivers (possibly not even a storage driver) is actually not
> checking the reval of the pci_map_* functions. You don't need a pte
> memleak to trigger it, even regardless of the fact I grown the dynamic
> window to 1G which makes it 8 times harder to trigger than in mainline.

I think you're too pessimistic. Don't mix "disks" and "controllers" --
SCSI adapter with 10 drives attached is a single DMA agent, not 10 agents.

If you're so concerned about Big Iron, go ahead and implement 64-bit PCI
support, it would be right long-term solution. I'm pretty sure that
high-end servers use mostly this kind of hardware.

Oh, well. This doesn't mean that I'm disagreed with what you said. :-)
Driver writers must realize that pci mappings are limited resources.

Ivan.
