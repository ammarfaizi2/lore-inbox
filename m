Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTJXWSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJXWRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:17:31 -0400
Received: from fmr05.intel.com ([134.134.136.6]:19662 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262707AbTJXWRE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:17:04 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Date: Fri, 24 Oct 2003 15:16:59 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0F36EB@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Thread-Index: AcOaelSj4zW77pNrSfqx6OyOYFRcVQAAWzJA
From: "Luck, Tony" <tony.luck@intel.com>
To: <davidm@hpl.hp.com>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
X-OriginalArrivalTime: 24 Oct 2003 22:16:59.0965 (UTC) FILETIME=[8B447ED0:01C39A7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Tony> This patch was accepted into 2.5.55, attributed to "davej@uk".
>   Tony> This code will prefetch from beyond the end of the page table
>   Tony> being cleared ... which is clearly a bad thing if the page
>   Tony> table in question is allocated from the last page of memory
>   Tony> (or precedes a hole on a discontig mem system).
> 
> Different arches behave differently, though.  In the case of ia64,
> it'a always safe to prefetch (even with lfetch.fault).

Not quite always ... this was how I found the efi trim.bottom bug, since
Linux had allocated a pgd at 0xa00000-16k, and the lfetch that reached
out beyond the end of the page to the uncacheable address 0xa00000 took
an MCA.

A pgd in the last page of a granule that is followed by an uncacheable
address would do the same with lfetch.fault, wouldn't it?

-Tony
