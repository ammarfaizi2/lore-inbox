Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWGNRRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWGNRRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWGNRRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:17:31 -0400
Received: from mga03.intel.com ([143.182.124.21]:47513 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1422647AbWGNRRa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:17:30 -0400
X-IronPort-AV: i="4.06,244,1149490800"; 
   d="scan'208"; a="66067037:sNHT2726694096"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] ia64: race flushing icache in COW path
Date: Fri, 14 Jul 2006 10:11:53 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A3CC204@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ia64: race flushing icache in COW path
Thread-Index: Acam81Uxwh8OcfMATeeEwkJT7UqDZwAdHOfg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: "Jason Baron" <jbaron@redhat.com>, <torvalds@osdl.org>, <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
X-OriginalArrivalTime: 14 Jul 2006 17:11:55.0045 (UTC) FILETIME=[9B4ADD50:01C6A768]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

@@ -1980,6 +1980,7 @@ static int do_swap_page(struct mm_struct
 	}
 
 	flush_icache_page(vma, page);
+	lazy_mmu_prot_update(pte);
 	set_pte_at(mm, address, page_table, pte);
 	page_add_anon_rmap(page, vma, address);
 

At first sight, this looks redundant ... but then I saw that
on ia64 "flush_icache_page()" is actually a no-op.  Perhaps
we can enter this in the next obfuscated C competition.

-Tony
