Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUA1FR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 00:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbUA1FR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 00:17:26 -0500
Received: from ozlabs.org ([203.10.76.45]:26501 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265856AbUA1FRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 00:17:12 -0500
Date: Wed, 28 Jan 2004 16:16:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Trivial cleanups to hugepage support
Message-ID: <20040128051607.GA21455@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.  These are some trivial cleanups to the hugepage
ppc64 support

===================================================================
--- working.orig/arch/ppc64/mm/hugetlbpage.c	2004-01-28 15:40:24.000000000 +1100
+++ working/arch/ppc64/mm/hugetlbpage.c	2004-01-28 15:40:47.000000000 +1100
@@ -654,10 +654,9 @@
 	unsigned long hpteflags, prpn, flags;
 	long slot;
 
-	ea &= ~(HPAGE_SIZE-1);
-
 	/* We have to find the first hugepte in the batch, since
 	 * that's the one that will store the HPTE flags */
+	ea &= HPAGE_MASK;
 	ptep = hugepte_offset(mm, ea);
 
 	/* Search the Linux page table for a match with va */
@@ -885,10 +884,11 @@
 			spin_unlock(&htlbpage_lock);
 		}
 		htlbpage_max = htlbpage_free = htlbpage_total = i;
-		printk("Total HugeTLB memory allocated, %d\n", htlbpage_free);
+		printk(KERN_INFO "Total HugeTLB memory allocated, %d\n",
+		       htlbpage_free);
 	} else {
 		htlbpage_max = 0;
-		printk("CPU does not support HugeTLB\n");
+		printk(KERN_INFO "CPU does not support HugeTLB\n");
 	}
 
 	return 0;


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
