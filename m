Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUGHCOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUGHCOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 22:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUGHCOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 22:14:23 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:49248 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265454AbUGHCOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 22:14:21 -0400
Message-ID: <40ECADF8.7010207@yahoo.com.au>
Date: Thu, 08 Jul 2004 12:14:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com>
In-Reply-To: <m2brir9t6d.fsf@telia.com>
Content-Type: multipart/mixed;
 boundary="------------070203090708030908090003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070203090708030908090003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Peter Osterlund wrote:
> I created a test program that allocates a 300MB buffer and writes to
> all bytes sequentially. On my computer, which has 256MB RAM and 512MB
> swap, the program gets OOM killed after dirtying about 140-180MB, and
> the kernel reports:
> 

Someone hand me a paper bag... Peter, can you give this patch a try?

--------------070203090708030908090003
Content-Type: text/x-patch;
 name="vm-allocfail-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-allocfail-fix.patch"




---

 linux-2.6-npiggin/mm/vmscan.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~vm-allocfail-fix mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-allocfail-fix	2004-07-08 12:10:29.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-07-08 12:12:33.000000000 +1000
@@ -917,12 +917,12 @@ int try_to_free_pages(struct zone **zone
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
 		}
-		if (sc.nr_reclaimed >= SWAP_CLUSTER_MAX) {
+		total_scanned += sc.nr_scanned;
+		total_reclaimed += sc.nr_reclaimed;
+		if (total_reclaimed >= SWAP_CLUSTER_MAX) {
 			ret = 1;
 			goto out;
 		}
-		total_scanned += sc.nr_scanned;
-		total_reclaimed += sc.nr_reclaimed;
 
 		/*
 		 * Try to write back as many pages as we just scanned.  This

_

--------------070203090708030908090003--
