Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133019AbREHVCL>; Tue, 8 May 2001 17:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135363AbREHVBv>; Tue, 8 May 2001 17:01:51 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:36735 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S133019AbREHVBk>; Tue, 8 May 2001 17:01:40 -0400
Date: Tue, 8 May 2001 17:01:14 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: david-b@pacbell.net
Cc: johannes@erdfelt.com, zaitcev@redhat.com, rmk@arm.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: pci_pool_free from IRQ
Message-ID: <20010508170114.A29075@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Russel King complained that you might be calling pci_consistent_free
from an interrupt, which is unsafe on ARM. Why don't you remove this
part from pci_pool_free():

+       else if (!is_page_busy (pool->blocks_per_page, page->bitmap))
+               pool_free_page (pool, page);

In that case, fully free pages will stick about until the whole
pool is destroyed, which I think is not a big deal.

-- Pete
