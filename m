Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVF0W7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVF0W7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVF0W5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:57:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262086AbVF0W4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:56:47 -0400
Date: Mon, 27 Jun 2005 15:55:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Randy Dunlap <rdunlap@xenotime.net>, torvalds@osdl.org,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       Hugh Dickins <hugh@veritas.com>, linux-os@analogic.com
Subject: [03/07] fix remap_pte_range BUG
Message-ID: <20050627225556.GL9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627224651.GI9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

Out-of-tree user of remap_pfn_range hit kernel BUG at mm/memory.c:1112!
It passes an unrounded size to remap_pfn_range, which was okay before
2.6.12, but misses remap_pte_range's new end condition.  An audit of
all the other ptwalks confirms that this is the only one so exposed.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>

--- 2.6.12/mm/memory.c	2005-06-17 20:48:29.000000000 +0100
+++ linux/mm/memory.c	2005-06-21 20:31:42.000000000 +0100
@@ -1164,7 +1164,7 @@ int remap_pfn_range(struct vm_area_struc
 {
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long end = addr + size;
+	unsigned long end = addr + PAGE_ALIGN(size);
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
 

