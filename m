Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVCVX4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVCVX4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVCVXz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:55:58 -0500
Received: from fmr14.intel.com ([192.55.52.68]:44730 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262477AbVCVXx4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:53:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/5] freepgt: free_pgtables use vma list
Date: Tue, 22 Mar 2005 15:53:08 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03211851@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/5] freepgt: free_pgtables use vma list
Thread-Index: AcUvN10z8VZSW+koRlO1wnCnTklFswAAbd3A
From: "Luck, Tony" <tony.luck@intel.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: <hugh@veritas.com>, <nickpiggin@yahoo.com.au>, <akpm@osdl.org>,
       <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Mar 2005 23:53:10.0231 (UTC) FILETIME=[4D5A7670:01C52F3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>How it works is that it knows the extent in each direction
>where mappings do not exist.
>
>Once we know we have a clear span up to the next PMD_SIZE
>modulo (and PUD_SIZE and so on and so forth) we know we
>can liberate the page table chunks covered by such ranges.

Ok ... I see that now (I was mostly looking at free_pgtables()
and missed the conditional in the arglist that passes the
start of the next vma into free_pgd_range() as the ceiling
until we run out of vmas and pass in "ceiling".

But I'm still confused by all the math on addr/end at each
level.  Rounding up/down at each level should presumably be
based on the size of objects at the next level.  So the pgd
code should round using PUD_MASK, pud should use PMD_MASK etc.
Perhaps I missed some updates, but the version of the patch
that I have (and the simulator) is using PMD_MASK in the
pgd_free_range() function ... which is surely wrong.

-Tony
