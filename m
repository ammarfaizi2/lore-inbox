Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130886AbQL2NUv>; Fri, 29 Dec 2000 08:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbQL2NUl>; Fri, 29 Dec 2000 08:20:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56585 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130886AbQL2NUg>;
	Fri, 29 Dec 2000 08:20:36 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012291152.eBTBq9x02036@flint.arm.linux.org.uk>
Subject: test13-pre5: Double flush_cache_page?
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Dec 2000 11:52:08 +0000 (GMT)
Cc: riel@nl.linux.org
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is the following really intentional?

vmscan.c:122:

        flush_cache_page(vma, address);
        if (!pte_dirty(pte))
                goto drop_pte;
	...
        flush_cache_page(vma, address);
        if (page->mapping) {

Nothing accesses the actual page between the two flush_cache_page() calls,
the first one was added in test13-pre5.  Should test13-pre5 have removed
the second instance?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
