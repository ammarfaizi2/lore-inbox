Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279589AbRJ2XIX>; Mon, 29 Oct 2001 18:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279593AbRJ2XIL>; Mon, 29 Oct 2001 18:08:11 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:52753 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279589AbRJ2XIB>; Mon, 29 Oct 2001 18:08:01 -0500
Date: Mon, 29 Oct 2001 18:08:37 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: please revert bogus patch to vmscan.c
Message-ID: <20011029180837.F25434@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following:

@@ -50,7 +50,6 @@
 
        /* Don't look at this pte if it's been accessed recently. */
        if (ptep_test_and_clear_young(page_table)) {
-               flush_tlb_page(vma, address);
                mark_page_accessed(page);
                return 0;
        }

is completely bogus.  Without the tlb flush, the system may never update 
the accessed bit on a page that is heavily being used.

		-ben
-- 
Fish.
