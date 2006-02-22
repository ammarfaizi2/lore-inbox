Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWBVC1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWBVC1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWBVC1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:27:06 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:8430 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1422647AbWBVC1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:27:00 -0500
Date: Wed, 22 Feb 2006 13:11:06 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Block reservation for hugetlbfs
Message-ID: <20060222021106.GB23574@localhost.localdomain>
Mail-Followup-To: David Gibson <dwg@au1.ibm.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <20060221022124.GA18535@localhost.localdomain> <43FA94B3.4040904@yahoo.com.au> <20060221233950.GB20872@localhost.localdomain> <43FBB292.1000304@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FBB292.1000304@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:38:42AM +1100, Nick Piggin wrote:
> David Gibson wrote:
> >On Tue, Feb 21, 2006 at 03:18:59PM +1100, Nick Piggin wrote:
> 
> >>This introduces
> >>tree_lock(r) -> hugetlb_lock
> >>
> >>And we already have
> >>hugetlb_lock -> lru_lock
> >>
> >>So we now have tree_lock(r) -> lru_lock, which would deadlock
> >>against lru_lock -> tree_lock(w), right?
> >>
> >>From a quick glance it looks safe, but I'd _really_ rather not
> >>introduce something like this.
> >
> >
> >Urg.. good point.  I hadn't even thought of that consequence - I was
> >more worried about whether I need i_lock or i_mutex to protect my
> >updates to i_blocks.
> >
> >Would hugetlb_lock -> tree_lock(r) be any preferable (I think that's a
> >possible alternative).
> >
> 
> Yes I think that should avoid the introduction of new lock dependency.

Err... "Yes" appears to contradict the rest of you statement, since my
suggestion would still introduce a lock dependency, just a different
one one.  It is not at all obvious to me how to avoid a lock
dependency entirely.

Also, any thoughts on whether I need i_lock or i_mutex or something
else would be handy..

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
