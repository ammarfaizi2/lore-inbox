Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWEDJVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWEDJVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWEDJVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:21:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:28584 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751454AbWEDJVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:21:25 -0400
Date: Thu, 4 May 2006 11:26:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bob Picco <bob.picco@hp.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060504092616.GA5831@elte.hu>
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au> <20060504013239.GG19859@localhost> <20060504083708.GA30853@elte.hu> <20060504091422.GA2346@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504091422.GA2346@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the same easy crash still happens if i enable CONFIG_NUMA:

btw., with CONFIG_NUMA off i get this warning during bootup:

BUG: pfn: 0003fff0, page: c404d840, order: 4
 [<c0104e7f>] show_trace+0xd/0xf
 [<c0104e96>] dump_stack+0x15/0x17
 [<c0163312>] free_pages_bulk+0x207/0x370
 [<c01642f9>] free_hot_cold_page+0x127/0x17c
 [<c016438d>] free_hot_page+0xa/0xc
 [<c01643e5>] __free_pages+0x56/0x6f
 [<c0172e14>] __vunmap+0xc1/0xed
 [<c0172f02>] vfree+0x3b/0x3e
 [<c0128865>] build_sched_domains+0xaf2/0xcde
 [<c0128a6a>] arch_init_sched_domains+0x19/0x1b
 [<c1bd3a67>] sched_init_smp+0x18/0x349
 [<c01003c6>] init+0xb9/0x2cb
 [<c0102005>] kernel_thread_helper+0x5/0xb

but this is nonfatal and the system is robust afterwards. (this warning 
is not present if CONFIG_NUMA is on) [Btw., in the NUMA test i also had 
CONFIG_MIGRATION enabled.]

	Ingo
