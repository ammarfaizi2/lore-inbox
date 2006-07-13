Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWGMUic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWGMUic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWGMUib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:38:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:34572 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030370AbWGMUia convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:38:30 -0400
X-IronPort-AV: i="4.06,238,1149490800"; 
   d="scan'208"; a="64869277:sNHT60308584"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] ia64: race flushing icache in COW path
Date: Thu, 13 Jul 2006 13:37:17 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A38D779@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ia64: race flushing icache in COW path
Thread-Index: AcamslW5J8dUR33nQce/hZIaChx5QwACHOfA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jason Baron" <jbaron@redhat.com>
Cc: <torvalds@osdl.org>, <akpm@osdl.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
X-OriginalArrivalTime: 13 Jul 2006 20:37:18.0613 (UTC) FILETIME=[224C5C50:01C6A6BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lazy_mmu_prot_update() is used in a number of other places *after* the pte 
> is established. An explanation as to why this case is different, would be 
> interesting.

The other places do need a close look, it seems that some of
them may not be needed (e.g. the one inside "if (reuse) { }" at
the top of do_wp_page() ... at the moment I'm struggling to see
what it manages to achieve).

Most of the rest are in cases where we are adding a new virtual
page (comments like "No need to invalidate - it was non-present
before").  These may also need to have the order shuffled, but
they seem unlikely to be the cause of a bug (it is unlikely
that an application has threads that branch to new anonymous
pages as they are being attached to the process).

So you are right that there may be some more work here, but
I wanted to get the one-liner that is a clear and obvious
bugfix posted without being cluttered with some less obvious
fixes.

-Tony
