Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270640AbTHAAvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274867AbTHAAvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:51:55 -0400
Received: from holomorphy.com ([66.224.33.161]:41178 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270640AbTHAAvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:51:54 -0400
Date: Thu, 31 Jul 2003 17:53:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic on 2.6.0-test1-mm1
Message-ID: <20030801005310.GM15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <5110000.1059489420@[10.10.2.4]> <20030731223710.GI15452@holomorphy.com> <390810000.1059698875@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390810000.1059698875@flay>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>>         pgd_cache = kmem_cache_create("pgd",
>>                                 PTRS_PER_PGD*sizeof(pgd_t),
>>                                 0,
>>                                 SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
>>                                 pgd_ctor,
>>                                 PTRS_PER_PMD == 1 ? pgd_dtor : NULL);

On Thu, Jul 31, 2003 at 05:47:55PM -0700, Martin J. Bligh wrote:
> I think this was just virgin -mm1, I can go back and double check ...
> Not sure what the stuff about backing out other peoples patches was
> all about, I just pointed out the crash.

pgd_dtor() will never be called on PAE due to the above code (thanks to
the PTRS_PER_PMD check), _unless_ mingo's patch is applied (which backs
out the PTRS_PER_PMD check).


-- wli
