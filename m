Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUKPETY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUKPETY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 23:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUKPETY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 23:19:24 -0500
Received: from siaab2ab.compuserve.com ([149.174.40.130]:9557 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261756AbUKPETV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 23:19:21 -0500
Date: Mon, 15 Nov 2004 23:15:51 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Dropped patch: mm/mempolicy.c:sp_lookup()
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200411152318_MC3-1-8EBD-DEEE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea posted this one-liner a while ago as part of a larger patch.  He said
it fixed return of the wrong policy in some conditions.  Was this a valid fix?


--- linux-2.6.10-rc2/mm/mempolicy.c     2004-11-11 03:23:03.000000000 -0500
+++ edited/mm/mempolicy.c       2004-11-15 22:09:41.387881104 -0500
@@ -902,7 +902,7 @@ sp_lookup(struct shared_policy *sp, unsi
                struct sp_node *p = rb_entry(n, struct sp_node, nd);
                if (start >= p->end) {
                        n = n->rb_right;
-               } else if (end < p->start) {
+               } else if (end <= p->start) {
                        n = n->rb_left;
                } else {
                        break;


--Chuck Ebbert  15-Nov-04  22:20:16
