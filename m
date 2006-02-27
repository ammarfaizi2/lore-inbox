Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWB0Hmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWB0Hmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWB0Hmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:42:38 -0500
Received: from ozlabs.org ([203.10.76.45]:44259 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751612AbWB0Hmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:42:38 -0500
Date: Mon, 27 Feb 2006 18:26:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       kenneth.w.chen@intel.com,
       "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paul Mundt <lethal@linux-sh.org>, kkojima@rr.iij4u.or.jp,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] Enable mprotect on huge pages
Message-ID: <20060227072614.GD24422@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kenneth.w.chen@intel.com,
	"yanmin.zhang@intel.com" <yanmin.zhang@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Paul Mundt <lethal@linux-sh.org>, kkojima@rr.iij4u.or.jp,
	"Luck, Tony" <tony.luck@intel.com>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com> <20060224142844.77cbd484.akpm@osdl.org> <20060226230903.GA24422@localhost.localdomain> <1141018592.1256.37.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141018592.1256.37.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 01:36:32PM +0800, Zhang, Yanmin wrote:
> On Mon, 2006-02-27 at 07:09, David Gibson wrote:
> > On Fri, Feb 24, 2006 at 02:28:44PM -0800, Andrew Morton wrote:
> > > "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> > > >
> > > > From: Zhang, Yanmin <yanmin.zhang@intel.com>
> > > > 
> > > > 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn_t support hugetlb
> > > > mprotect. My patch against 2.6.16-rc3 enables this capability.
> > > > 
> > > 
> > > Well I suppose that makes sense.  It does assume that the normal pte
> > > protection-changing APIs do the right thing on all architectures which
> > > implement huge pages.  That's quite possibly the case, but we should
> > > confirm that.
> > 
> > Well, it will need to be huge_ptep_get_and_clear() below, not the
> > normal version.
> I will change it.
> 
> 
> >   But pte_modify should be ok.  I'm not sure
> > pte_present() is safe, either, !pte_none() is what we use elsewhere in
> > hugetlb.c.
> pte_present is used in some files while !pte_none is used 
> in other files. Anyway, I will change it to !pte_none.

But most importantly, pte_present() is not used in mm/hugetlb.c, the
generic part of the code.

> > And.. looks like lazy_mmu_prot_update() is unsafe, too.  The only arch
> > which has something here (ia64) has a function which does icache
> > flushes on PAGE_SIZE only.
> I already sent another patch to ia64 maillist to fix the issue.
> See http://marc.theaimsgroup.com/?l=linux-ia64&m=114066414720468&w=2
> 
> Thanks.
> 
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
