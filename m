Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266917AbUHITVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUHITVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266915AbUHITTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:19:16 -0400
Received: from holomorphy.com ([207.189.100.168]:13026 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266903AbUHITM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:12:58 -0400
Date: Mon, 9 Aug 2004 12:12:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Hirokazu Takahashi'" <taka@valinux.co.jp>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: Hugetlb demanding paging for -mm tree
Message-ID: <20040809191249.GT11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Hirokazu Takahashi' <taka@valinux.co.jp>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	"Seth, Rohit" <rohit.seth@intel.com>
References: <20040806210750.GT17188@holomorphy.com> <200408091819.i79IJ3Y12216@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091819.i79IJ3Y12216@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote on Friday, August 06, 2004 2:08 PM
>> update_mmu_cache() does not appear to check the size of the translation
>> to be established in many architectures. e.g. on arch/ia64/ it does
>> flush_icache_range(addr, addr + PAGE_SIZE) unconditionally, and only
>> sets PG_arch_1 on a single struct page. Similar comments apply to
>> sparc64 and ppc64; I didn't check any others.

On Mon, Aug 09, 2004 at 11:19:04AM -0700, Chen, Kenneth W wrote:
> I suppose this is fixable in update_mmu_cache() where it can check the
> type of pte and do appropriate sizing and other things.  ia64 would have
> to check the address instead of looking at the pte.

Yes, it's just a fair amount of document-hunting since there isn't
always easily cut-and-pasteable stuff (e.g. ITAG_MASK for larger page
sizes was omitted from the #ifdefs on sparc64).

As for ia64 checking addresses... ew, can't we just use long format
VHPT? The virtual placement constraints are nasty.


-- wli
