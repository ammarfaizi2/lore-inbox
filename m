Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266899AbUHITD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266899AbUHITD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUHITAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:00:41 -0400
Received: from holomorphy.com ([207.189.100.168]:7906 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266885AbUHIS7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:59:37 -0400
Date: Mon, 9 Aug 2004 11:59:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Hugetlb demanding paging for -mm tree
Message-ID: <20040809185928.GR11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Seth, Rohit" <rohit.seth@intel.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	Hirokazu Takahashi <taka@valinux.co.jp>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <01EF044AAEE12F4BAAD955CB7506494302005232@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01EF044AAEE12F4BAAD955CB7506494302005232@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W <mailto:kenneth.w.chen@intel.com> wrote on Monday,
>> I suppose this is fixable in update_mmu_cache() where it can check the
>> type of pte and do appropriate sizing and other things.  ia64 would
>> have 
>> to check the address instead of looking at the pte.

On Mon, Aug 09, 2004 at 11:43:32AM -0700, Seth, Rohit wrote:
> Why do we need update_mmu_cache for hugepages?

As things stand in mainline, it's not an obvious issue. Ken appears to
be calling it for hugetlb in the ZFOD fault handling patches, which
have the issue that it may behave badly in several respects when acting
on large pages. The cache coherency bits in update_mmu_fault() are
necessary in general, but mainline omits them. It should only result in
intermittent failures on machines with sufficiently incoherent caches.


-- wli
