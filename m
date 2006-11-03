Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753378AbWKCQvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbWKCQvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbWKCQvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:51:12 -0500
Received: from cantor2.suse.de ([195.135.220.15]:27578 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753380AbWKCQvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:51:11 -0500
From: Andi Kleen <ak@suse.de>
To: Amul Shah <amul.shah@unisys.com>
Subject: Re: [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot when  reserving MP Tables located in high memory
Date: Fri, 3 Nov 2006 17:51:03 +0100
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>
References: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com> <200611030340.55952.ak@suse.de> <1162565722.19677.68.camel@ustr-linux-shaha1.unisys.com>
In-Reply-To: <1162565722.19677.68.camel@ustr-linux-shaha1.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611031751.04056.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Finally dropping that annoying fastboot list from cc. Please never include any closed 
mailing lists in l-k posts. Thanks]

>   That won't worked because in arch/86_64/kernel/e820.c, the exactmap
> parsing clobbers end_pfn_map.

That's a bug imho. It shouldn't do that.

end_pfn_map should be always the highest address in e820 so that we 
can access all firmware tables safely.

-Andi

> 
> static int __init parse_memmap_opt(char *p)
> {
> 	char *oldp;
> 	unsigned long long start_at, mem_size;
> 
> 	if (!strcmp(p, "exactmap")) {
> #ifdef CONFIG_CRASH_DUMP
> 		/* If we are doing a crash dump, we
> 		 * still need to know the real mem
> 		 * size before original memory map is
> 		 * reset.
> 		 */
> 		saved_max_pfn = e820_end_of_ram();
> #endif
> 		end_pfn_map = 0;
> 		e820.nr_map = 0;
> 		userdef = 1;
> 		return 0;
> 	}
