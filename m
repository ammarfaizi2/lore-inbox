Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281360AbRLJWWa>; Mon, 10 Dec 2001 17:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284506AbRLJWWU>; Mon, 10 Dec 2001 17:22:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34182 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281360AbRLJWWO> convert rfc822-to-8bit;
	Mon, 10 Dec 2001 17:22:14 -0500
Date: Mon, 10 Dec 2001 22:12:31 -0800 (PST)
Message-Id: <20011210.221231.72737317.davem@redhat.com>
To: groudier@free.fr
Cc: axboe@suse.de, gibbs@scsiguy.com, LB33JM16@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011210194953.L2225-100000@gerard>
In-Reply-To: <20011210200302.GA13498@suse.de>
	<20011210194953.L2225-100000@gerard>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Mon, 10 Dec 2001 20:21:21 +0100 (CET)
   
   Btw, a 16 MB boundary limitation would have no significant impact on
   performance and would have the goodness of avoiding some hardware bugs not
   only on a few Symbios devices in my opinion. As we know, numerous modern
   cores still have rests of the ISA epoch in their guts. So, in my opinion,
   the 16 MB boundary limitation should be the default on systems where
   reliability is the primary goal.

Complications arrive when IOMMU starts to remap things into a virtual
32-bit bus space as happens on several platforms now.

Jen's block layer knows nothing about what we will do here, since
he only really has access to physical addresses.

Only after the pci_map_sg() call can you inspect DMA addresses and
apply such workarounds.
