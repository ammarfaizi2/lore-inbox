Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946113AbWBDAGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946113AbWBDAGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946114AbWBDAGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:06:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63724 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946113AbWBDAGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:06:41 -0500
Date: Fri, 3 Feb 2006 16:06:35 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: Adam Litke <agl@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [HUGETLB] Add comment explaining reasons for Bus Errors 
Message-ID: <Pine.LNX.4.62.0602031604030.2779@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just spent some time researching a Bus Error. Turns out 
that the huge page fault handler can return VM_FAULT_SIGBUS for various
conditions where no huge page is available.

Add a note explaining the reasoning in the source.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc2/mm/hugetlb.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/hugetlb.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/hugetlb.c	2006-02-03 16:03:20.000000000 -0800
@@ -444,6 +444,15 @@ retry:
 		page = alloc_huge_page(vma, address);
 		if (!page) {
 			hugetlb_put_quota(mapping);
+			/*
+		 	 * No huge pages available. So this is an OOM
+			 * condition but we do not want to trigger the OOM
+			 * killer, so we return VM_FAULT_SIGBUS.
+			 *
+			 * A program using hugepages may fault with Bus Error
+			 * because no huge pages are available in the cpuset, per
+			 * memory policy or because all are in use!
+			 */
 			goto out;
 		}
 
