Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271384AbUJVPe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271384AbUJVPe3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271382AbUJVPe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:34:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41108 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S271375AbUJVPdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:33:54 -0400
Date: Fri, 22 Oct 2004 08:33:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [1/4]: demand paging core
In-Reply-To: <20041022104734.GL17038@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0410220832410.7868@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410212155170.3524@schroedinger.engr.sgi.com>
 <20041022104734.GL17038@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:

> On Thu, Oct 21, 2004 at 09:56:27PM -0700, Christoph Lameter wrote:
> > +static void scrub_one_pmd(pmd_t * pmd)
> > +{
> > +	struct page *page;
> > +
> > +	if (pmd && !pmd_none(*pmd) && !pmd_huge(*pmd)) {
> > +		page = pmd_page(*pmd);
> > +		pmd_clear(pmd);
> > +		dec_page_state(nr_page_table_pages);
> > +		page_cache_release(page);
> > +	}
> > +}
>
> It would be nicer to fix the pagetable leak (over the lifetime of a
> process) in the core instead of sprinkling hugetlb with this.

Yes, I contacted you yesterday about this. Could you take this on? CC me
on the patches and we will try to support you as best as we can.

