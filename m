Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262752AbSJCGct>; Thu, 3 Oct 2002 02:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262753AbSJCGct>; Thu, 3 Oct 2002 02:32:49 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4983 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262752AbSJCGcs>; Thu, 3 Oct 2002 02:32:48 -0400
Date: Thu, 3 Oct 2002 02:38:14 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: virt_to_page(pci_alloc_consistent())
Message-ID: <20021003023814.A5856@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

I just noticed that sound drivers use the address from
pci_alloc_consistent() as the input to virt_to_page() all
over the place. I looked into the Documentation/DMA-mapping.txt,
and it says:

  This routine will allocate RAM for that region, so it acts similarly to
  __get_free_pages (but takes size instead of a page order).

I know for fact I got it wrong in sparc in whole 2.4, and it seems
RMK got it wrong in arm. I suggest other architecture maintainers
to look at it ASAP. May even be oopsabe, by indexing outside of
mem_map[] with a suitable sound driver.

-- Pete
