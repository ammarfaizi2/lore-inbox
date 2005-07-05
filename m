Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVGETVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVGETVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVGETVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:21:52 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:1140 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S261577AbVGETVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:21:04 -0400
X-IronPort-AV: i="3.93,261,1115017200"; 
   d="scan'208"; a="196446071:sNHT29935028"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 11/16] IB uverbs: add mthca mmap support
X-Message-Flag: Warning: May contain useful information
References: <2005628163.o84QGfsM7oMSy0oU@cisco.com>
	<2005628163.gtJFW6uLUrGQteys@cisco.com>
	<20050628170553.00a14a29.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 05 Jul 2005 12:20:58 -0700
In-Reply-To: <20050628170553.00a14a29.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 28 Jun 2005 17:05:53 -0700")
Message-ID: <52mzp1oy91.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> What's the thinking behind the VM_DONTCOPY there?

As I said before, I don't think the thinking behind VM_DONTCOPY was
correct thinking.  Let's take it out.

I've now answered all your questions on this patchset (or at least
written something in response to all your questions ;).  What's your
feeling on merging?  If more info is required, just let me know.  I'll
also be at the kernel summit in a couple of weeks if you want to go
over it in person.

 - R.


There's no need to set VM_DONTCOPY when mmap()ing the hardware
doorbell page into userspace.

Signed-off-by: Roland Dreier <rolandd@cisco.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:28.000000000 -0700
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-07-05 12:14:20.838664330 -0700
@@ -347,7 +347,6 @@
 		return -EINVAL;
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vma->vm_flags    |= VM_DONTCOPY;
 
 	if (remap_pfn_range(vma, vma->vm_start,
 			    to_mucontext(context)->uar.pfn,
