Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWBVCxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWBVCxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWBVCxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:53:35 -0500
Received: from fmr21.intel.com ([143.183.121.13]:54155 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751131AbWBVCxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:53:35 -0500
Message-Id: <200602220253.k1M2rWg10346@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: IA64 non-contiguous memory space bugs
Date: Tue, 21 Feb 2006 18:53:32 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcY3RTV2RLzpbjZmR9yMXCkSFsznyAAEilzg
In-Reply-To: <20060222001359.GA23574@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Tuesday, February 21, 2006 4:14 PM
> First bug (confirmed many months ago by Chris Wedgwood) - you can get
> weird effects if you attempt to mmap() something into one of the
> address space gaps.  The ia64 outer wrapper for mmap2() tries to
> prevent it, but doesn't do a good enough job, it's still possible
> indirectly with shmat() and maybe mremap().  Basic trouble is that
> most of the checks applied by the generic code assume that everything
> between 0 and TASK_SIZE is valid.

Ha ha ha.

On ia64, the low level tlb fault handler (vhpt_miss and nested_dtlb_miss)
checks that all unused address bits (between REGION_NUMBER and PGDIR_SHIFT)
should be all zero.  If they are not zero, it will fall into page fault
handler and in there, ia64 should just send SEGV instead of happily hand
over a page.  Buggy buggy....

- Ken

