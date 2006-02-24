Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWBXCr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWBXCr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWBXCr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:47:26 -0500
Received: from ozlabs.org ([203.10.76.45]:40069 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750738AbWBXCrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:47:25 -0500
Date: Fri, 24 Feb 2006 13:46:44 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Hugh Dickins <hugh@veritas.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
Message-ID: <20060224024644.GD28368@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	Hugh Dickins <hugh@veritas.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060224001146.GC25101@localhost.localdomain> <200602240114.k1O1E4g05231@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240114.k1O1E4g05231@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 05:14:03PM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Thursday, February 23, 2006 4:12 PM
> > It doesn't really mean different things - "touches a hugepage
> > exclusive area" is the correct semantic, the ia64 implementation
> > doesn't quite encode that, but is equivalent for valid address
> > ranges.  (though I wonder if that's another bug associated with by
> > task-region-max patch, without that patch invalid address ranges can
> > slip through, so maybe it's possible on ia64 to create a normalpage VM
> > with its start in the address space gap and its end in the hugepage
> > region, ouch).
> 
> This is getting complicated that my little brain hurts.  There has been
> so many iterations that the semantic is ambiguous.  If the semantic is
> decided to be "overlap", then 

The semantic is "! is this range ok for a normalpage VMA", so that we
can do that check on the MAP_FIXED path.  That implies "overlap" -
except that if you assume it's passed a valid user address range in
the first place, then just checking the region is sufficient on ia64.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
