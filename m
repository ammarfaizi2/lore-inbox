Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271069AbUJVKsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271069AbUJVKsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271068AbUJVKsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:48:05 -0400
Received: from holomorphy.com ([207.189.100.168]:50113 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271069AbUJVKsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:48:03 -0400
Date: Fri, 22 Oct 2004 03:47:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [1/4]: demand paging core
Message-ID: <20041022104734.GL17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212155170.3524@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410212155170.3524@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 09:56:27PM -0700, Christoph Lameter wrote:
> +static void scrub_one_pmd(pmd_t * pmd)
> +{
> +	struct page *page;
> +
> +	if (pmd && !pmd_none(*pmd) && !pmd_huge(*pmd)) {
> +		page = pmd_page(*pmd);
> +		pmd_clear(pmd);
> +		dec_page_state(nr_page_table_pages);
> +		page_cache_release(page);
> +	}
> +}

It would be nicer to fix the pagetable leak (over the lifetime of a
process) in the core instead of sprinkling hugetlb with this.


-- wli
