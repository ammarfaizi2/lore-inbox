Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWCIAIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWCIAIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWCIAIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:08:46 -0500
Received: from ozlabs.org ([203.10.76.45]:55962 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932622AbWCIAIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:08:44 -0500
Date: Thu, 9 Mar 2006 10:52:07 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: hugepage: Strict page reservation for hugepage inodes
Message-ID: <20060308235207.GB17590@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	"Zhang, Yanmin" <yanmin.zhang@intel.com>,
	Andrew Morton <akpm@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20060308102314.GB32571@localhost.localdomain> <200603081838.k28Icwg10327@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603081838.k28Icwg10327@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 10:38:58AM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Wednesday, March 08, 2006 2:23 AM
> > Yes.  This is a simplifying assumption.  I know of no real application
> > that will waste pages because of this behaviour.  If you know one,
> > maybe we will need to reconsider.
> > 
> > > I have an idea. How about to record all the start/end address of
> > > huge page mmaping of the inode? Long long ago, there was a patch at 
> > > http://marc.theaimsgroup.com/?l=lse-tech&m=108187931924134&w=2.
> > > Of course, we need port it to the latest kernel if this idea is better.
> > 
> > I know the patch - I was going to port it to the current kernel, but
> > came up with my patch instead, because it seemed like a simpler
> > approach.
> 
> I really think the Variable length reservation system is the way to go
> for tracking hugetlb commit.  It is more robust and in my opinion, it
> is better than traverse the page cache radix tree.  At least, you don't
> have to worry about all the race condition there.  Oh, it also can get
> rid of the hugetlb_instantiation_mutex that was introduced.  Someday,
> people is going to scream at you for serializing hugetlb fault path.

Well, not my decision, or yours I think.  wli?  akpm?

But I don't see that recording all the mapped ranges will avoid the
need for the fault serialization.  At least the version of apw's
reservation patch I looked at most recently would certainly still
suffer from the alloc/instantiate race on the last hugepage in the
system.  This is a different bug from that addressed by reservation
(of whichever form).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
