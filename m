Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUHJI4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUHJI4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUHJIya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:54:30 -0400
Received: from fmr06.intel.com ([134.134.136.7]:4590 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263024AbUHJIwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:52:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Hugetlb demanding paging for -mm tree
Date: Tue, 10 Aug 2004 01:52:02 -0700
Message-ID: <01EF044AAEE12F4BAAD955CB750649430200560D@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hugetlb demanding paging for -mm tree
Thread-Index: AcR+ZzQidTr6O7e8QDqIbxZjl8E2CgATYwkg
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 10 Aug 2004 08:52:05.0799 (UTC) FILETIME=[4FE8D370:01C47EB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <> wrote on Monday, August 09, 2004 11:59 AM:

> Chen, Kenneth W <mailto:kenneth.w.chen@intel.com> wrote on Monday,
>>> I suppose this is fixable in update_mmu_cache() where it can check
>>> the type of pte and do appropriate sizing and other things.  ia64
>>> would have to check the address instead of looking at the pte.
> 
> On Mon, Aug 09, 2004 at 11:43:32AM -0700, Seth, Rohit wrote:
>> Why do we need update_mmu_cache for hugepages?
> 
> As things stand in mainline, it's not an obvious issue. Ken appears to
> be calling it for hugetlb in the ZFOD fault handling patches, which
> have the issue that it may behave badly in several respects when
> acting on large pages. The cache coherency bits in update_mmu_fault()
> are necessary in general, but mainline omits them. It should only
> result in intermittent failures on machines with sufficiently
> incoherent caches. 
> 

Will the flush_dcache_page for hugepages even on incoherent caches be
not enough.  And that flush_dcache_page should be done in alloc_hugepage
after clearing the page(or change the clear_highpage to
clear_user_high_page).
