Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUKGFEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUKGFEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 00:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKGFEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 00:04:45 -0500
Received: from siaag1af.compuserve.com ([149.174.40.8]:18560 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S261536AbUKGFEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 00:04:43 -0500
Date: Sun, 7 Nov 2004 00:02:06 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: balance_pgdat(): where is total_scanned ever updated?
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200411070004_MC3-1-8E11-3F5D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> I'm leaving this alone until it can be demonstrated that fixing it improves
> kernel behaviour in some manner.

How about applying this patch so nobody else will be confused?


diff -ur bk-current/mm/vmscan.c edited/mm/vmscan.c
--- bk-current/mm/vmscan.c      2004-11-06 23:02:48.691160680 -0500
+++ edited/mm/vmscan.c  2004-11-06 23:13:02.636826752 -0500
@@ -1071,10 +1071,13 @@
                        /*
                         * If we've done a decent amount of scanning and
                         * the reclaim ratio is low, start doing writepage
-                        * even in laptop mode
+                        * even in laptop mode.
+                        * NOTE: total_scanned is always zero; this code
+                        *       does nothing.  Reactivating it has not been
+                        *       shown to be helpful at the moment.
                         */
                        if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
-                           total_scanned > total_reclaimed+total_reclaimed/2)
+                           total_scanned > total_reclaimed + total_reclaimed / 2)
                                sc.may_writepage = 1;
                }
                if (nr_pages && to_free > total_reclaimed)
@@ -1084,6 +1087,7 @@
                /*
                 * OK, kswapd is getting into trouble.  Take a nap, then take
                 * another pass across the zones.
+                * NOTE: total_scanned is always zero.  See above.
                 */
                if (total_scanned && priority < DEF_PRIORITY - 2)
                        blk_congestion_wait(WRITE, HZ/10);



--Chuck Ebbert  06-Nov-04  23:35:37
