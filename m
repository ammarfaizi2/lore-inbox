Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUFWW2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUFWW2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUFWW05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:26:57 -0400
Received: from fmr03.intel.com ([143.183.121.5]:17363 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263020AbUFWWZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:25:07 -0400
Message-Id: <200406232223.i5NMN8Y11517@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Keith Owens'" <kaos@sgi.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: More bug fix in mm/hugetlb.c - fix try_to_free_low() 
Date: Wed, 23 Jun 2004 15:24:29 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRZb+u87RcCnqWBS9WQZpyGkLRPKQAAI8VA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <10650.1088029049@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Keith Owens wrote on Wednesday, June 23, 2004 3:17 PM
>William Lee Irwin III <wli@holomorphy.com> wrote:
>>On Wed, Jun 23, 2004 at 12:33:00PM -0700, Chen, Kenneth W wrote:
>>> The argument "count" passed to try_to_free_low() is the config parameter
>>> for desired hugetlb page pool size.  But the implementation took that
>>> input argument as number of pages to free. It also decrement the config
>>> parameter as well.  All give random behavior depend on how many hugetlb
>>> pages are in normal/highmem zone.
>>> A two line fix in try_to_free_low() would be:
>>
>>Thanks for cleaning this up; there hasn't been much apparent interest
>>here lately so I've not gotten much in the way of bugreports to work.
>
>While we are discussing hugetlb, what is the official method of
>identifying a hugetlb page - at the page level, not through a vma?
>
>When taking a crash dump, hugetlb pages must be treated as user data,
>not as kernel pages.  LKCD must be able to identify hugetlb pages from
>the page struct, dumping cannot assume that any mm context is valid so
>vma scans are out.  The identification method must work whether the
>hugetlb pages are in use or not.  In 2.4 LKCD I added PG_hugetlb, but I
>would prefer a test that did not require yet another PG flag.

There is one flag already in the page structure: PG_compound.

- Ken


