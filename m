Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVLORao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVLORao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLORao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:30:44 -0500
Received: from [194.90.237.34] ([194.90.237.34]:6222 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S1750824AbVLORan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:30:43 -0500
Date: Thu, 15 Dec 2005 19:33:53 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel@vger.kernel.org
Subject: kmap_atomic slot collision
Message-ID: <20051215173353.GA29402@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I'm trying to use kmap_atomic from both interrupt and task context.
My idea was to do local_irq_save and then use KM_IRQ0/KM_IRQ1:
since I'm disabling interrupts I assumed that this should be safe.
The relevant code is here:
https://openib.org/svn/gen2/trunk/src/linux-kernel/infiniband/ulp/sdp/sdp_iocb.c

However, under stress I see errors from arch/i386/mm/highmem.c:42
        if (!pte_none(*(kmap_pte-idx)))
                BUG();

Apparently, my routine, running from a task context, races with
some other kernel code, and so I'm trying to use a slot that was not
yet unmapped.

Anyone has an idea on what I could be doing wrong?

Thanks,
-- 
MST
