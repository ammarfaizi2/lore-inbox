Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbSJCIF2>; Thu, 3 Oct 2002 04:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263194AbSJCIF2>; Thu, 3 Oct 2002 04:05:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39119 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263193AbSJCIF0>;
	Thu, 3 Oct 2002 04:05:26 -0400
Date: Thu, 03 Oct 2002 01:03:44 -0700 (PDT)
Message-Id: <20021003.010344.123986131.davem@redhat.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: virt_to_page(pci_alloc_consistent())
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021003023814.A5856@devserv.devel.redhat.com>
References: <20021003023814.A5856@devserv.devel.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Thu, 3 Oct 2002 02:38:14 -0400

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

I think we MUST allow architectures to do what SPARC and ARM
do, there is simply no other way to change the page protections
easily for these kinds of systems.

So please instead change the DMA-mapping.txt documentation and
propose pci_consistent_to_page(ptr) API additions.  Next, inform
the subsytems trying to use virt_to_page() on this memory that
they need to use the new interface.
