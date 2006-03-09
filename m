Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWCIMbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWCIMbz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWCIMbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:31:55 -0500
Received: from fmr23.intel.com ([143.183.121.15]:50407 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750786AbWCIMby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:31:54 -0500
Message-Id: <200603091231.k29CV9g20079@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <wli@holomorphy.com>, "'Andrew Morton'" <akpm@osdl.org>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] hugetlb strict commit accounting
Date: Thu, 9 Mar 2006 04:31:11 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZDcsAlIF67TLt7Td6AEhu3/tLl1QAAaUwQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20060309120631.GC9479@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, March 09, 2006 4:07 AM
> > Well, the reservation is already done at mmap time for shared mapping. Why
> > does kernel need to do anything at fault time?  Doing it at fault time is
> > an indication of weakness (or brokenness) - you already promised at mmap
> > time that there will be a page available for faulting.  Why check them
> > again at fault time?
> 
> You can't know (or bound) at mmap() time how many pages a PRIVATE
> mapping will take (because of fork()).  So unless you have a test at
> fault time (essentialy deciding whether to draw from "reserved" and
> "unreserved" hugepage pool) a supposedly reserved SHARED mapping will
> OOM later if there have been enough COW faults to use up all the
> hugepages before it's instantiated.

I see. But that is easy to fix.  I just need to do exactly the same
thing as what you did to alloc_huge_page.  I will then need to change
definition of 'reservation' to needs-in-the future (also an easy thing
to change).

The real question or discussion I want to bring up is whether kernel
should do it's own accounting or relying on traversing the page cache. 
My opinion is that kernel should do it's own accounting because it is
simpler: you just need to do that at mmap and ftruncate time.

- Ken

