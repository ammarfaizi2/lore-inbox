Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310119AbSCFSkd>; Wed, 6 Mar 2002 13:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310115AbSCFSkX>; Wed, 6 Mar 2002 13:40:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23295 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310127AbSCFSkK>;
	Wed, 6 Mar 2002 13:40:10 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] struct page shrinkage
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFC19C560E.A00F9111-ON85256B74.006633D4@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Wed, 6 Mar 2002 13:41:51 -0500
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/06/2002 01:39:56 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>> Andrew,
>> I have an application which needs to know the total number of locked and
>> dirtied pages at any given time.  In which application locked-page
>> accounting is done?   I don't see it in base 2.5.5.   Are there any
patches
>> or such that you can give pointers to?
>
>This is in the ebulliently growing delayed-allocate and
>buffer_head-bypass patches at
>
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre2/
>
>The implementation you're looking for is in dalloc-10-core.patch:
>mm.h and mm/page_alloc.c

extern struct page_state {
             unsigned long nr_dirty;
             unsigned long nr_locked;
} ____cacheline_aligned page_states[NR_CPUS];

This is perfect.   Looks like, if a run summation over all the CPUs I will
get the total locked and dirty pages, provided mm.h macros are respected.
What is the outlook for inclusion of this patch in the main kernel?  Do you
plan to submit or have been included yet?
Bulent




