Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751841AbWBXEGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbWBXEGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 23:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWBXEGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 23:06:20 -0500
Received: from ozlabs.org ([203.10.76.45]:57996 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751838AbWBXEGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 23:06:19 -0500
Date: Fri, 24 Feb 2006 15:05:43 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Hugh Dickins'" <hugh@veritas.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix ia64 hugetlb_free_pgd_range
Message-ID: <20060224040543.GE28368@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Hugh Dickins' <hugh@veritas.com>,
	"Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060224024431.GC28368@localhost.localdomain> <200602240305.k1O35Ng06352@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240305.k1O35Ng06352@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 07:05:23PM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Thursday, February 23, 2006 6:45 PM
> > However... I suspect in fact that the transformations should be
> > unconditional.
> 
> No, that won't be correct.

But I don't see how not transforming them sometimes can be correct.
Suppose 'floor' is only a little way below 'addr' - addr will be
shifted down, but floor won't, so floor may now be above addr, which
will cause weird results.

Afaict the *only* thing floor and ceiling are used for is bounds
checking the address range we're examining.  How can that ever be
right if one address has been scaled down, but the other hasn't.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
