Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUFWWUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUFWWUN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUFWWS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:18:59 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:28100 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262370AbUFWWRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:17:37 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: More bug fix in mm/hugetlb.c - fix try_to_free_low() 
In-reply-to: Your message of "Wed, 23 Jun 2004 12:42:43 MST."
             <20040623194243.GB1552@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 Jun 2004 08:17:29 +1000
Message-ID: <10650.1088029049@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 12:42:43 -0700, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>On Wed, Jun 23, 2004 at 12:33:00PM -0700, Chen, Kenneth W wrote:
>> The argument "count" passed to try_to_free_low() is the config parameter
>> for desired hugetlb page pool size.  But the implementation took that
>> input argument as number of pages to free. It also decrement the config
>> parameter as well.  All give random behavior depend on how many hugetlb
>> pages are in normal/highmem zone.
>> A two line fix in try_to_free_low() would be:
>
>Thanks for cleaning this up; there hasn't been much apparent interest
>here lately so I've not gotten much in the way of bugreports to work.

While we are discussing hugetlb, what is the official method of
identifying a hugetlb page - at the page level, not through a vma?

When taking a crash dump, hugetlb pages must be treated as user data,
not as kernel pages.  LKCD must be able to identify hugetlb pages from
the page struct, dumping cannot assume that any mm context is valid so
vma scans are out.  The identification method must work whether the
hugetlb pages are in use or not.  In 2.4 LKCD I added PG_hugetlb, but I
would prefer a test that did not require yet another PG flag.

