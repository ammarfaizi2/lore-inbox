Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbWBVBcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbWBVBcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbWBVBcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:32:08 -0500
Received: from fmr23.intel.com ([143.183.121.15]:32397 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161145AbWBVBcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:32:06 -0500
Message-Id: <200602220132.k1M1Vxg09552@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: IA64 non-contiguous memory space bugs
Date: Tue, 21 Feb 2006 17:31:59 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcY3RTV2RLzpbjZmR9yMXCkSFsznyAABvSDQ
In-Reply-To: <20060222001359.GA23574@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Tuesday, February 21, 2006 4:14 PM
> Second problem is in the hugepage logic in free_pgtables()
> (mm/memory.c).  As far as I can tell it's complete crap, and only
> works by accident, for different accidental reasons on ppc64 and ia64,
> the only archs that have a non-trivial is_hugepage_only_range().
> Except that I'm not sure it does entirely work by accident on ia64:
> suppose a process has a hugepage mapping that begins some way after
> the beginning of the hugepage address range.  Before
> hugetlb_free_pgd_range() gets called on that area, it will be called
> on the next normal page VMA down - but with an end address at the
> beginning of the hugepage VMA and so extending into the hugepage
> address range.  I don't really understand the ia64 pagetable mapping
> stuff well enough to tell if that's dangerous or not.

I don't see any problem in the ia64 code.  The start and end address is
what the vma specified.  Floor and ceiling is just a hint for free_pgtables()
to free any left over page tables between vma holes (to prev and next).
As far as I can tell, the code looks fine.

- Ken

