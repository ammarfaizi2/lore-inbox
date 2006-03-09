Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbWCIAax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWCIAax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWCIAax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:30:53 -0500
Received: from ozlabs.org ([203.10.76.45]:9884 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932627AbWCIAav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:30:51 -0500
Date: Thu, 9 Mar 2006 11:30:13 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: hugepage: Strict page reservation for hugepage inodes
Message-ID: <20060309003013.GF17590@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	"Zhang, Yanmin" <yanmin.zhang@intel.com>,
	Andrew Morton <akpm@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20060308235207.GB17590@localhost.localdomain> <200603090019.k290JDg13362@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603090019.k290JDg13362@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 04:19:13PM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Wednesday, March 08, 2006 3:52 PM
> > But I don't see that recording all the mapped ranges will avoid the
> > need for the fault serialization.  At least the version of apw's
> > reservation patch I looked at most recently would certainly still
> > suffer from the alloc/instantiate race on the last hugepage in the
> > system.
> 
> No, it doesn't.  Because with strict commit accounting, you know that
> every hugetlb page is accounted for.  So there is no backout path for
> multiple instantiation race.  Thread that lost in the race will always
> go back to retry in hugetlb_no_page().  And since reservation is also
> accounted in a global variable, total hugetlb pool won't fall below
> what was reserved plus what is in use.  Even if sys admin tries to
> reduce hugetlb pool, kernel won't release any pages that are
> reserved.

Hrm..ok.  Clearly I'm looking at the wrong version of the patch - what
I have is from the prefaulting days, anyway.

Though.. you must still need a backout path for PRIVATE mappings,
which would make the logic rather complex.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
